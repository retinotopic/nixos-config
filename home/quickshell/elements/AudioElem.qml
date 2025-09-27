
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

    Slider {
        implicitWidth:root.scalewidthmin
        id: sld
        from: 0
        value: 0.3
        to: 1
        onMoved: {
            Audio.setVolume(value)
        }
    }
    BarContentItem {
        id: barContent1
        wdth: root.scalewidthmin
        hght: root.height
        item: Text {
            text: Math.round(Audio.volume*100)
            verticalAlignment: Text.AlignVCenter

            horizontalAlignment: Text.AlignHCenter
            font.pointSize:12
            clip:true
        }
        onBtnclick: {
           Settings.curridx = root.indx == Settings.curridx ? -1 : root.indx
        }
    }
}


