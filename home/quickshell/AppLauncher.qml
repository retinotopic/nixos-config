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
        command:["bash" ,"fzfmenu.sh", root.matchstr]
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
                // myModel.clear()
                for (const line of lines) {
                    if (line.trim() === "") continue;
                    console.log("ABOBA")
                    const parts = line.split("/");
                    const appName = parts[parts.length - 1];
                    const desktopFile = line;
                    myModel.append({ 
                        name: appName, 
                        path: desktopFile 
                    });
                }
            }

        }
    }
    Process {
        id:listpid
        running: root.isexec
        command: [ "foot", root.pathname ]
        onExited: {
            root.isexec = false;
        }
    }
}
