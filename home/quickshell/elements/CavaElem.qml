
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
    itemcount: 3;
    isscrollable: false;
    popupvisible: false;
    invtrngl:true
    BarContentItem {
        Layout.preferredWidth: root.scaleheightmin
        Layout.preferredHeight: root.scaleheightmin
        item: Text {
            text: Cava.output
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize:12
            textFormat: Text.StyledText
        }
        onBtnclick: {
           Settings.curridx = root.indx == Settings.curridx ? -1 : root.indx
        }
    }
    BarContentItem {
        Layout.preferredWidth: root.scaleheightmin
        Layout.preferredHeight: root.scaleheightmin
        item: Text {
            text: Mpris.activePlayer && Mpris.activePlayer.canTogglePlaying ? "󰐊" : "󰏤"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize:12
            textFormat: Text.StyledText
        }
        onBtnclick: {
            Mpris.playPause();
        }
    }
    BarContentItem {
        Layout.preferredWidth: root.scaleheightmin
        Layout.preferredHeight: root.scaleheightmin
        item: Text {
            text: SysInfo2.clocktime
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize:12
            textFormat: Text.StyledText
        }
        onBtnclick: {
            Mpris.playPause();
        }
    }
}


