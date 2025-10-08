import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Shapes
import QtQml
import "./services"
import "./decorations"

Item {
    id: root
    property Component decor: null
    required property real start
    required property real initvalue
    required property real end
    readonly property real val: sldr.value
    signal slidermoved
    implicitWidth: 80
    implicitHeight: 40
    Slider {
        id: sldr
        width:root.width
        height:root.height
        from: root.start
        value: root.initvalue
        to: root.end
        onMoved: root.slidermoved()
        background: Rectangle {
            anchors.centerIn: sldr
            width: sldr.width
            height: sldr.height/12
            color:Settings.dark
        }
        handle: DecorTriangleItem {
            id: inprect
            x: sldr.leftPadding + (sldr.horizontal ? sldr.visualPosition * (sldr.availableWidth - width) : (sldr.availableWidth - width) / 2)
            y: sldr.topPadding + (sldr.vertical ? sldr.visualPosition * (sldr.availableHeight - height) : (sldr.availableHeight - height) / 2)
            width:root.width/3
            height:root.height/2
            clr:Settings.dark
        }
    }
}
