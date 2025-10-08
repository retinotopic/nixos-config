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
    objectName: "Notifications"
    // clr: "#e67e80"
    // clrtrngl: "#d699b6"
    datamodel: Notifications.notifs;
    isscrollable: true;
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
        Layout.preferredWidth: root.scaleheightmin
        Layout.preferredHeight: root.scaleheightmin
        contentItem: TextItem {
            text: "󰎔"
        }
        onBtnclick: {
                Settings.curridx = root.indx == Settings.curridx ? -1 : root.indx
        }
    }
}
