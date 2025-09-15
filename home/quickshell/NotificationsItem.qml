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
    index: 4;
    itemcount: 2;
    // clr: "#e67e80"
    // clrtrngl: "#d699b6"
    listmodel: Notifications.listm;
    windowwidth: parent.parent.width;
    isscrollable: false;
    popupvisible: true
    invtrngl:false

    delegatecmpnnt: Button {
        required property string body
        required property string summary
        implicitWidth: root.width
        implicitHeight: scaleheightmin
        Layout.alignment:Qt.AlignCenter
        id: execbutton
        Text { id:text1; text: body }
        Text { id:text2; text: summary }
    }

    BarElem {
        wdth: root.scalewidthmin
        hght: root.height
        pointsize: 12
        txt: "󰎔"
        onBtnclick: {
           PopupState.curridx = root.index == PopupState.curridx ? -1 : root.index
        }
    }
}
