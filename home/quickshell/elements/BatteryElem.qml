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
    // RowLayout {
    //     LayoutMirroring.enabled: false
// ListView {
//     width: 200; height: 400

//     ListModel {
//         id: listModel
//         ListElement { type: "info"; ... }
//         ListElement { type: "switch"; ... }
//         ListElement { type: "swipe"; ... }
//         ListElement { type: "switch"; ... }
//     }

//     DelegateChooser {
//         id: chooser
//         role: "type"
//         DelegateChoice { roleValue: "info"; ItemDelegate { ... } }
//         DelegateChoice { roleValue: "switch"; SwitchDelegate { ... } }
//         DelegateChoice { roleValue: "swipe"; SwipeDelegate { ... } }
//     }

//     model: listModel
//     delegate: chooser
// }
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
        wdth: root.scalewidthmin-(root.height/2)+1
        hght: root.height
        item: TextItem {
            text: Battery.batteryLevel
            // horizontalAlignment: Text.AlignRight
            // Layout.alignment: Qt.AlignRight
            // verticalAlignment: Text.AlignVCenter
            // font.pointSize:12
        }
        onBtnclick: {
            Settings.curridx = root.indx == Settings.curridx ? -1 : root.indx
        }
    }
}
