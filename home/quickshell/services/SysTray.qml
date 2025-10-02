pragma Singleton

import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets
import QtQml.Models
import Quickshell.Services.SystemTray


Singleton {
    id:root
    property list<var> systrayitems: []
    readonly property list<SystemTrayItem> systrayItems: SystemTray.items.values

    function systraydo() {
        systrayitems = []
        for (const item of systrayItems) {
            const icon = (item.icon || "").toLowerCase()
            console.log(icon,"ASDmkldfldsk")

            try {
                systrayitems.push({
                    iconsrc:  icon,
                });
            } catch (err) {
                console.log(err)
            }
        }
    }
    // onSystrayItemsChanged: {
    //     systrayitems = []
    //     for (const item of systrayItems) {
    //         const icon = (item.icon || "").toLowerCase()
    //             console.log(icon,"ASDmkldfldsk")

    //         try {
    //             systrayitems.push({
    //                 iconsrc:  icon,
    //             });
    //         } catch (err) {
    //             console.log(err)
    //         }
    //     }
        
    // }
}

