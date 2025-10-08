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
import "./decorations"

pragma ComponentBehavior: Bound

Item {
    id: root
    property real scaleheightmin: parent.parent.scaleheightmin
    // your own widthmax or calculated via minheight * itemcount
    
    property int indx: -1
    
    Component.onCompleted: {
        indx = Settings.distributeIndex(indx)
        clr = Settings.colorpick("black",Settings.giveColorIndex(root.parent.objectName))
        clrtrngl = clr
    }

    property color clr;
    property color clrtrngl;
    required property bool invtrngl;
    required property bool popupvisible;
    required property bool isscrollable;
    property bool isPopupEmbedded: false;
    
    property var datamodel;
    property Component delegatecmpnnt;

    default property alias content: itemsrow.data
    readonly property real contentWidth: itemsrow.width

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

    property Component borderDecoration: TriangleItem {
        id: trngl
        inverted:root.invtrngl;
        clr:root.clrtrngl
        implicitWidth: root.scaleheightmin/2
        implicitHeight: root.scaleheightmin
    }
    // property Component rectDecoration: SemicircleItem {
    //     implicitWidth: root.scaleheightmin/2
    //     implicitHeight: root.scaleheightmin
    // }
    property Component rectDecoration: DecorTriangleItem {
        id: trngl2
        clr:root.clrtrngl
        implicitWidth: root.scaleheightmin/2
        implicitHeight: root.scaleheightmin
    }

    implicitHeight: root.scaleheightmin
    implicitWidth: itemrect1.implicitWidth+borderDecor.implicitWidth-1
    // Layout.maximumWidth: root.itemcount * root.scaleheightmin
    // Layout.minimumWidth: root.scaleheightmin
    Rectangle {
        id: itemrect1
        Loader {
            anchors.fill : parent
            id: rectDecor
            sourceComponent: root.rectDecoration
        }
        anchors.left: root.invtrngl ? parent.left : null
        anchors.right: !root.invtrngl ? parent.right : null
        implicitWidth: Settings.curridx == root.indx ? itemsrow.width : root.scaleheightmin
        implicitHeight: root.scaleheightmin
        // onWidthChanged: {
        //     anch.rect.width = itemrect1.width
        //     anch.rect.height = 500
        //     anch.rect.y = itemrect1.height
        //     // anch.rect.x = root.parent.width-popup.width
        //     popup.width = itemrect1.width
        //     // console.log(itemrect1.width,itemrect1.implicitWidth,anch.rect.width)
        //     anch.updateAnchor()
        // }
        Behavior on implicitWidth { ElasticBehavior {} }
        color: root.clr
        clip: true
        Flickable {
            id: flick
            width: itemrect1.width
            height: itemrect1.height
            interactive:root.isscrollable
            focus:true
            contentWidth: itemsrow.width
            contentHeight: root.scaleheightmin
            boundsBehavior:Flickable.DragOverBounds
            RowLayout {
                scale:0.9
                id: itemsrow
                // anchors.fill:flick
                // Layout.fillHeight: true; Layout.fillWidth: true
                spacing:0
            }
        }
    }
    PopupWindow {
        id: popupwindow
        anchor {
            id: anch
            item: root
            // gravity: Edges.Bottom | Edges.Right
            // edges: Edges.Bottom | Edges.Right
            rect.width: popupContainer.width
            rect.height: 1000
            // rect.w: 500
            // rect.h: 500
            rect.y: itemrect1.height
            // rect.x: root.parent.width-popup.width
            // onAnchoring: {
            //     console.log(itemrect1.width,itemrect1.implicitWidth,anch.rect.width)
            // }
        }
        color:"transparent"
        Rectangle {
            color: "transparent"
            id: popupContainer
            width: root.parent.parent.parent.width
            height: 500

            Item {
                id: inneritem
                width: itemrect1.width
                height: 500                    
                Loader {
                    anchors.fill: parent
                    sourceComponent: root.popupcomponent
                }
            }
        }
        visible: Settings.curridx == root.indx && root.popupvisible
        height: 500
        width: root.parent.parent.parent.width
    }
    Loader {
        anchors.left: !root.invtrngl ? parent.left : null
        anchors.right: root.invtrngl ? parent.right : null
        id: borderDecor
        sourceComponent: root.borderDecoration
    }
}


