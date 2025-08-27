import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQml


Item {
    id:baritem

    // anchors.fill: parent
    // required property int itemWidth;
    // required property int itemHeight;
    required property color clr;
    required property int index;

    // Layout.fillWidth: true
    // Layout.fillHeight: true
    // Layout.maximumWidth: itemWidth/5
    // Layout.minimumWidth: itemHeight/16
    // Layout.preferredWidth: 50
    // property real wScale: parent.parent.width / 1920
    // property real hScale: parent.parent.height / 1080
    // property real scaleFactor: Math.min(wScale, hScale)
    property real scaleFactor: parent.parent.width / 1920
    Behavior on implicitWidth { ElasticBehavior {} }
    Behavior on implicitHeight { ElasticBehavior {} }
    property real scalewidthmin: scaleFactor*60
    property real scaleheightmin: scaleFactor*40
    implicitWidth:  PopupState.curridx == baritem.index ? scaleFactor*300 : scalewidthmin
    implicitHeight: scaleheightmin
    Rectangle {
        id: rect
        clip: true
        // onClipChanged
        anchors.fill: parent
        color: baritem.clr
        Popup {
            id: popup
            x: baritem.mapToItem(null, 0, 0).x
            y: baritem.height
            implicitWidth: baritem.width
            implicitHeight: scaleheightmin*3
            focus: true
            visible: PopupState.curridx == baritem.index
            modal: false
            Rectangle {
                implicitWidth: popup.width
                implicitHeight: popup.height
                id: rectpop
                anchors.fill:baritem
                color: baritem.clr
            }
        }
        
        RowLayout {
            id :itemsrow
            spacing:0
            // implicitWidth: baritem.width
            // implicitHeight: baritem.height
            // Layout.fillHeight: true
            // Layout.fillWidth: true
            Button {
                // width: baritem.scalewidthmin
                // height: baritem.height
                Layout.preferredWidth: baritem.scalewidthmin
                Layout.preferredHeight: baritem.height

                opacity:0.4
                Layout.alignment:Qt.AlignTop
                // anchors.fill: parent
                onClicked: {
                   PopupState.curridx = baritem.index == PopupState.curridx ? -1 : baritem.index
                }
            }
            Button {
                // width: baritem.scalewidthmin
                // height: baritem.height
                Layout.preferredWidth: baritem.scalewidthmin
                Layout.preferredHeight: baritem.height

                opacity:0.4
                Layout.alignment:Qt.AlignTop
                // anchors.fill: parent
                onClicked: {
                   PopupState.curridx = baritem.index == PopupState.curridx ? -1 : baritem.index
                }
            }
            Button {
                // width: baritem.scalewidthmin
                // height: baritem.height
                Layout.preferredWidth: baritem.scalewidthmin
                Layout.preferredHeight: baritem.height

                opacity:0.4
                Layout.alignment:Qt.AlignTop
                // anchors.fill: parent
                onClicked: {
                   PopupState.curridx = baritem.index == PopupState.curridx ? -1 : baritem.index
                }
            }
            Button {
                // width: baritem.scalewidthmin
                // height: baritem.height
                Layout.preferredWidth: baritem.scalewidthmin
                Layout.preferredHeight: baritem.height

                opacity:0.4
                Layout.alignment:Qt.AlignTop
                // anchors.fill: parent
                onClicked: {
                   PopupState.curridx = baritem.index == PopupState.curridx ? -1 : baritem.index
                }
            }
            Button {
                // width: baritem.scalewidthmin
                // height: baritem.height
                Layout.preferredWidth: baritem.scalewidthmin
                Layout.preferredHeight: baritem.height

                opacity:0.4
                Layout.alignment:Qt.AlignTop
                // anchors.fill: parent
                onClicked: {
                   PopupState.curridx = baritem.index == PopupState.curridx ? -1 : baritem.index
                }
            }
            
        }
    }
}

