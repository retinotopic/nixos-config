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
    property bool isImplicit: true
    required property int idx;
    required property color excludedColor;
    implicitWidth: isImplicit ? wdth : null
    implicitHeight: isImplicit ? hght : null

    width: wdth
    height: hght
    property color clr: Settings.colorpick(excludedColor,idx)
    color: "transparent"
    default property alias content: middleContent.data

    RowLayout {
        id: rwlt
        spacing: -0.8
        anchors.centerIn:root
        scale:0.75
        TriangleItem { inverted:false; hght:root.height; clr:root.clr}
        Rectangle {
            implicitWidth:root.width
            implicitHeight:root.height
            color: root.clr
            RowLayout {
                id: middleContent
                Layout.alignment: Qt.AlignVCenter
            }
        }
        TriangleItem { inverted:true; hght:root.height; clr:root.clr }
    }
}
