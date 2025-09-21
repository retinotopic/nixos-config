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
    // property ObjectModel<var> desktopapps: []
    property list<var> desktopapps: []
    property ListModel listm: ListModel {id: myModel}
    property string matchstr: "btop"
    property bool isrunning:false
    property string pathname
    property bool isexec:false

    readonly property var applications: DesktopEntries.applications.values


    function searchApplications(query) {
        desktopapps = [];
        console.log("CLEAREd")
        // if (!query || query.length === 0)
        //     return applications
        // if (applications.length === 0)
        //     return []

        // const queryLower = query.toLowerCase().trim()

        for (const app of applications) {
            // const name = (app.name || "").toLowerCase()
            // const genericName = (app.genericName || "").toLowerCase()
            // const comment = (app.comment || "").toLowerCase()
            // const keywords = app.keywords ? app.keywords.map(k => k.toLowerCase()) : []

            console.log(app.name)
            try {
                desktopapps.push({
                    appname:  app.name
                });
            } catch (err) {
                console.log(err)
            }
        }
        console.log("AFTER:", Object.getOwnPropertyNames(root.desktopapps));

        console.log(desktopapps)

        // root.desktopapps.sort((a, b) => b.score - a.score)
        // root.desktopapps.slice(0, 50).map(item => item.app)
    }

    Process {
        id:pid
        running:root.isrunning
        command: ["sh" ,"-c",`query="$1"
        appdirs=$(echo "$XDG_DATA_DIRS:-/usr/local/share:/usr/share" \
          | tr ':' '\n' \
          | sed 's|$|/applications|')
        
        for d in $appdirs; do
          for file in "$d"/*.desktop; do
            [ -f "$file" ] || continue
            filename=$(grep -m1 '^Name=' "$file" | cut -d= -f2-)
            if [ -z "$query" ] || echo "$filename" | grep -iq "$query"; then
              echo "$filename|||$file"
            fi
          done
        done
        ` ,"--",root.matchstr]
        onExited: {
            root.isrunning = false;
        }
        onCommandChanged: {
            root.searchApplications(root.matchstr)
        }

        stdout: SplitParser {
            onRead: data => {
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
