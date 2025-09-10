pragma Singleton

import QtQuick
import Quickshell

import Quickshell // for PanelWindow
import QtQuick // for Text

Singleton {
    id: root
    property var colors: [
    ["#e67e80","#d699b6"],
    ["#e69875","#e67e80"],
    ["#dbbc7f","#e69875"],
    ["#a7c080","#dbbc7f"],
    ["#83c092","#a7c080"],
    ["#7fbbb3","#83c092"],
    ["#7fbbb3","#4c7fbbb3"]]
}
