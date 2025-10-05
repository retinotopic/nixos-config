import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Shapes
import QtQml

pragma ComponentBehavior: Bound

Item {
    id: root
    required property int idx;
    property real implicitSize: 40
    required property color excludedColor;

    property color clr: Settings.colorpick(excludedColor,idx)
    default property alias content: middleContent.data

    implicitWidth:root.implicitSize*2
    implicitHeight:root.implicitSize
    scale:0.8
    Rectangle {
        id: rect
        anchors.fill: root
        color: root.clr
        RowLayout {
            anchors.fill: rect
            id: middleContent
        }
    }
}
