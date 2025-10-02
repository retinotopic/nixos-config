
pragma Singleton

// pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Notifications

import Quickshell // for PanelWindow
import QtQuick // for Text
import QtQuick.Controls
import QtQuick.Layouts

Singleton {
    id: root
    
    property list<var> notifs: []

    NotificationServer {
        onNotification: function(notif) {
            root.notifs.push({
                body: notif.body,
                summary: notif.summary,
                appicon: notif.appIcon,
            });
            // myModel.sort
        }
    }
}
