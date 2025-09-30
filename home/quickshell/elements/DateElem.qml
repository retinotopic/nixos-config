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
    itemcount: 4;
    isscrollable: true;
    popupvisible: false

    BarContentItem {
        wdth: root.scalewidthmin
        hght: root.height
        item: Text {
            text: SysInfo2.clockdate
            verticalAlignment: Text.AlignVCenter
            font.pointSize:12
        }
        onBtnclick: {
           Settings.curridx = root.indx == Settings.curridx ? -1 : root.indx
        }
    }
}

