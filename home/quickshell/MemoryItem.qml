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
    invtrngl:true
    index: 4;
    itemcount: 2;
    windowwidth: parent.parent.width;
    isscrollable: true;
    popupvisible: false

    BarElem {
        wdth: root.scalewidthmin
        hght: root.height
        item: Text {
            text: SysInfo.memoryUsage
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize:12
        }
        onBtnclick: {
           PopupState.curridx = root.index == PopupState.curridx ? -1 : root.index
        }
    }
}


