pragma Singleton

import QtQuick
import Quickshell

import Quickshell // for PanelWindow
import QtQuick // for Text

Singleton {
    id: root
    
    property var colors: [
        "#d699b6",
        "#e67e80",
        "#e69875",
        "#dbbc7f",
        "#a7c080", 
        "#83c092",
        "#7fbbb3"]

    property list<string> windowcolors: ["#4c7fbbb3","#7fbbb3"]
    property string dark: "#424b50"
    property string white: "#d3c6aa"
    
    property real scaleWidth: 1920
    property real scaleHeight: 1080    

    property int curridx:-1
    property var colorsMap: new Map([
      ["left", -1],
      ["center", -1],
      ["right", -1],
    ])

    property list<int> indexGiveaway:[-1,-1,-1] // color indices for left, center, right bar sides
    property string currObj: ""
    
    function colorpick(excludeColor: string,idx: int): string {
        const rm = idx % colors.length
        if (colors[rm] === excludeColor) {
            return "#d699b6"
        }
        return colors[rm]
    }

    function giveindex(side: string): int {
        const index = colorsMap.get(side)
        colorsMap.set(side,index+1)
        return index+1
    }
}
