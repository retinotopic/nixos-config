pragma Singleton

pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property string output: ""
    property list<string> bars: ["▁", "▂", "▃", "▄", "▅", "▆", "▇", "█"]
    property list<string> colors: ['#d3c6aa','#7fbbb3','#83c092','#a7c080','#dbbc7f','#e69875','#e67e80','#d699b6']
    property int refCount: 13
    property bool cavaAvailable: false
    // bar_map = {
    //     0: "⠁",
    //     1: "⠁",
    //     2: "⠃",
    //     3: "⠇",
    //     4: "⡇"
    //     }

    Process {
        id: cavaCheck

        command: ["which", "cava"]
        running: false
        onExited: exitCode => {
            root.cavaAvailable = exitCode === 0
        }
    }

    Component.onCompleted: {
        cavaCheck.running = true
    }

    Process {
        id: cavaProcess

        running: root.cavaAvailable && root.refCount > 0
        command: ["sh", "-c", `printf '[general]\\n
            sensitivity=150\\n
            bars=13\\n
            [output]\\n
            method=raw\\n
            raw_target=/dev/stdout\\n
            bit_format=16bit\\n
            data_format=ascii' | cava -p /dev/stdin`]

        onRunningChanged: {
            if (!running) {
                root.output = ""
            }
        }

        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                if (root.refCount > 0 && data.trim()) {
                    const raw = data.split(";");
                    var full = ""
                    for (let i=0; i<raw.length; i++) {
                        // console.log(Number(raw[i]))
                        let symidx = Math.trunc(Number(raw[i]) * bars.length / 1000)
                        if (symidx >= bars.length) {
                            symidx = bars.length - 1
                        }
                        let clridx = Math.trunc(Number(raw[i]) * colors.length / 1000)
                        if (clridx >= colors.length) {
                            clridx = colors.length- 1
                        }
                        // console.log(Number(raw[i]),clridx,symidx)

                        full +='<font color='+'"'+colors[clridx]+'"'+'>'+bars[symidx]+'</font>'
                    }
                    root.output = full
                }
            }
        }
    }
}
