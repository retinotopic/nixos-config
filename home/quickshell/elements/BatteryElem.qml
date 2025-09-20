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
    index: 9;
    itemcount: 3;
    windowwidth: parent.parent.width;
    isscrollable: true;
    popupvisible: false

    BarContentItem {
        wdth: implicitContentWidth
        hght: root.height
        item: Text {
            id: txt
            text: "ABOBANVSNVJLSFNLVKNSKF"
            verticalAlignment: Text.AlignVCenter
            font.pointSize:12
        }
        onBtnclick: {
           Settings.curridx = root.index == Settings.curridx ? -1 : root.index
        }
    }
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
}
