import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Wayland
import "./elements"
import "./services"

pragma ComponentBehavior: Bound

Variants {
    model: Quickshell.screens
    delegate: Window {
        id: panel
        required property ShellScreen modelData
        screen: modelData
        property real scalefW: width/Settings.scaleWidth
        property real scalefH: height/Settings.scaleHeight
        // height:500
        WlrLayershell.layer: WlrLayer.Overlay
        visible: true
        Rectangle {
            id: rwlt
            // spacing:0
            anchors.top: parent.top
            width: parent.width
            height: scaleheightmin
            property real minheight: 40
            property real scaleFactor: parent.width / Settings.scaleWidth
            property real scaleheightmin: scaleFactor*minheight
            RowLayout {
                id: left
                anchors.left: rwlt.left
                layoutDirection: Qt.LeftToRight
                Layout.alignment: Qt.AlignLeft
                height: rwlt.scaleheightmin
                spacing:0
                AppLauncherElem{ clr: Settings.colors[0][0]; clrtrngl: Settings.colors[0][1]; indx: 0}
                // NiriWorkspaceElem{ clr: Settings.colors[1][0]; clrtrngl: Settings.colors[1][1]; indx: 1}
                // CpuElem{ clr: Settings.colors[2][0]; clrtrngl: Settings.colors[2][1]; indx: 2}
                // DiskElem{ clr: Settings.colors[3][0]; clrtrngl: Settings.colors[3][1]; indx: 3}
                // MemoryElem{ clr: Settings.colors[4][0]; clrtrngl: Settings.colors[4][1]; indx: 4}
                // MenuElem{ clr: Settings.colors[5][0]; clrtrngl: Settings.colors[5][1]; indx: 5}
            }
            RowLayout {
                id: center
                anchors.centerIn: rwlt
                layoutDirection: Qt.LeftToRight
                Layout.alignment: Qt.AlignLeft
                height: rwlt.scaleheightmin
                spacing:0
                // NiriWindowElem{ clr: Settings.windowcolors[0]; clrtrngl: Settings.windowcolors[1]; indx: 6}
                // CavaElem{ clr: Settings.windowcolors[0]; clrtrngl: Settings.windowcolors[1]; indx: 7}
            }
            RowLayout {
                id: right
                anchors.right: rwlt.right
                height: rwlt.scaleheightmin
                layoutDirection: Qt.RightToLeft
                Layout.alignment: Qt.AlignRight
                spacing:0
                // NotificationsElem{ clr: Settings.colors[0][0]; clrtrngl: Settings.colors[0][1]; indx: 12}
                NetworkElem{ clr: Settings.colors[1][0]; clrtrngl: Settings.colors[1][1]; indx: 11}
                // BatteryElem{ clr: Settings.colors[2][0]; clrtrngl: Settings.colors[2][1]; indx: 10}
                AudioElem{ clr: Settings.colors[3][0]; clrtrngl: Settings.colors[3][1]; indx: 9}
                // DateElem{ clr: Settings.colors[4][0]; clrtrngl: Settings.colors[4][1]; indx: 8}
            }
        }



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

    }
}

