import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets

Variants {
  model: Quickshell.screens

    delegate: Window {
        id: panel
        required property ShellScreen modelData
        screen: modelData
        height:150
        visible: true
        // anchors {
        //     left: true
        //     top: true
        //     right: true
        //     bottom:false
        // }
        // margins {
        //     top:0
        //     right:0
        //     left:0
        //     bottom:0
        // }
        // RowLayout {
        //     id: barfull
        //     spacing:0
        //     Layout.alignment: Qt.AlignTop
    
        BarItems {
            align:0 // Left
            // Triangle { inverted:true; hght:root.height;clr:"red"; }
            AppLauncherItem{ clr: Settings.colors[0][0]; clrtrngl: Settings.colors[0][1];}
            NiriWorkspaceItem{ clr: Settings.colors[1][0]; clrtrngl: Settings.colors[1][1];}
        }
        BarItems {
            align:1 // Center
            NiriWindowItem{ clr: Settings.colors[6][1]; clrtrngl: Settings.colors[6][0];}
            CavaItem{ clr: Settings.colors[6][1]; clrtrngl: Settings.colors[6][0];}
        }
        BarItems {
            align:2 // Right
            BatteryItem{ clr: Settings.colors[2][0]; clrtrngl: Settings.colors[2][1]; }
            NetworkItem{ clr: Settings.colors[1][0]; clrtrngl: Settings.colors[1][1]; }
            NotificationsItem{ clr: Settings.colors[0][0]; clrtrngl: Settings.colors[0][1];}
            // tools: shutdown,restart,screenshot,lupa list: notif
        }
    }
}

