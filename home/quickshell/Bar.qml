import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets
import "./elements"

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
        //     right:0dowElem{ clr:
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
            AppLauncherElem{ clr: Settings.colors[0][0]; clrtrngl: Settings.colors[0][1];}
            NiriWorkspaceElem{ clr: Settings.colors[1][0]; clrtrngl: Settings.colors[1][1];}
            CpuElem{ clr: Settings.colors[2][0]; clrtrngl: Settings.colors[2][1];}
            DiskElem{ clr: Settings.colors[3][0]; clrtrngl: Settings.colors[3][1];}
            MemoryElem{ clr: Settings.colors[4][0]; clrtrngl: Settings.colors[4][1];}
        }
        BarItems {
            align:1 // Center
            NiriWindowElem{ clr: Settings.colors[6][1]; clrtrngl: Settings.colors[6][0];}
            CavaElem{ clr: Settings.colors[6][1]; clrtrngl: Settings.colors[6][0];}
        }
        BarItems {
            align:2 // Right
            AudioElem{ clr: Settings.colors[3][0]; clrtrngl: Settings.colors[3][1]; }
            BatteryElem{ clr: Settings.colors[2][0]; clrtrngl: Settings.colors[2][1]; }
            NetworkElem{ clr: Settings.colors[1][0]; clrtrngl: Settings.colors[1][1]; }
            NotificationsElem{ clr: Settings.colors[0][0]; clrtrngl: Settings.colors[0][1];}
            // tools: shutdown,restart,screenshot,lupa list: notif
        }
    }
}

