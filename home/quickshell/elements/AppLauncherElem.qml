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

pragma ComponentBehavior: Bound

BarItem {
    id:root
    itemcount: 4;
    datamodel: AppLauncher.apps;
    isscrollable: true;
    popupvisible: false
    invtrngl:true
    property bool inputactive: false
    delegatecmpnnt: ListDelegateItem {
        id: del
        required property string appname;
        required property string appicon;
        required property int index
        implicitWidth: root.contentWidth
        implicitHeight: root.scaleheightmin
        idx: index
        excludedColor:root.clr
        BarContentItem {
            id: barcnt
            implicitWidth: root.contentWidth
            implicitHeight: root.scaleheightmin
            
            contentItem: RowLayout {
                id:rl
                Layout.fillHeight: true
                Layout.fillWidth: true
                Image {
                    scale:0.8
                    Layout.preferredWidth: rl.height
                    Layout.preferredHeight: rl.height
                    Layout.alignment: Qt.AlignCenter
                    source:del.appicon
                }
                TextItem {
                    Layout.preferredWidth: rl.width-rl.height
                    Layout.preferredHeight: rl.height
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
            implicitWidth:root.scaleheightmin*3
            implicitHeight:root.scaleheightmin
            clr: Settings.dark
        }
        visible: root.inputactive
        implicitWidth:root.scaleheightmin*3
        implicitHeight:root.scaleheightmin
        onTextedited: {
            AppLauncher.searchApplications(gettext())
        }
    }

}
