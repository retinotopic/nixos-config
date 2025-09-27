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
    // property ObjectModel<var> apps: []
    property list<var> apps: []
    property string matchstr: "btop"

    readonly property var applications: DesktopEntries.applications.values

    function searchApplications(query) {
        apps = []
        const matches = applications.filter(word => word.name.includes(query));
        // const queryLower = query.toLowerCase().trim()
        for (const app of matches) {
            const name = (app.name || "").toLowerCase()
            const genericName = (app.genericName || "").toLowerCase()
            const comment = (app.comment || "").toLowerCase()
            const keywords = app.keywords ? app.keywords.map(k => k.toLowerCase()) : []

            // console.log(app.name)
            try {
                apps.push({
                    appname:  app.name
                });
            } catch (err) {
                console.log(err)
            }
        }
    }
}
