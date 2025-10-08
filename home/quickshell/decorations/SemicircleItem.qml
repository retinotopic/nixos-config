
import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Shapes
import QtQml


Rectangle {
    id: root
    implicitWidth: implicitSize/2
    implicitHeight: implicitSize
    Shape {
        anchors.fill: root
        // anchors.bottom: parent.bottom
        // anchors.right: parent.right
        // multisample, decide based on your scene settings
        // layer.enabled: true
        // layer.samples: 4

        ShapePath {
            fillColor: "black"
            strokeColor: "darkBlue"
            strokeWidth: 20
            capStyle: ShapePath.FlatCap

            PathAngleArc {
                centerX: 65; centerY: 95
                radiusX: 45; radiusY: 45
                startAngle: -180
                sweepAngle: 180
            }
        }
    }
}
