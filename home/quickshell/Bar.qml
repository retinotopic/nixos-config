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

        // notifications popup
        HListViewItem {
            id: listvw
            wdth: 280*panel.scalefW
            hght: panel.height
            interactive:false
            // anchors.fill:parent
            anchors {
                right: parent.right
                top: parent.top
            }
            datamodel: Notifications.notifs
            horizontal:false
            // displayMarginBeginning:300
            // leftMargin:200
            // interactive:false
            anchors.topMargin: 50*panel.scalefW
            anchors.rightMargin: -50*panel.scalefW
            delegatecmpnnt: SwipeDelegate {
                id: del
                // text: body + " - " + summary
                // active
                width: listvw.width
                height: 40*panel.scalefH
                required property string body
                required property string summary
                required property string appicon
                required property int index
                swipe.left: Rectangle {
                    color: "transparent"
                    anchors.fill: del
                }
                swipe.onCompleted: {
                    Notifications.notifs.splice(del.index, 1);
                    console.log("deleted",del.index)
                }
                background:null
                // ListView.onRemove: removeAnimation.start()
                contentItem: ListDelegateItem {
                    enabled:false
                    id: innerdel
                    wdth:del.width
                    hght:del.height
                    idx: del.index
                    isImplicit:false
                    excludedColor:root.clr
                    BarContentItem {
                        wdth: innerdel.width
                        hght: innerdel.height
                        item: RowLayout {
                            id:rl
                            Image {
                                scale:0.8
                                Layout.preferredWidth: rl.height
                                Layout.preferredHeight: rl.height
                                Layout.alignment: Qt.AlignCenter
                                source:del.appicon
                            }
                            TextItem {
                                Layout.preferredWidth: rl.width-rl.height
                                Layout.preferredHeight: rl.height
                                text: del.summary
                            }
                        }
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

