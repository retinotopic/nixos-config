
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
    property ListModel listm: ListModel {id: myModel}
    
    NotificationServer {
        onNotification: function(notif) {
            myModel.append({
                body: notif.body,
                summary: notif.summary,
            });
        }
    }
}
