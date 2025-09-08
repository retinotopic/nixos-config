import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Shapes
import QtQml

BarItem {
    id:root
    clr: "blue";
    index: 2;
    itemcount: 2;
    listmodel: Niri.listm1;
    windowwidth: parent.parent.width;
    isscrollable: true;
    popupvisible: false;
    property int curridx:0;
    ListView {
        id: listv
        layoutDirection:Qt.LeftToRight
        orientation:Qt.Horizontal
        anchors.fill: root
        model: Niri.listm1
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
            id: execbutton
            // Text {id: maintxt1; text: id}
            Text {id: maintxt2; text: idx}
            Text {id: maintxt3; text: isActive}
            onClicked: {
               PopupState.curridx = root.index == PopupState.curridx ? -1 : root.index
               listv.positionViewAtBeginning()
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

