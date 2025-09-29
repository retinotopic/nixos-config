
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
    itemcount: 2;
    windowwidth: parent.parent.width;
    isscrollable: true;
    popupvisible: false

    BarContentItem {
        wdth: root.scalewidthmin
        hght: root.height
        item: TextItem {
            text: "Menu"
        }
        onBtnclick: {
           Settings.curridx = root.indx == Settings.curridx ? -1 : root.indx
        }
    }
}


