import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Shapes
import QtQml

ListView {
    id: root
    layoutDirection: Qt.LeftToRight
    verticalLayoutDirection:ListView.TopToBottom
    orientation: horizontal ? Qt.Horizontal : Qt.Vertical
    implicitWidth: 80
    implicitHeight: 200
    required property var datamodel;
    required property Component delegatecmpnnt;
    property bool horizontal: true
    delegate: delegatecmpnnt
    model: datamodel
}

