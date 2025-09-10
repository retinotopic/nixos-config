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
    clr: "#e69875";
    clrtrngl: "#e67e80";
    index: 4;
    itemcount: 2;
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

    Button {
        Layout.preferredWidth: root.scalewidthmin
        Layout.preferredHeight: root.height

        opacity:0
        Layout.alignment:Qt.AlignCenter
        // anchors.fill: parent
        onClicked: {
           PopupState.curridx = root.index == PopupState.curridx ? -1 : root.index
        }
    }
}
