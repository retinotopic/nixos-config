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
    itemcount: 2;
    windowwidth: parent.parent.width;
    isscrollable: true;
    popupvisible: false

    SliderItem {
        wdth:root.scalewidthmin
        hght: root.height
        id: sld
        start: 1
        initvalue: 50
        end: 255
        onSlidermoved: {
            // console.log("HAH",sld,val)
            Battery.brightness = sld.val
            Battery.changeBrightness = true
        }
    }
    BarContentItem {
        wdth: root.scalewidthmin
        hght: root.height
        item: TextItem {
            text: Battery.batteryLevel
            horizontalAlignment: Text.AlignRight
            // Layout.alignment: Qt.AlignRight
            // verticalAlignment: Text.AlignVCenter
            font.pointSize:12
        }
        onBtnclick: {
           Settings.curridx = root.indx == Settings.curridx ? -1 : root.indx
        }
    }
}
