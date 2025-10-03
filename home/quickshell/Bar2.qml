import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Shapes
import QtQml

RowLayout {
    id: root
    anchors.top: parent.top
    Layout.preferredWidth: parent.windowwidth
    Layout.preferredHeight: hght
    property real minheight: 40
    property real scaleFactor: parent.width / Settings.scaleWidth
    property real scaleheightmin: scaleFactor*minheight
    RowLayout {
        
    }
    RowLayout {
        
    }
    RowLayout {
        
    }
}


