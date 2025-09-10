import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Shapes
import QtQml


RowLayout {
    id:root
    required property real wdth;
    required property real hght;
    signal textedited
    signal accepted
    signal editingfinished
    function gettext(): string {
        return inp.text
    }
    spacing:-0.8
    Triangle {
        inverted:false
        hght:inprect.height
        clr:"#424b50"
    }
    Rectangle {
        id: inprect
        // Layout.alignment:Qt.AlignCenter
        Layout.preferredWidth: root.wdth
        Layout.preferredHeight: root.hght
        color:"#424b50"
        clip:true
        // antialiasing:true
        // border.color: "#424b50"
        // border.width: 1
        TextInput {
            id: inp
            clip:true
            text:"type text"
            focus:true
            color: "#d3c6aa"
            echoMode: TextInput.Normal
            anchors.centerIn: parent
            // Layout.preferredWidth: root.wdth
            // Layout.preferredHeight: root.hght
            // Layout.fillHeight: true
            // Layout.fillWidth: true
            // horizontalAlignment: TextInput.AlignHCenter
            // verticalAlignment: TextInput.AlignVCenter
            opacity:0.4
            // Layout.alignment:Qt.AlignCenter
            onAccepted: root.accepted()
            onEditingFinished: root.editingfinished()
            onTextEdited: root.textedited()
        }
    }
    Triangle {
        inverted:true
        hght:inprect.height
        clr:"#424b50"
    }
}
