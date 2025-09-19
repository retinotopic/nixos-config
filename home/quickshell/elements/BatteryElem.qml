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
    invtrngl:false
    index: 6;
    itemcount: 2;
    windowwidth: parent.parent.width;
    isscrollable: false;
    popupvisible: false

    BarContentItem {
        wdth: root.scalewidthmin
        hght: root.height
        item: Text {
            text: Battery.batteryLevel
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize:12
        }
        onBtnclick: {
           Settings.curridx = root.index == Settings.curridx ? -1 : root.index
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
