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
            BarItem {clr:"red";index:0}
            BarItem {clr:"green";index:1}
            BarItem {clr:"red";index:2}
            BarItem {clr:"yellow";index:3}
            BarItem {clr:"red";index:4}
        }
        BarItems {
            align:1 // Center
            BarItem {clr:"green";index:5}
            BarItem {clr:"blue";index:6}
            BarItem {clr:"red";index:7}
            BarItem {clr:"purple";index:8}
            BarItem {clr:"red";index:9}
        }
        BarItems {
            align:2 // Right
            BarItem {clr:"red";index:10}
            BarItem {clr:"black";index:11}
            BarItem {clr:"red";index:12}
            BarItem {clr:"red";index:13}
            BarItem {clr:"blue";index:14}
        }
    }
}

