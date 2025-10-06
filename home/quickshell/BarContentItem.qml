import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Shapes
import QtQml

Button {
    id: root
    property real implicitSize: 40
    property color clr: "transparent"
    property real opac
    signal btnclick
    implicitWidth: root.implicitSize
    implicitHeight: root.implicitSize
    background: Rectangle {
        opacity: root.opac
        color: root.clr
    }
    onClicked: btnclick()
}

