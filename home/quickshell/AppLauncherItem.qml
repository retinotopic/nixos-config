import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Shapes
import QtQml

BarItem {
    id:root
    clr: "blue";
    index: 1;
    itemcount: 2;
    listmodel: AppLauncher.listm;
    windowwidth: parent.parent.width;
    isscrollable: true;
    popupvisible: true
    onbtnclick: {
        AppLauncher.pathname = sectext.text
        console.log(AppLauncher.pathname)
        AppLauncher.isexec = true;
    }
    // Triangle {
    //     inverted:true
    //     hght:root.height
    //     clr:"red"
    // }
    Button {
        Layout.preferredWidth: root.scalewidthmin
        Layout.preferredHeight: root.height

        opacity:0.4
        Layout.alignment:Qt.AlignCenter
        // anchors.fill: parent
        onClicked: {
           PopupState.curridx = root.index == PopupState.curridx ? -1 : root.index
        }
    }
    RowLayout {
        spacing:-0.8
        
        Triangle {
            inverted:false
            hght:inprect.height
            clr:"#424b50"
        }
        Rectangle {
            id: inprect
            // Layout.alignment:Qt.AlignCenter
            Layout.preferredWidth: root.scalewidthmin
            Layout.preferredHeight: root.height/1.5
            color:"#424b50"
            clip:true
            antialiasing:true
            // border.color: "#424b50"
            // border.width: 1
            TextInput {
                id: inp
                clip:true
                text:"Input here"
                focus:true
                color: "#d3c6aa"
                echoMode: TextInput.Normal
                Layout.fillHeight: true
                Layout.fillWidth: true
                horizontalAlignment : TextInput.AlignHCenter
                verticalAlignment : TextInput.AlignVCenter
                onTextChanged: {
                    AppLauncher.matchstr = text
                }
                opacity:0.4
                Layout.alignment:Qt.AlignCenter
            }
        }
        Triangle {
            inverted:true
            hght:inprect.height
            clr:"#424b50"
        }
    }
}
