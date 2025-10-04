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
    property bool isImplicit: true
    required property int idx;
    required property color excludedColor;
    property color clr: Settings.colorpick(excludedColor,idx)
    color: "transparent"
    default property alias content: middleContent.data

    RowLayout {
        id: rwlt
        spacing: -0.8
        anchors.centerIn:root
        scale:0.75
        TriangleItem {
            inverted:false;
            Layout.preferredWidth:root.height/2;
            Layout.preferredHeight:root.height;
            clr:root.clr}
        Rectangle {
            Layout.preferredWidth:root.width/2
            Layout.preferredHeight:root.height
            color: root.clr
            RowLayout {
                id: middleContent
                Layout.alignment: Qt.AlignVCenter
            }
        }
        TriangleItem {
            inverted:true;
            Layout.preferredWidth:root.height/2;
            Layout.preferredHeight:root.height;
            clr:root.clr
        }
    }
}
