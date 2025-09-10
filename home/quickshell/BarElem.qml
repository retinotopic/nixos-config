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
    required property double pointsize
    required property string txt
    signal btnclick
    Layout.preferredWidth: wdth
    Layout.preferredHeight: hght
    background:null
    opacity:1
    contentItem: Text {
        text: root.txt
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pointSize:root.pointsize
    }
    Layout.alignment:Qt.AlignCenter
    // anchors.fill: parent
    onClicked: btnclick()
}

