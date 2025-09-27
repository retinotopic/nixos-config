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
    property color clr: "transparent"
    property real opac
    signal btnclick
    Layout.alignment:Qt.AlignCenter
    Layout.preferredWidth: wdth
    Layout.preferredHeight: hght
    background: Rectangle {
        // implicitWidth: wdth
        // implicitHeight: hght
        Layout.preferredWidth: wdth
        Layout.preferredHeight: hght
        opacity: opac
        color: root.clr
    }
    contentItem: item
    // anchors.fill: parent
    onClicked: btnclick()
}

