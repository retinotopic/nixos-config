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
    itemcount: 2;
    // clr: "#e67e80"
    // clrtrngl: "#d699b6"
    datamodel: Notifications.notifs;
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

    BarContentItem {
        wdth: root.scalewidthmin
        hght: root.height
        item: Text {
            text: "󰎔"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize:12
        }
        onBtnclick: {
           Settings.curridx = root.indx == Settings.curridx ? -1 : root.indx
        }
    }
}
