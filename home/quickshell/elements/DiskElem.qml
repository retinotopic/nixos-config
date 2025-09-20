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
    invtrngl:true
    index: 3;
    itemcount: 2;
    windowwidth: parent.parent.width;
    isscrollable: true;
    popupvisible: false

    BarContentItem {
        wdth: root.scalewidthmin
        hght: root.height
        item: Text {
            text: SysInfo.diskUsage
            verticalAlignment: Text.AlignVCenter
            font.pointSize:12
        }
        onBtnclick: {
           Settings.curridx = root.index == Settings.curridx ? -1 : root.index
        }
    }
}


