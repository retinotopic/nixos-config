import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Shapes
import QtQml
import "./services"

pragma ComponentBehavior: Bound

BarItem {
    id:root
    index: 0;
    itemcount: 3;
    listmodel: AppLauncher.listm;
    windowwidth: parent.parent.width;
    isscrollable: true;
    popupvisible: false
    // widthmin:40
    invtrngl:true
    property bool inputactive: false
    delegatecmpnnt: Rectangle {
        id :del
        color: "transparent"
        implicitWidth:root.width
        implicitHeight:root.height
        required property string maintxt;
        required property string sectxt;
        RowLayout {
            spacing: -0.8
            anchors.centerIn:del
            Triangle { inverted:false; hght:root.height/1.5; clr:"#424b50"}
            BarElem {
                wdth: root.width-root.height
                hght: root.height/1.5
                clr: "#424b50"
                opac: 1
                item: Text {
                    text: del.maintxt
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pointSize:12
                }
                onBtnclick: {
                    AppLauncher.pathname = del.sectxt
                    console.log(AppLauncher.pathname)
                    AppLauncher.isexec = true;
                }
            }
            Triangle { inverted:true; hght:root.height/1.5; clr:"#424b50" }
        }
    }

    BarElem {
        wdth: root.scalewidthmin
        hght: root.height
        item: Text {
            text: "󰀻"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize:12
        }
        onBtnclick: {
            PopupState.curridx = root.index == PopupState.curridx ? -1 : root.index
            root.inputactive = false
            root.popupvisible = false
        }
    }
    BarElem {
        visible: !root.inputactive
        wdth: root.scalewidthmin
        hght: root.height
        item: Text {
            text: ""
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize:12
        }
        onBtnclick: {
            root.popupvisible = true
            root.inputactive = true
        }
    }
    InputItem {
        visible: root.inputactive
        wdth: root.scalewidthmin
        hght: root.height/1.5
        onTextedited: {
            AppLauncher.matchstr = gettext()
        }
    }
}
