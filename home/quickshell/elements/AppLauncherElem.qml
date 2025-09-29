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
    itemcount: 3;
    datamodel: AppLauncher.apps;
    isscrollable: true;
    popupvisible: false
    // widthmin:40
    invtrngl:true
    property bool inputactive: false
    delegatecmpnnt: ListDelegateItem {
        id: del
        required property string appname;
        required property int index
        wdth:root.width
        hght:root.height
        idx: index
        excludedColor:root.clr
        BarContentItem {
            wdth: root.width
            hght: root.height
            item: TextItem {
                text: del.appname
            }
            onBtnclick: {
                AppLauncher.pathname = del.sectxt
                console.log(AppLauncher.pathname)
                AppLauncher.isexec = true;
            }
        }
    }
        
    BarContentItem {
        wdth: root.scalewidthmin
        hght: root.height
        item: Text {
            text: "󰀻"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize:12
        }
        onBtnclick: {
            Settings.curridx = root.indx == Settings.curridx ? -1 : root.indx
            root.inputactive = false
            root.popupvisible = false
        }
    }
    BarContentItem {
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
            AppLauncher.searchApplications(gettext())
        }
    }

}
