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
            AppLauncherItem{}
            NiriItem{}
            AppLauncherItem{}
            AppLauncherItem{}
        }
        BarItems {
            align:1 // Center
            AppLauncherItem{}
            AppLauncherItem{}
            AppLauncherItem{}
        }
        BarItems {
            align:2 // Right
            AppLauncherItem{}
            AppLauncherItem{}
            AppLauncherItem{}
            NetworkItem{}
        }
    }
}

