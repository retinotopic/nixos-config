import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Shapes
import QtQml

Shape {
    id: root
    required property color clr;
    required property bool inverted;
    required property real hght;
    property bool isanchor: false
    Layout.preferredWidth: hght / 2
    Layout.preferredHeight: hght
    Layout.maximumWidth: hght/2
    Layout.minimumWidth: hght/2

    anchors {
        left: !root.inverted && isanchor ? root.parent.left : undefined
        right: !root.inverted && isanchor ? root.parent.right: undefined
        margins: 0
    }
    ShapePath {
        strokeWidth: -1
        fillColor: clr 
        startX: root.inverted == false ? root.width : 0
        startY: 0
        PathLine { x: root.inverted == false ?
            root.width : 0; y: root.height }
        PathLine { x: root.inverted == false ?
            root.width-(root.height/2) : root.width; y: root.height / 2 }
        PathLine { x: root.inverted == false ?
            root.width : 0; y: 0 }

    }
}
