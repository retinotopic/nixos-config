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
    required property real windowwidth;
    required property bool invtrngl;
    required property bool popupvisible;
    required property bool isscrollable;
    
    property var datamodel;
    property Component delegatecmpnnt;
    property real widthmin: 70
    property real scaleFactor: windowwidth / 1920
    property real maxWidth: itemcount * widthmin
    property real scalewidthmin: scaleFactor*widthmin
    property real scaleheightmin: scaleFactor*40
    Behavior on implicitWidth { ElasticBehavior {} }
    Behavior on implicitHeight { ElasticBehavior {} }
    
    implicitWidth:  Settings.curridx == root.indx ? scaleFactor*maxWidth : scalewidthmin
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
            implicitWidth: root.width
            implicitHeight: scaleheightmin*3
            focus: true
            visible: Settings.curridx == root.indx && root.popupvisible
            modal: false
            closePolicy: Popup.NoAutoClose
            margins:0
            padding:0
            Rectangle {
                id: rectpop
                anchors.fill:parent
                color: root.clr
                clip:true
                Behavior on height { 
                    ElasticBehavior  {   } 
                }
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
        }
        Flickable {
            width: rect.width
            height: rect.height
            interactive:root.isscrollable
            contentWidth: itemsrow.implicitWidth
            contentHeight: itemsrow.implicitHeight
            
            RowLayout {
                id: itemsrow
                Rectangle {
                    Layout.fillWidth:true
                    implicitWidth: rect.height/2
                    implicitHeight: rect.height
                    color: "transparent"
                }
                spacing:0
                LayoutMirroring.enabled: !root.invtrngl
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
