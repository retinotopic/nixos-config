import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Shapes
import QtQml
import "../services"
import "../"

pragma ComponentBehavior: Bound

BarItem {
    id:root
    index: 1;
    itemcount: 2;
    listmodel: Niri.listm;
    windowwidth: parent.parent.width;
    isscrollable: true;
    popupvisible: false;
    invtrngl:true
    HListViewItem {
        id:listv
        wdth: root.width
        hght: root.height
        listmodel: Niri.listm
        delegatecmpnnt: BarContentItem {
            required property string idx;
            required property string isActive;
            wdth: root.width
            hght: root.height
            item: Row {
                Text {id: maintxt1; text: idx}
                Text {id: maintxt2; text: isActive}
            }

            onBtnclick: {
               Settings.curridx = root.index == Settings.curridx ? -1 : root.index
               listv.positionViewAtBeginning()
               Niri.focusedWorkspaceIndex = maintxt1.text
               Niri.workspacefocus = true;
            }
        }

    }
    // ListView {
    //     id: listv
    //     layoutDirection:Qt.LeftToRight
    //     orientation:Qt.Horizontal
    //     // anchors.fill: root
    //     model: Niri.listm
    //     highlightFollowsCurrentItem :true
    //     implicitWidth: root.width
    //     implicitHeight: root.height
    //     Layout.alignment:Qt.AlignCenter
    //     // contentWidth: root.scalewidthmin
    //     // contentHeight: root.height
    //     delegate: Button {
    //         implicitWidth: root.scalewidthmin
    //         implicitHeight: root.scaleheightmin
    //         // Layout.alignment:Qt.AlignCenter
    //         background:null
    //         opacity:1
    //         id: execbutton
    //         // Text {id: maintxt1; text: id}
    //         Row {
    //             Text {id: maintxt1; text: idx}
    //             Text {id: maintxt2; text: isActive}
    //         }
    //         onClicked: {
    //            Settings.curridx = root.index == Settings.curridx ? -1 : root.index
    //            listv.positionViewAtBeginning()
    //            Niri.focusedWorkspaceIndex = maintxt1.text
    //            Niri.workspacefocus = true;
    //         }
    //     }
    // }



}

