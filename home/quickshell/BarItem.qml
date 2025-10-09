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
        // console.log(root.mapToGlobal(root.x,root.y))
        // console.log(itemrect1.mapToGlobal(itemrect1.x,itemrect1.y))
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
        Behavior on implicitWidth {
            ElasticBehavior {
                // onRunningChanged: {
                //     if (!running) {
                //         const xcord = root.mapToGlobal(root.x,root.y)
                //         switch (root.objectName) {
                //             case "left":
                //                 popupContainer.x = xcord.x
                //             case "right":
                //                 popupContainer.x = root.parent.parent.parent.width - xcord.x
                //         }
                //         console.log(root.mapToGlobal(root.x,root.y),root.indx,popupContainer.x)
                //     }
                // }
            }
        }

        PopupWindow {
            id: popupwindow
            anchor {
                id: anch
                item: itemrect1
                // item: root.parent.parent.parent
                // gravity: Edges.Bottom | Edges.Right
                // edges: Edges.Bottom | Edges.Right
                rect.width: itemsrow.width
                // rect.height: 1000
                // rect.w: itemsrow.width
                // rect.h: 500
                rect.y: root.scaleheightmin
                // edges: Edges.Top | Edges.Right
                rect.x: 0
                onAnchoring: {
                    console.log(itemrect1.width,itemrect1.implicitWidth,anch.rect.width,itemrect1.mapToGlobal(itemrect1.x,itemrect1.y))
                }
            }
            color:"transparent"

            // Loader {
            //     anchors.fill: itemrect1
            //     id: popupContainer
            //     width: itemrect1.width
            //     height: 500                    
            //         // anchors.fill: parent
            //     x: itemrect1.x
            //     sourceComponent: root.popupcomponent
            // }
            Popup {
                id: popup
                x: 0
                // anchors.centerIn:parent
                // x: root.isPopupEmbedded ? 0 : root.parent.x
                y: itemrect1.height
                height:0

                // width: itemrect1.width
                width: itemsrow.width
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
                // visible:true
                visible: Settings.curridx == root.indx && root.popupvisible
                // visible: Settings.curridx == root.indx && root.popupvisible
                closePolicy: Popup.NoAutoClose
                margins:0
                padding:0
                Loader {
                    anchors.fill: parent
                    sourceComponent: root.popupcomponent
                }
            }
        
            visible: Settings.curridx == root.indx && root.popupvisible
            height: 500
            width: root.scaleheightmin
        }
        color: root.clr
        clip: true
        // Popup {
        //     id: popup
        //     x: 0
        //     // x: root.isPopupEmbedded ? 0 : root.parent.x
        //     y: itemrect1.height
        //     height:0
        //     width: itemrect1.width
        //     // height: scaleheightmin*3
        //     Behavior on height { 
        //         ElasticBehavior  {} 
        //     }
        //     onOpened: {
        //         popup.height = root.scaleheightmin*3
        //     }

        //     onAboutToHide: {
        //         popup.height = 0
        //     }

        //     focus: true
        //     modal: false
        //     visible: Settings.curridx == root.indx && root.popupvisible
        //     // visible: Settings.curridx == root.indx && root.popupvisible
        //     closePolicy: Popup.NoAutoClose
        //     margins:0
        //     padding:0
        //     Loader {
        //         anchors.fill: parent
        //         sourceComponent: root.popupcomponent
        //     }
        // }
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
    // PopupWindow {
    //     id: popupwindow
    //     anchor {
    //         id: anch
    //         item: root.parent.parent.parent
    //         // item: root.parent.parent.parent
    //         // gravity: Edges.Bottom | Edges.Right
    //         // edges: Edges.Bottom | Edges.Right
    //         rect.width: popupwindow.width
    //         rect.height: 1000
    //         // rect.w: 500
    //         // rect.h: 500
    //         rect.y: root.scaleheightmin
    //         // rect.x: itemrect1
    //         onAnchoring: {
    //             console.log(itemrect1.width,itemrect1.implicitWidth,anch.rect.width,itemrect1.mapToGlobal(itemrect1.x,itemrect1.y))
    //         }
    //     }
    //     color:"transparent"

    //     Loader {
    //         id: popupContainer
    //         width: itemrect1.width
    //         height: 500                    
    //             // anchors.fill: parent
    //         x: 1400
    //         sourceComponent: root.popupcomponent
    //     }
    //     // Item {
    //     //     // anchors.right: parent.right
    //     //     id: inneritem
    //     //     width: itemrect1.width
    //     //     height: 500                    
    //     //     Loader {
    //     //         anchors.fill: parent
    //     //         sourceComponent: root.popupcomponent
    //     //     }
    //     // }
        
    //     visible: Settings.curridx == root.indx && root.popupvisible
    //     height: 500
    //     width: root.parent.parent.parent.width
    // }
    Loader {
        anchors.left: !root.invtrngl ? parent.left : null
        anchors.right: root.invtrngl ? parent.right : null
        id: borderDecor
        sourceComponent: root.borderDecoration
    }
}


