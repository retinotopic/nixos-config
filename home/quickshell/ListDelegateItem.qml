import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Shapes
import QtQml

pragma ComponentBehavior: Bound

Rectangle {
    id: root
    required property real wdth;
    required property real hght;
    property color clr: "transparent";
    implicitWidth: wdth
    implicitHeight: hght
    color: "transparent"
    default property alias content: middleContent.data

    RowLayout {
        id: rwlt
        spacing: -0.8
        anchors.centerIn:root
        scale:0.75
        TriangleItem { inverted:false; hght:root.height; clr:root.clr}
        RowLayout {
            id: middleContent
            Layout.alignment: Qt.AlignVCenter
        }
        TriangleItem { inverted:true; hght:root.height; clr:root.clr }
    }
}
