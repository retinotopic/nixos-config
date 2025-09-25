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
    layoutDirection:Qt.LeftToRight
    orientation:Qt.Horizontal
    highlightFollowsCurrentItem :true
    highlightRangeMode: ListView.StrictlyEnforceRange
    implicitWidth: wdth
    implicitHeight: hght
    Layout.alignment:Qt.AlignCenter
    required property var datamodel;
    required property Component delegatecmpnnt;
    required property real wdth;
    required property real hght;
    delegate: delegatecmpnnt
    model: datamodel
}

