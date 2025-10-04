import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Wayland
import QtQuick.Shapes
import "./elements"
import "./services"

pragma ComponentBehavior: Bound

Rectangle {
    id: root
    property real scaleheightmin: parent.parent.scaleheightmin
    property real widthmax: parent.parent.minheight
    property real scalewidthmax: parent.parent.scaleFactor*(widthmax*itemcount)
    required property color clr;
    required property color clrtrngl;
    required property int indx;
    required property int itemcount;
    required property bool invtrngl;
    required property bool popupvisible;
    required property bool isscrollable;
    
    property var datamodel;
    property Component delegatecmpnnt;

    default property alias content: itemsrow.data
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
            contentWidth: root.scaleheightmin
            contentHeight: root.height
            delegate: root.delegatecmpnnt
        }
    }
    Layout.fillHeight: true;
    Layout.preferredWidth: itemrect1.width+trngl.width
    // Layout.maximumWidth: root.itemcount * root.scaleheightmin
    // Layout.minimumWidth: root.scaleheightmin
    Rectangle {
        id: itemrect1
        // width: root.scaleheightmin
        width: Settings.curridx == root.indx ? root.scalewidthmax : root.scaleheightmin

        height: root.scaleheightmin
        x: root.invtrngl ? 0 : trngl.x + trngl.width
        // x: trngl.x + trngl.width
        Behavior on width { ElasticBehavior {} }
        color: root.clr
        clip: true
        Popup {
            id: popup
            x: itemrect1.mapToItem(null, 0, 0).x
            y: itemrect1.height
            height:0
            width: itemrect1.width
            // height: scaleheightmin*3
            Behavior on height { 
                ElasticBehavior  {} 
            }
            onOpened: {
                popup.height = root.scaleheightmin*3
            }

            onAboutToHide: {
                popup.height = 0
            }

            focus: true
            modal: false
            visible: Settings.curridx == root.indx && root.popupvisible
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
            width: itemrect1.width
            height: itemrect1.height
            interactive:root.isscrollable
            focus:true
            contentWidth: root.scaleheightmin*2
            contentHeight: root.scaleheightmin
            boundsBehavior:Flickable.DragOverBounds
            RowLayout {
                id: itemsrow
                // anchors.fill:flick
                // Layout.fillHeight: true; Layout.fillWidth: true
                spacing:0
            }
        }
    }
    TriangleItem {
        id: trngl
        inverted:root.invtrngl;
        x: !root.invtrngl ? 0 : itemrect1.x + itemrect1.width
        clr:root.clrtrngl
        width: root.scaleheightmin/2
        height: root.scaleheightmin
    }
}


