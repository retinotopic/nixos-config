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
    // required property Region df
    property int indx: -1
    
    Component.onCompleted: {
        indx = Settings.distributeIndex(indx)
        clr = Settings.colorpick("black",Settings.giveColorIndex(root.parent.objectName))
        clrtrngl = clr
        // console.log(indx,clr,"hmm")
        // console.log(root.mapToGlobal(root.x+root.width,root.y).x,indx,clr,"hmm")
        // root.parent.children
        for (const [i,v] of root.parent.children.entries()) {
            console.log(v.contentWidth,"WHAT",i,root.parent.objectName)
        }
    }

    property color clr;
    property color clrtrngl;
    property real xcord;
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
    implicitWidth: itemrect1.implicitWidth+borderDecor.implicitWidth-0.8
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
        // Rectangle {
        //     id: anchRect
        //     anchors.right: itemrect1.right

        //     color: "transparent"
        //     width: 0
        //     height: root.scaleheightmin
        // }
        Popup {
            id: popup
            x: 0
            // x: root.isPopupEmbedded ? 0 : root.parent.x
            y: itemrect1.height
            height:0
            // parent: root.parent.parent.children[2].children[1]
            width: itemrect1.width
            // height: scaleheightmin*3
            // Behavior on height { 
            //     ElasticBehavior  {} 
            // }
            onAboutToShow: {
                Settings.popupLoader = popuploader
                Settings.popupOpen = !Settings.popupOpen
            }
            onOpened: {
                Settings.popupLoader = popuploader
                Settings.popupOpen = !Settings.popupOpen
                popup.height = root.scaleheightmin*3
            }

            onAboutToHide: {
                popup.height = 0
            }
            focus: true
            modal: false
            // visible: false
            visible: Settings.curridx == root.indx && root.popupvisible
            closePolicy: Popup.NoAutoClose
            margins:0
            padding:0
            Loader {
                id: popuploader
                anchors.fill: parent
                sourceComponent: root.popupcomponent
            }
        }
        // PopupWindow {
        //     id: popupwindow
        //     anchor {
        //         id: anch
        //         item: anchRect
        //         // gravity: Edges.Top | Edges.Left
        //         // edges: Edges.Top | Edges.Left
        //         rect.width: itemsrow.width
        //         rect.height: 1000
        //         // rect.w: 500
        //         // rect.h: 500
        //         rect.y: itemrect1.height
        //         rect.x: -itemsrow.width
        //         // onAnchoring: {
        //         //     console.log(itemrect1.width,itemrect1.implicitWidth,anch.rect.width)
        //         // }
        //     }
            
        //     color:"transparent"
        //     Rectangle {
        //         color: "transparent"
        //         id: popupContainer
        //         width: itemsrow.width
        //         height: 500

        //         Item {
        //             id: inneritem
        //             width: itemrect1.width
        //             height: 500                    
        //             Loader {
        //                 anchors.fill: parent
        //                 sourceComponent: root.popupcomponent
        //             }
        //         }
        //     }
        //     visible: Settings.curridx == root.indx && root.popupvisible
        //     height: 500
        //     width: itemsrow.width
        // }
        Behavior on implicitWidth {
            id: bhvr
            enabled:true
            ElasticBehavior {
                onRunningChanged: {
                    if (!running) {
                        // console.log(itemrect1.mapToGlobal(itemrect1.width,0).x,"2")
                    }
                }
            }
        }
        // PanelWindow {
        //     id:wndw
        //     anchors {
        //         left: false
        //         right: true

        //         bottom: false
        //         top: true
        //     }

        //     margins {
        //         top:0
        //         right: 0
        //         // right: itemrect1.mapToItem(root.parent.parent,root.parent.parent.width, root.scaleheightmin) 
        //         // right:root.parent.parent.width - itemrect1.mapToGlobal(itemrect1.x+itemrect1.width,itemrect1.y).x + root.scaleheightmin/2
        //         left:0
        //         bottom:0
        //     }
        //     // color: "transparent"
        //     visible: false
        //     // visible: Settings.curridx == root.indx && root.popupvisible
        //     width:root.parent.parent.parent.width/3
        //     // width:itemsrow.width
        //     height:400
        //     // Component.onCompleted: {
        //     //     console.log(wndw.mapFromItem(itemrect1).x,"AAAAAAAAA1")
        //     // }
        //     Item {
        //         anchors.right: itemrect1.right
        //         id: inneritem
        //         width: itemsrow.width
        //         height: 500                    
        //         x: itemrect1.mapToItem(inneritem,itemrect1.x,itemrect1.y).x
        //         Loader {
        //             anchors.fill: parent
        //             sourceComponent: root.popupcomponent
        //         }
        //     }

        // }
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
    Loader {
        anchors.left: !root.invtrngl ? parent.left : null
        anchors.right: root.invtrngl ? parent.right : null
        id: borderDecor
        sourceComponent: root.borderDecoration
    }
}


