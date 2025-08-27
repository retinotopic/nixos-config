import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell.Widgets


ShellRoot {
    id:root
    Loader {
        active:true
        sourceComponent: Bar {} 
    }
}
