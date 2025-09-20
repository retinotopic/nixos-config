
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
    index: 6;
    itemcount: 3;
    windowwidth: parent.parent.width;
    isscrollable: false;
    popupvisible: false;
    widthmin: 180
    invtrngl:true
    BarContentItem {
        wdth: root.scalewidthmin
        hght: root.height
        item: Text {
            text: Cava.output
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize:12
            textFormat: Text.StyledText
        }
        onBtnclick: {
           Settings.curridx = root.index == Settings.curridx ? -1 : root.index
        }
    }
    BarContentItem {
        wdth: root.scalewidthmin
        hght: root.height
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
        wdth: root.scalewidthmin
        hght: root.height
        item: Text {
            text: SysInfo.clocktime
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


