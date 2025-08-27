import Quickshell // or PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQml

Item {
    id: baritems
    // required property int windowWidth;
    // required property int windowHeight;
    required property int align;

    // Layout.preferredWidth: windowWidth/3
    // Layout.preferredHeight: parent.height/25
    // Layout.minimumHeight: 30
        // height:parent.height
    // Layout.alignment: Qt.AlignTop
    // height:parent.height
    // anchors.verticalCenter: parent.verticalCenter
    // anchors.fill: parent
    anchors {
        // verticalCenter: parent.verticalCenter
        // top: parent.top
        fill: parent
    }

    RowLayout {
        spacing:0
        // LayoutMirroring.enabled: true
        // LayoutMirroring.childrenInherit: true
        id: contentRow
        // width:baritems.width
        // height:parent.height
        // Layout.alignment: Qt.AlignTop
        anchors {
            left: baritems.align === 0 ? baritems.left : undefined
            right: baritems.align === 2 ? baritems.right : undefined
            horizontalCenter: baritems.align === 1 ? baritems.horizontalCenter: undefined
            top: parent.top
            margins: 0
        }
    }
    default property alias content: contentRow.data
}


