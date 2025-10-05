import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Shapes
import QtQml


Item {
    id:root
    property color bgclr: Settings.dark
    property color fgclr: Settings.white
    property Component decor: null
    
    signal textedited
    signal accepted
    signal editingfinished
    function gettext(): string {
        return inp.text
    }

    Loader {
        scale: 0.8
        anchors.fill: parent
        sourceComponent: root.decor
    }
    
    scale: visible ? 1.0 : 0.1
    Behavior on scale { 
        ElasticBehavior  {} 
    }
    implicitWidth: 80
    implicitHeight: 40
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
