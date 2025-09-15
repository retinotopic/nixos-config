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
    index: 0;
    itemcount: 3;
    listmodel: AppLauncher.listm;
    windowwidth: parent.parent.width;
    isscrollable: true;
    popupvisible: false
    // widthmin:40
    invtrngl:true
    property bool inputactive: false
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
            root.inputactive = false
            root.popupvisible = false
        }
    }
    BarElem {
        visible: !root.inputactive
        wdth: root.scalewidthmin
        hght: root.height
        pointsize: 12
        txt: ""
        onBtnclick: {
            root.popupvisible = true
            root.inputactive = true
        }
    }
    InputItem {
        visible: root.inputactive
        wdth: root.scalewidthmin
        hght: root.height/1.5
        onTextedited: {
            AppLauncher.matchstr = gettext()
        }
    }
}
