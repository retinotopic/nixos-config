import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Shapes
import QtQml
import "../services"
import "../decorations"
import "../"

pragma ComponentBehavior: Bound

BarItem {
    id:root
    objectName:"AppLauncher"
    datamodel: AppLauncher.apps;
    isscrollable: true;
    popupvisible: false
    invtrngl: true
    isPopupEmbedded: false
    
    property bool inputactive: false
    delegatecmpnnt: ListDelegateItem {
        id: del
        required property string appname;
        required property string appicon;
        required property int index
        implicitWidth: root.contentWidth
        implicitHeight: root.scaleheightmin
        decor: DecorTriangleItem {
            clr: Settings.colorpick(root.clr,del.index)
        }
        BarContentItem {
            id: barcnt
            implicitWidth: root.contentWidth
            implicitHeight: root.scaleheightmin
            scale:0.9
            contentItem: Item {
                id:rl
                width: barcnt.width
                height: barcnt.height
                Image {
                    scale:0.8
                    anchors.left: parent.left
                    width: rl.height
                    height: rl.height
                    Layout.alignment: Qt.AlignCenter
                    source:del.appicon
                }
                TextItem {
                    anchors.right: parent.right
                    width: rl.width-rl.height
                    height: rl.height
                    text: del.appname
                }
            }
            onBtnclick: {
                AppLauncher.pathname = del.sectxt
                console.log(AppLauncher.pathname)
                AppLauncher.isexec = true;
            }
        }
    }
    
    BarContentItem {
        implicitSize:root.scaleheightmin
        contentItem: TextItem {
            // implicitSize: root.scaleheightmin
            text: "󰀻"
        }
        onBtnclick: {
            Settings.curridx = root.indx == Settings.curridx ? -1 : root.indx
            root.inputactive = false
            root.popupvisible = false
        }
    }

    BarContentItem {
        visible: !root.inputactive
        implicitSize:root.scaleheightmin
        contentItem: TextItem {
            text: ""
        }
        onBtnclick: {
            root.popupvisible = true
            root.inputactive = true
        }
    }

    InputItem {
        id: input
        decor: DecorTriangleItem {
            clr: Settings.dark
        }
        visible: root.inputactive
        implicitWidth:root.scaleheightmin*5
        implicitHeight:root.scaleheightmin
        onTextedited: {
            AppLauncher.searchApplications(gettext())
        }
    }

}
