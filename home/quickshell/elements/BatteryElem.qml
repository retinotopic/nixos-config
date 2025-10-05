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
            Battery.brightness = sld.val
            Battery.changeBrightness = true
        }
    }
    BarContentItem {
        Layout.preferredWidth: root.scaleheightmin
        Layout.preferredHeight: root.scaleheightmin
        item: TextItem {
            text: Battery.batteryLevel
        }
        onBtnclick: {
            Settings.curridx = root.indx == Settings.curridx ? -1 : root.indx
        }
    }
}
