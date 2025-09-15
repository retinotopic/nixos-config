pragma Singleton

import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets
import QtQml.Models

Singleton {
    id:root
    property ListModel listm: ListModel {id: myModel}
    property string matchstr: "btop"
    property bool isrunning:false

    property string pathname
    property bool isexec:false

    Process {
        id:pid
        running:root.isrunning
        command:["bash" ,"apps.sh", root.matchstr]
        onExited: {
            root.isrunning = false;
        }
        onCommandChanged: {
            myModel.clear()
            // AppLauncher.matchstr = "sd"
            console.log(AppLauncher.matchstr)
            root.isrunning = true;
        }
        stdout: SplitParser {
            onRead: data => {
                const lines = data.toString().trim().split("\n");
                console.log("entry")
                for (const line of lines) {
                    if (line.trim() === "") continue;
                    const parts = line.split("|||");
                    myModel.append({ 
                        maintxt: parts[0], 
                        sectxt: parts[1] 
                    });
                    console.log(parts[0],parts[1])
                }
            }
        }
    }
    Process {
        id:listpid
        running: root.isexec
        command: [ "dex", "-w", "--term", "foot", root.pathname ]
        onStarted: {
            startDetached()
            root.isexec = false
        }
    }
}
