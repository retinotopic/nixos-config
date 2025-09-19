
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
    index: 3;
    itemcount: 3;
    windowwidth: parent.parent.width;
    isscrollable: false;
    popupvisible: false;
    widthmin: 180
    invtrngl:true
    delegatecmpnnt: ListDelegateItem {
        id: del
        required property string maintxt;
        required property string sectxt;
        wdth:root.width
        hght:root.height
        BarContentItem {
            wdth: root.width
            hght: root.height
            clr: "#424b50"; opac: 1
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
    }
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
            text: "󰐊"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize:12
            textFormat: Text.StyledText
        }
        onBtnclick: {
            Mpris.play();
        }
    }
    BarContentItem {
        wdth: root.scalewidthmin
        hght: root.height
        item: Text {
            text: "󰏤"
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.pointSize:12
            textFormat: Text.StyledText
        }
        onBtnclick: {
            Mpris.pause();
        }
    }
}


