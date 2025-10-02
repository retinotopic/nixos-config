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
    required property real wdth
    required property real hght
    required property Item item;
    property bool isImplicit: true
    property color clr: "transparent"
    property real opac
    signal btnclick
    Layout.alignment:Qt.AlignLeft
    Layout.preferredWidth: wdth
    Layout.preferredHeight: hght
    implicitWidth: isImplicit ? wdth : null
    implicitHeight: isImplicit ? hght : null
    
    background: Rectangle {
        // implicitWidth: wdth
        // implicitHeight: hght
        Layout.preferredWidth: wdth
        Layout.preferredHeight: hght
        // implicitHeight: hght
        // implicitWidth: wdth
        height: root.height
        width: root.width
        opacity: opac
        color: root.clr
    }
    contentItem: item
    // anchors.fill: parent
    onClicked: btnclick()
}

