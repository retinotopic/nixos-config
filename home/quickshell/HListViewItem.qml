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
    // layoutDirection:Qt.B
    orientation: horizontal ? Qt.Horizontal : Qt.Vertical
    // highlightFollowsCurrentItem :true
    // highlightRangeMode: ListView.StrictlyEnforceRange
    implicitWidth: wdth
    implicitHeight: hght
    Layout.alignment:Qt.AlignCenter
    required property var datamodel;
    required property Component delegatecmpnnt;
    required property real wdth;
    required property real hght;
    property bool horizontal: true
    delegate: delegatecmpnnt
    model: datamodel
}

