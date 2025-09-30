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
    isscrollable: true;
    popupvisible: false;
    Connections {
        target: Niri
        function onWorkspaceChanged() {
            console.log("wripscake change")
            listv.positionViewAtIndex(Niri.focusedWorkspaceIndex, ListView.Center)
        }
    }

    invtrngl:true
    HListViewItem {
        id:listv
        wdth: root.width
        hght: root.height
        datamodel: Niri.workspaces
        delegatecmpnnt: BarContentItem {
            id: del
            required property string idx;
            required property string isActive;
            wdth: root.scalewidthmin
            hght: root.height
            
            item: TextItem {
                // Layout.fillHeight: true; Layout.fillWidth: true
                width: root.scalewidthmin
                height: root.height
                
                text: idx
                color: Settings.dark
            }

            onBtnclick: {
                Settings.curridx = root.indx == Settings.curridx ? -1 : root.indx
                Niri.switchToWorkspace(del.idx)
            }
        }
    }
}

