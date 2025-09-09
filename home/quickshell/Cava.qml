pragma Singleton

pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property string output: "▁▁▁▁▁▁▁▁▁▁▁▁▁"
    property list<string> bars: ["▁","▁", "▂", "▃", "▄", "▅", "▆", "▇", "█"]
    property list<string> colors: ['#d3c6aa','#d3c6aa','#7fbbb3','#d699b6','#e67e80','#e69875','#dbbc7f','#a7c080','#83c092']
    // property list<int> values: Array(6)
    property int refCount: 13
    property bool cavaAvailable: false

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
        command: ["sh", "-c", `printf '[general]\\nmode=normal\\nframerate=25\\nautosens=0\\nsensitivity=30\\nbars=13\\nlower_cutoff_freq=50\\nhigher_cutoff_freq=12000\\n[output]\\nmethod=raw\\nraw_target=/dev/stdout\\ndata_format=ascii\\nchannels=mono\\nmono_option=average\\n[smoothing]\\nnoise_reduction=35\\nintegral=90\\ngravity=95\\nignore=2\\nmonstercat=1.5' | cava -p /dev/stdin`]

        onRunningChanged: {
            if (!running) {
                root.values = Array(6).fill(0)
            }
        }

        stdout: SplitParser {
            splitMarker: "\n"
            onRead: data => {
                if (root.refCount > 0 && data.trim()) {
                    var raw = data.split(";")
                    var full = ""
                    for (let i=0; i<raw.length; i++) {
                        let symb = bars[Number(raw[i])-1]
                        let clr = colors[Number(raw[i])-1]
                        full +='<font color='+'"'+clr+'"'+'>'+symb+'</font>'
                        // full += `{"text":"`+"<span foreground='#"+clr+"'>"+symb+"</span>"+`"}`
                    }
                    root.output = full
                    console.log(root.output)
                }
            }
        }
    }
}
