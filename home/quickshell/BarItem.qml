import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQml


Item {
    id:root

    // anchors.fill: parent
    // required property int itemWidth;
    // required property int itemHeight;
    required property color clr;
    required property int index;
    required property int itemcount;
    required property real windowwidth;
    
    property ListModel listmodel;
    property Component delegatecmpnnt;
    
    required property bool popupvisible;
    required property bool isscrollable;
    
    property real scaleFactor: windowwidth / 1920
    Behavior on implicitWidth { ElasticBehavior {} }
    Behavior on implicitHeight { ElasticBehavior {} }
    property real maxWidth: itemcount * 60
    property real scalewidthmin: scaleFactor*60
    property real scaleheightmin: scaleFactor*40
    implicitWidth:  PopupState.curridx == root.index ? scaleFactor*maxWidth : scalewidthmin
    implicitHeight: scaleheightmin

    default property alias content: itemsrow.data
    Rectangle {
        id: rect
        clip: true
        // onClipChanged
        anchors.fill: root
        Layout.fillHeight:true
        Layout.fillWidth:true
        color: root.clr
        Popup {
            id: popup
            x: root.mapToItem(null, 0, 0).x
            y: root.height
            implicitWidth: root.width
            implicitHeight: scaleheightmin*3
            focus: true
            visible: PopupState.curridx == root.index && root.popupvisible
            modal: false
            closePolicy: Popup.NoAutoClose
            margins:0
            padding:0
            Rectangle {
                id: rectpop
                anchors.fill:parent
                color: root.clr
                clip:true
                ListView {
                    anchors.fill: parent
                    model: root.listmodel
                    contentWidth: root.scalewidthmin
                    contentHeight: root.height
                    delegate: root.delegatecmpnnt
                }
            }
        }
        Flickable {
            width: rect.width
            height: rect.height
            interactive:root.isscrollable
            contentWidth: itemsrow.implicitWidth
            contentHeight: itemsrow.implicitHeight
            RowLayout {
                id :itemsrow
                visible:true
                spacing:0
                Layout.alignment:Qt.AlignCenter
            }
        }
        Triangle {
            inverted:true;
            hght:root.height;
            clr:"red";
            width: rect.height/2
            height: rect.height
        }
    }
}

// Button {
//     Layout.preferredWidth: root.scalewidthmin
//     Layout.preferredHeight: root.height

//     opacity:0.4
//     Layout.alignment:Qt.AlignCenter
//     // anchors.fill: parent
//     onClicked: {
//        PopupState.curridx = root.index == PopupState.curridx ? -1 : root.index
//     }
// }


// TextInput {
//     id: inp
//     // text: inp.text
//     text:"Input here"
//     focus:true
//     echoMode: TextInput.Normal
//     Layout.preferredWidth: root.scalewidthmin
//     Layout.preferredHeight: root.height
//     onAccepted: {
//         AppLauncher.matchstr = text
//     }
//     opacity:0.4
//     Layout.alignment:Qt.AlignCenter
//     // anchors.fill: parent

// }
