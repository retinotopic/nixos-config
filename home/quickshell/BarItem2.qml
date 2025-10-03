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



Rectangle {
    id: root
    color: "purple"
    property real itemcount: 3
    required property real scaleheightmin
    Layout.fillHeight: true;
    Layout.preferredWidth: itemrect1.width+trngl.width
    // Layout.maximumWidth: root.itemcount * root.scaleheightmin
    // Layout.minimumWidth: root.scaleheightmin
    Rectangle {
        id: itemrect1
        width: root.scaleheightmin
        height: root.scaleheightmin
        x: trngl.x + trngl.width
        // Layout.maximumWidth: root.itemcount * root.scaleheightmin
        // Layout.minimumWidth: root.scaleheightmin
        
        // Layout.minimumHeight: root.scaleheightmin
        // Layout.preferredWidth: root.scaleheightmin
        // Layout.preferredHeight: root.scaleheightmin
        Behavior on width { ElasticBehavior {} }
        color: "yellow"
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
            visible:false
            closePolicy: Popup.NoAutoClose
            margins:0
            padding:0
            // Loader {
            //     anchors.fill: parent
            //     sourceComponent: itemrect1.popupcomponent
            // }
        }
        RowLayout {
            Layout.fillHeight: true; Layout.fillWidth: true
            spacing:0
            BarContentItem {
                wdth: root.scaleheightmin
                hght: root.scaleheightmin
                isImplicit: false
                item: TextItem {
                    text: ""
                }
                onBtnclick: {
                    // if (root.Layout.preferredWidth === root.Layout.maximumWidth) {
                    //     root.Layout.preferredWidth = root.Layout.minimumWidth
                    // } else {
                    //     root.Layout.preferredWidth = root.Layout.maximumWidth
                    // }
                    if (itemrect1.width === root.scaleheightmin) {
                        itemrect1.width = root.scaleheightmin*3
                    } else {
                        itemrect1.width = root.scaleheightmin
                    }
                }
            }
            BarContentItem {
                wdth: root.scaleheightmin
                hght: root.scaleheightmin
                isImplicit: false
                item: TextItem {
                    text: ""
                }
                onBtnclick: {
                    popup.visible = !popup.visible
                }
            }
        }
    }
    TriangleItem {
        id: trngl
        inverted:false;
        // x: itemrect1.x + itemrect1.width
        clr:"red"
        width: root.scaleheightmin/2
        height: root.scaleheightmin
    }
}


