
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
    isscrollable: true;
    popupvisible: false

    BarContentItem {
        id: barContent1
        Layout.preferredWidth: root.scaleheightmin
        Layout.preferredHeight: root.scaleheightmin
        contentItem: Text {
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
    SliderItem {
        implicitWidth:root.scaleheightmin*3
        implicitHeight:root.scaleheightmin
        id: sld
        start: 0
        initvalue: 0.3
        end: 1
        onSlidermoved: {
            Audio.setVolume(sld.val)
        }
    }
}


