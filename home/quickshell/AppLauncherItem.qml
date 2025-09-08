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
    index: 0;
    itemcount: 2;
    listmodel: AppLauncher.listm;
    windowwidth: parent.parent.width;
    isscrollable: true;
    popupvisible: true
    delegatecmpnnt: Button {
        implicitWidth: root.width
        implicitHeight: scaleheightmin
        Layout.alignment:Qt.AlignCenter
        id: execbutton
        Text { id:maintext; text: maintxt }
        Text { id:sectext; text: sectxt; visible:false }
        onClicked: {
            AppLauncher.pathname = sectext.text
            console.log(AppLauncher.pathname)
            AppLauncher.isexec = true;
        }
    }

    Button {
        Layout.preferredWidth: root.scalewidthmin
        Layout.preferredHeight: root.height

        opacity:0.4
        Layout.alignment:Qt.AlignCenter
        // anchors.fill: parent
        onClicked: {
           PopupState.curridx = root.index == PopupState.curridx ? -1 : root.index
        }
    }
    InputItem {
        wdth: root.scalewidthmin
        hght: root.height/1.5
        onTextedited: {
            AppLauncher.matchstr = gettext()
        }
    }
}
