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
    required property Item item;
    property bool isImplicit: true
    property color clr: "transparent"
    property real opac
    signal btnclick
    Layout.alignment:Qt.AlignLeft
    
    background: Rectangle {
        opacity: root.opac
        color: root.clr
    }
    contentItem: item
    onClicked: btnclick()
}

