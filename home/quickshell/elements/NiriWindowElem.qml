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

BarItem {
    id:root
    itemcount: 1;
    isscrollable: false;
    popupvisible: false;
    invtrngl: false
    // listmodel: {}
    // delegatecmpnnt:{}
    Text {
        Layout.preferredWidth: root.scalewidthmin
        Layout.preferredHeight: root.height
        id: inp
        // clip:true
        text: "ABOBA"
        // text: Niri2.focusedWindowTitle
        // focus:true
        color: "black"
        // Layout.fillHeight: true
        // Layout.fillWidth: true
        opacity:0.4
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
    //        PopupState.curridx = root.indx == PopupState.curridx ? -1 : root.indx
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


