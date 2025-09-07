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
    Layout.preferredWidth: hght / 2
    Layout.preferredHeight: hght
    ShapePath {
        strokeWidth: -1
        fillColor: clr 
        startX: root.inverted == false ? root.width : 0
        startY: 0
        PathLine { x: root.inverted == false ?
            root.width : 0; y: root.height }
        PathLine { x: root.inverted == false ?
            0 : root.width; y: root.height / 2 }
        PathLine { x: root.inverted == false ?
            root.width : 0; y: 0 }
    }
}
