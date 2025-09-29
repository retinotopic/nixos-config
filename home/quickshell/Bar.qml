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
        // height:500
        WlrLayershell.layer: WlrLayer.Overlay
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
        HListViewItem {
            id: listvw
            wdth: 280*(panel.width/Settings.scaleWidth)
            hght: Settings.scaleHeight*(panel.height/Settings.scaleHeight)
            // anchors.fill:parent
            anchors.right: parent.right
            datamodel: Notifications.listm
            horizontal:false
            delegatecmpnnt: ListDelegateItem {
                id: del
                
                required property int index
                required property string body;
                required property string summary;
                wdth: listvw.width
                hght: 40*(panel.height/Settings.scaleHeight)
                idx: index
                excludedColor:"black"
                Component.onCompleted: {
                    console.log("visral")
                }
                BarContentItem {
                    wdth: del.width
                    hght: del.height
                    item: TextItem {
                        text: del.summary
                    }
                    onBtnclick: {
                    }
                }
            }
        }

        BarItems {
            // windowwidth: panel.width
            align:0 // Left
            // Triangle { inverted:true; hght:root.height;clr:"red"; }
            AppLauncherElem{ clr: Settings.colors[0][0]; clrtrngl: Settings.colors[0][1]; indx: 0}
            NiriWorkspaceElem{ clr: Settings.colors[1][0]; clrtrngl: Settings.colors[1][1]; indx: 1}
            CpuElem{ clr: Settings.colors[2][0]; clrtrngl: Settings.colors[2][1]; indx: 2}
            DiskElem{ clr: Settings.colors[3][0]; clrtrngl: Settings.colors[3][1]; indx: 3}
            MemoryElem{ clr: Settings.colors[4][0]; clrtrngl: Settings.colors[4][1]; indx: 4}
            MenuElem{ clr: Settings.colors[5][0]; clrtrngl: Settings.colors[5][1]; indx: 5}
        }
        BarItems {
            // windowwidth: panel.width
            align:1 // Center
            NiriWindowElem{ clr: Settings.windowcolors[0]; clrtrngl: Settings.windowcolors[1]; indx: 6}
            CavaElem{ clr: Settings.windowcolors[0]; clrtrngl: Settings.windowcolors[1]; indx: 7}
        }
        BarItems {
            // windowwidth: panel.width
            align:2 // Right
            DateElem{ clr: Settings.colors[4][0]; clrtrngl: Settings.colors[4][1]; indx: 8}
            AudioElem{ clr: Settings.colors[3][0]; clrtrngl: Settings.colors[3][1]; indx: 9}
            BatteryElem{ clr: Settings.colors[2][0]; clrtrngl: Settings.colors[2][1]; indx: 10}
            NetworkElem{ clr: Settings.colors[1][0]; clrtrngl: Settings.colors[1][1]; indx: 11}
            NotificationsElem{ clr: Settings.colors[0][0]; clrtrngl: Settings.colors[0][1]; indx: 12}
            // tools: shutdown,restart,screenshot,lupa list: notif
        }
    }
}

