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
    index: 0;
    itemcount: 2;
    listmodel: AppLauncher.listm;
    windowwidth: parent.parent.width;
    isscrollable: true;
    popupvisible: true
    invtrngl:true
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

    BarElem {
        wdth: root.scalewidthmin
        hght: root.height
        pointsize: 12
        txt: "󰀻"
        onBtnclick: {
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
