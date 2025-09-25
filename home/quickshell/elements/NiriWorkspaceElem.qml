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
    itemcount: 2;
    windowwidth: parent.parent.width;
    isscrollable: true;
    popupvisible: false;
    invtrngl:true
    HListViewItem {
        id:listv
        wdth: root.width
        hght: root.height
        datamodel: Niri.workspaces
        delegatecmpnnt: BarContentItem {
            required property string idx;
            required property string isActive;
            wdth: root.width
            hght: root.height
            item: Row {
                Text {id: maintxt1; text: idx}
                Text {id: maintxt2; text: isActive}
            }

            onBtnclick: {
               Settings.curridx = root.indx == Settings.curridx ? -1 : root.indx
               listv.positionViewAtBeginning()
               Niri.focusedWorkspaceIndex = maintxt1.text
               Niri.workspacefocus = true;
            }
        }
    }
}

