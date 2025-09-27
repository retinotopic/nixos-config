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
    ["#7fbbb3","#83c092"],]
    property list<string> windowcolors: ["#4c7fbbb3","#7fbbb3"]
    property string dark: "#424b50"
    property string white: "#d3c6aa"
    
    
    property int curridx:-1
    
    function colorpick(excludeColor: string,idx: int): string {
        const rm = idx % colors.length
        if (colors[rm][0] === excludeColor) {
            return "#d699b6"
        }
        return colors[rm][0]
    }
}
