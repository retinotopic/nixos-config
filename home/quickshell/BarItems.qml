import Quickshell // or PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQml

Item {
    id: root
    required property int align;
    anchors {
        fill: parent
    }
    RowLayout {
        spacing:0
        id: contentRow
        property real windowwidth: root.parent.width
        anchors {
            left: root.align === 0 ? root.left : undefined
            right: root.align === 2 ? root.right : undefined
            horizontalCenter: root.align === 1 ? root.horizontalCenter: undefined
            top: parent.top
            margins: 0
        }
    }
    default property alias content: contentRow.data
}


