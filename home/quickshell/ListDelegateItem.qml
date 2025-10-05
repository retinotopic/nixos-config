import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Shapes
import QtQml

pragma ComponentBehavior: Bound

Item {
    id: root

    property Component decor: null
    
    Loader {
        anchors.fill: parent
        sourceComponent: root.decor
    }
    
    implicitWidth: 80
    implicitHeight: 40
    scale:0.9
    
}
