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

RowLayout {
    id: root
    required property real wdth
    required property real hght
    required property real start
    required property real initvalue
    required property real end
    
    readonly property real val: sldr.value
    signal slidermoved
    spacing: -0.8

    TriangleItem {
        inverted:false
        hght:root.hght/12
        clr:Settings.dark
    }
    Slider {
        id: sldr
        Layout.preferredWidth: root.wdth
        Layout.preferredHeight: root.hght
        from: root.start
        value: root.initvalue
        to: root.end
        onMoved: root.slidermoved()
        background: Rectangle {
            anchors.centerIn: sldr
            width: root.wdth
            height: root.hght/12
            color:Settings.dark
        }
        handle: Rectangle {
            RowLayout {
                spacing: -0.8
                x: sldr.leftPadding + (sldr.horizontal ? sldr.visualPosition * (sldr.availableWidth - width) : (sldr.availableWidth - width) / 2)
                y: sldr.topPadding + (sldr.vertical ? sldr.visualPosition * (sldr.availableHeight - height) : (sldr.availableHeight - height) / 2)
                TriangleItem {
                    inverted:false
                    hght:inprect.height
                    clr:Settings.dark
                }
                Rectangle {
                    id: inprect
                    Layout.alignment:Qt.AlignCenter
                    Layout.preferredWidth: root.hght/2
                    Layout.preferredHeight: root.hght/2
                    color:Settings.dark
                }
                TriangleItem {
                    inverted:true
                    hght:inprect.height
                    clr:Settings.dark
                }
            }
        }
    }
    TriangleItem {
        inverted:true
        hght:root.hght/12
        clr:Settings.dark
    }
}
