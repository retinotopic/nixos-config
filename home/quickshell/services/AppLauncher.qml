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
    property string matchstr: "btop"

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

}
