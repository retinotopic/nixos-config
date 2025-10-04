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
    property color bgclr: Settings.dark
    property color fgclr: Settings.white
    signal textedited
    signal accepted
    signal editingfinished
    function gettext(): string {
        return inp.text
    }
    spacing: -0.8
    scale: visible ? 1.0 : 0.1
    Behavior on scale { 
        ElasticBehavior  {} 
    }
    TriangleItem {
        inverted:false
        Layout.preferredWidth:inprect.height/2;
        Layout.preferredHeight:inprect.height;
        clr: root.bgclr
    }
    Rectangle {
        id: inprect
        Layout.preferredWidth: root.wdth
        Layout.preferredHeight: root.hght
        color:root.bgclr
        clip:true
        FontMetrics  {
            id: textMetrics
            font.pixelSize:15
        }
        TextInput {
            id: inp
            anchors.centerIn: parent
            focus: true
            activeFocusOnPress: true
            activeFocusOnTab: true
            padding : 5
            rightPadding: 5
            color: root.fgclr
            leftPadding: 5
            selectByMouse: true
            text: "S"
            font.pixelSize:20
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            onTextChanged: { font.pixelSize=15*Math.min(1,width/(textMetrics.advanceWidth(text)*1.4));textMetrics.font.pixelSize=font.pixelSize}

            onAccepted: root.accepted()
            onEditingFinished: root.editingfinished()
            onTextEdited: root.textedited()
        }
    }
    TriangleItem {
        inverted:true
        Layout.preferredWidth:inprect.height/2;
        Layout.preferredHeight:inprect.height;
        clr: root.bgclr
    }
}
