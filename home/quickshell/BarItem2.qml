import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets
import Quickshell.Wayland
import "./elements"
import "./services"



Rectangle {
    id: root
    color: "purple"
    property real itemcount: 3
    required property real scaleheightmin
    Layout.fillHeight: true;
    Layout.preferredWidth: itemrwlt1.width
    // Layout.maximumWidth: itemrwlt1.width
    // Layout.minimumWidth: itemrwlt1.width
    Behavior on Layout.preferredWidth { ElasticBehavior {} }
    RowLayout {
        id: itemrwlt1
        spacing:0
        Rectangle {
            id: itemrect1
            Layout.maximumWidth: root.itemcount * root.scaleheightmin
            Layout.minimumWidth: root.scaleheightmin
            
            Layout.minimumHeight: root.scaleheightmin
            Layout.preferredWidth: root.scaleheightmin
            Layout.preferredHeight: root.scaleheightmin
            color: "green"
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
                        if (itemrect1.Layout.preferredWidth === itemrect1.Layout.maximumWidth) {
                            itemrect1.Layout.preferredWidth = itemrect1.Layout.minimumWidth
                        } else {
                            itemrect1.Layout.preferredWidth = itemrect1.Layout.maximumWidth
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
            hght: root.scaleheightmin
            clr: "green"
            inverted: true
        }
    }
}


