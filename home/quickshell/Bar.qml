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
    delegate: PanelWindow {
        id: panel
        required property ShellScreen modelData
        screen: modelData
        property real scalefW: width/Settings.scaleWidth
        property real scalefH: height/Settings.scaleHeight
        height: modelData.height
        WlrLayershell.layer: WlrLayer.Top
        visible: true
        color: "transparent"
        exclusionMode: ExclusionMode.Ignore
        focusable:true
        Connections {
            target: Settings
            function onPopupOpenChanged() {
                inreg.childrenChanged()

            }
        }
        mask: Region {
            item: rwlt
            id: inreg
            onChanged: {
                console.log("HEH")
            }
            Region {
                item: Settings.popupLoader
                intersection: Intersection.Combine
            }
        }

        Rectangle {
            id: rwlt
            // spacing:0
            color: "transparent"
            anchors.top: parent.top
            width: parent.width
            height: scaleheightmin
            property real minheight: 40
            property real scaleFactor: parent.width / Settings.scaleWidth
            property real scaleheightmin: scaleFactor*minheight
            RowLayout {
                id: left
                objectName: "left"
                anchors.left: rwlt.left
                // anchors.fill: rwlt
                layoutDirection: Qt.LeftToRight
                // Layout.alignment: Qt.AlignLeft
                height: rwlt.scaleheightmin
                // width: panel.width/3
                // Layout.maximumWidth: panel.width/3
                spacing:0
                // NiriWorkspaceElem{ indx: 1}
                CpuElem{}
                DiskElem{}
                AppLauncherElem{}
                // MemoryElem{ indx: 4}
                // MenuElem{ indx: 5}
            }
            RowLayout {
                id: center
                objectName: "center"
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
                objectName: "right"
                anchors.right: rwlt.right
                height: rwlt.scaleheightmin
                layoutDirection: Qt.RightToLeft
                // Layout.alignment: Qt.AlignRight
                spacing:0
                NotificationsElem{ }
                NetworkElem{ }
                // BatteryElem{ indx: 10}
                AudioElem{ }
                // DateElem{ indx: 8}
            }
        }



        anchors {
            left: true
            top: true
            right: true
            bottom:false
        }
        margins {
            top:0
            right:0
            left:0
            bottom:0
        }

    }
}

