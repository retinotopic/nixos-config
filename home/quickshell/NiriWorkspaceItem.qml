import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Shapes
import QtQml
import "./services"

BarItem {
    id:root
    index: 1;
    itemcount: 2;
    listmodel: Niri.listm;
    windowwidth: parent.parent.width;
    isscrollable: true;
    popupvisible: false;
    invtrngl:true
    ListView {
        id: listv
        layoutDirection:Qt.LeftToRight
        orientation:Qt.Horizontal
        // anchors.fill: root
        model: Niri.listm
        highlightFollowsCurrentItem :true
        implicitWidth: root.width
        implicitHeight: root.height
        Layout.alignment:Qt.AlignCenter
        // contentWidth: root.scalewidthmin
        // contentHeight: root.height
        delegate: Button {
            implicitWidth: root.scalewidthmin
            implicitHeight: root.scaleheightmin
            // Layout.alignment:Qt.AlignCenter
            background:null
            opacity:1
            id: execbutton
            // Text {id: maintxt1; text: id}
            Row {
                Text {id: maintxt1; text: idx}
                Text {id: maintxt2; text: isActive}
            }
            onClicked: {
               PopupState.curridx = root.index == PopupState.curridx ? -1 : root.index
               listv.positionViewAtBeginning()
               Niri.focusedWorkspaceIndex = maintxt1.text
               Niri.workspacefocus = true;
            }
        }
    }



    // Triangle {
    //     inverted:true
    //     hght:root.height
    //     clr:"red"
    // }
    // Button {
    //     Layout.preferredWidth: root.scalewidthmin
    //     Layout.preferredHeight: root.height

    //     opacity:0.4
    //     Layout.alignment:Qt.AlignCenter
    //     // anchors.fill: parent
    //     onClicked: {
    //        PopupState.curridx = root.index == PopupState.curridx ? -1 : root.index
    //     }
    // }
    // InputItem {
    //     wdth: root.scalewidthmin
    //     hght: root.height/1.5
    //     onTextedited: {
    //         // AppLauncher.matchstr = text
    //     }
    // }
}

