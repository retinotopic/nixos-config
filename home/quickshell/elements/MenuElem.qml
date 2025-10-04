
import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Shapes
import Qt.labs.platform
import QtQml
import "../services"
import "../"

pragma ComponentBehavior: Bound 
BarItem {
    id:root
    invtrngl:true
    itemcount: 2;
    isscrollable: true;
    popupvisible: false

    HListViewItem {
        id:listv
        wdth: root.width
        hght: root.height
        datamodel: SysTray.systrayitems
        horizontal:true
        delegatecmpnnt: BarContentItem {
            id: del
            required property string iconsrc
            Layout.preferredWidth: root.scaleheightmin
            Layout.preferredHeight: root.scaleheightmin
            
            item: Image {
                source: del.iconsrc
            }

            onBtnclick: {
            }
        }
    }
    BarContentItem {
        Layout.preferredWidth: root.scaleheightmin
        Layout.preferredHeight: root.scaleheightmin
        item: TextItem {
            text: "Menu"
        }
        onBtnclick: {
            Settings.curridx = root.indx == Settings.curridx ? -1 : root.indx
            SysTray.systraydo()
        }
    }
}


