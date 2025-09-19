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
    index: 5;
    itemcount: 3;
    listmodel: Network.listm;
    windowwidth: parent.parent.width;
    isscrollable: true;
    popupvisible: true
    invtrngl:false
    delegatecmpnnt: Button {
        implicitWidth: root.width
        implicitHeight: scaleheightmin
        Layout.alignment:Qt.AlignCenter
        id: execbutton
        RowLayout {
            
            // Text {id: maintxt1; text: active}
            // Text {id: maintxt2; text: strength}
            // Text {id: maintxt3; text: frequency}
            Text {id: maintxt4; text: ssid}
            Text {id: maintxt5; text: bssid}
            Text {id: maintxt6; text: security}
        }
        onClicked: {
            // AppLauncher.pathname = sectext.text
            // console.log(AppLauncher.pathname)
            // AppLauncher.isexec = true;
        }
    }


    // Triangle {
    //     inverted:true
    //     hght:root.height
    //     clr:"red"
    // }
    Button {
        Layout.preferredWidth: root.scalewidthmin
        Layout.preferredHeight: root.height

        opacity:0
        Layout.alignment:Qt.AlignCenter
        // anchors.fill: parent
        onClicked: {
           Settings.curridx = root.index == Settings.curridx ? -1 : root.index
        }
    }
    InputItem {
        wdth: root.scalewidthmin
        hght: root.height/1.5
        onTextedited: {
            // AppLauncher.matchstr = text
        }
    }
}
