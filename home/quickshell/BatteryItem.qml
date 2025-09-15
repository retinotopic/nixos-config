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
    invtrngl:false
    index: 6;
    itemcount: 2;
    windowwidth: parent.parent.width;
    isscrollable: false;
    popupvisible: false

    BarElem {
        wdth: root.scalewidthmin
        hght: root.height
        pointsize: 12
        txt: Battery.batteryLevel
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
