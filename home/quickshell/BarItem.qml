import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQml


Item {
    id:root

    required property color clr;
    required property color clrtrngl;
    required property int indx;
    required property int itemcount;
    required property bool invtrngl;
    required property bool popupvisible;
    required property bool isscrollable;
    
    property var datamodel;
    property Component delegatecmpnnt;

    // you can override default component for your own popup behavior
    property Component popupcomponent: Rectangle {
        id: rectpop
        anchors.fill:parent
        color: root.clr
        clip:true
        ListView {
            // highlightRangeMode: ListView.StrictlyEnforceRange
            highlightRangeMode: ListView.StrictlyEnforceRange
            anchors.fill: parent
            model: root.datamodel
            contentWidth: root.scalewidthmin
            contentHeight: root.height
            delegate: root.delegatecmpnnt
        }
    }

    property bool unfolded: false
    property real widthmin: 70
    property real scaleFactor: parent.windowwidth / Settings.scaleWidth
    property real maxWidth: itemcount * widthmin
    property real scalewidthmin: scaleFactor*widthmin
    property real scaleheightmin: scaleFactor*40
    Behavior on implicitWidth { ElasticBehavior {} }
    Behavior on implicitHeight { ElasticBehavior {} }
    
    implicitWidth:  {
        var w 
        if (Settings.curridx == root.indx) {
            w = scaleFactor*maxWidth
        } else {
            w = scalewidthmin
        }
        unfolded = !unfolded
        flick.contentX = 0
        return w
        // Settings.curridx == root.indx ? scaleFactor*maxWidth : scalewidthmin
    }
    implicitHeight: scaleheightmin
    default property alias content: itemsrow.data
    Rectangle {
        id: rect
        clip: true
        // onClipChanged
        anchors.fill: root
        Layout.fillHeight:true
        Layout.fillWidth:true

        color: root.clr
        Popup {
            id: popup
            x: root.mapToItem(null, 0, 0).x
            y: root.height
            height:0
            implicitWidth: root.width
            implicitHeight: scaleheightmin*3
            Behavior on height { 
                ElasticBehavior  {} 
            }
            onOpened: {
                popup.height = popup.implicitHeight
            }

            onAboutToHide: {
                popup.height = 0
            }

            focus: true
            visible: Settings.curridx == root.indx && root.popupvisible
            modal: false
            closePolicy: Popup.NoAutoClose
            margins:0
            padding:0
            Loader {
                anchors.fill: parent
                sourceComponent: root.popupcomponent
            }
        }
        Flickable {
            id: flick
            width: rect.width
            height: rect.height
            interactive:root.isscrollable
            contentWidth: itemsrow.implicitWidth
            contentHeight: itemsrow.implicitHeight
            boundsBehavior:Flickable.StopAtBounds
            RowLayout {
                id: itemsrow
                // Rectangle {
                //     // Layout.fillWidth:true
                //     implicitWidth: rect.height/2
                //     implicitHeight: rect.height
                //     color: "transparent"
                // }
                spacing:0
                LayoutMirroring.enabled: !root.invtrngl
                // LayoutMirroring.childrenInherit: false
                visible:true
            }
        }
        TriangleItem {
            inverted:root.invtrngl;
            isanchor:true;
            hght:root.height;
            clr:root.clrtrngl;
            width: rect.height/2
            height: rect.height
        }
    }
}
