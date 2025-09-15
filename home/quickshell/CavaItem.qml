
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
    index: 3;
    itemcount: 1;
    windowwidth: parent.parent.width;
    isscrollable: false;
    popupvisible: false;
    widthmin: 180
    invtrngl:true
    // listmodel: {}
    // delegatecmpnnt:{}
    Text {
        Layout.preferredWidth: root.scalewidthmin
        Layout.preferredHeight: root.height
        horizontalAlignment: TextInput.AlignHCenter
        verticalAlignment: TextInput.AlignVCenter
        id: inp
        font.pointSize:12
        // clip:true
        text: Cava.output
        textFormat: Text.RichText
        // focus:true
        // color: "black"
        // Layout.fillHeight: true
        // Layout.fillWidth: true
        // opacity:1
        Layout.alignment:Qt.AlignCenter
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


