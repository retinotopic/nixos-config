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
    invtrngl:true
    itemcount: 2;
    isscrollable: true;
    popupvisible: false

    BarContentItem {
        Layout.preferredWidth: root.scaleheightmin
        Layout.preferredHeight: root.scaleheightmin
        item: TextItem {
            text: SysInfo2.cpuUsage + " " + SysInfo2.cpuTemp
        }
        onBtnclick: {
           Settings.curridx = root.indx == Settings.curridx ? -1 : root.indx
        }
    }
}

