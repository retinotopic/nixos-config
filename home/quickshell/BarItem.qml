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
    property int itemcount:6;
    property real scaleFactor: parent.parent.width / 1920

    property ListModel listmodel: AppLauncher.listm 
    // Layout.fillWidth: true
    // Layout.fillHeight: true
    // Layout.maximumWidth: itemWidth/5
    // Layout.minimumWidth: itemHeight/16
    // Layout.preferredWidth: 50
    // property real wScale: parent.parent.width / 1920
    // property real hScale: parent.parent.height / 1080
    // property real scaleFactor: Math.min(wScale, hScale)

    property int modelcnt:0;
    Behavior on implicitWidth { ElasticBehavior {} }
    Behavior on implicitHeight { ElasticBehavior {} }
    property real maxWidth: itemcount * 60
    property real scalewidthmin: scaleFactor*60
    property real scaleheightmin: scaleFactor*40
    implicitWidth:  PopupState.curridx == root.index ? scaleFactor*maxWidth : scalewidthmin
    implicitHeight: scaleheightmin

    
    // ListModel { id: myModel }
    // Component.onCompleted: {
    //     // AppLauncher.matchstr = "sd"
    //     AppLauncher.listmodel = myModel
    // }

    Rectangle {///////////////////////////// POPUP LIST
        id: rect
        clip: true
        // onClipChanged
        anchors.fill: parent
        color: root.clr
        Popup {
            id: popup
            x: root.mapToItem(null, 0, 0).x
            y: root.height
            implicitWidth: root.width
            implicitHeight: scaleheightmin*3
            focus: true
            visible: PopupState.curridx == root.index
            modal: false
            closePolicy: Popup.NoAutoClose
            // background:null
            Rectangle {
                // implicitWidth: popup.width
                // implicitHeight: popup.height
                id: rectpop
                anchors.fill:parent
                color: root.clr
                ListView {
                    anchors.fill: parent
                    model: root.listmodel
                    delegate: Button {
                        implicitWidth: root.width
                        implicitHeight: scaleheightmin
                        Layout.alignment:Qt.AlignCenter
                        id: execbutton
                        Text { id:nameid; text: name }
                        Text { id:pathid; text: path; visible:false}
                        onClicked: {
                            AppLauncher.pathname = pathid.text
                            console.log(AppLauncher.pathname)

                            AppLauncher.isexec = true;
                        }
                    } 
                }
            }
        }
        
        RowLayout {/////////////////////////////////////////////// UPPER BUTTONS
            id :itemsrow
            visible:true
            spacing:0
            // implicitWidth: root.width
            // implicitHeight: root.height
            Layout.alignment:Qt.AlignCenter
            // Layout.fillHeight: true
            // Layout.fillWidth: true
            Button {
                // width: root.scalewidthmin
                // height: root.height
                Layout.preferredWidth: root.scalewidthmin
                Layout.preferredHeight: root.height

                opacity:0.4
                Layout.alignment:Qt.AlignCenter
                // anchors.fill: parent
                onClicked: {
                   PopupState.curridx = root.index == PopupState.curridx ? -1 : root.index
                }
            }
            Button {
                // width: root.scalewidthmin
                // height: root.height
                Layout.preferredWidth: root.scalewidthmin
                Layout.preferredHeight: root.height

                opacity:0.4
                Layout.alignment:Qt.AlignCenter
                // anchors.fill: parent
                onClicked: {
                   PopupState.curridx = root.index == PopupState.curridx ? -1 : root.index;
                   iteminput.visible = true;
                   itemsrow.visible = false
                }
            }
            TextInput {
                id: inp
                // text: inp.text
                text:"Input here"
                focus:true
                echoMode: TextInput.Normal
                Layout.preferredWidth: root.scalewidthmin
                Layout.preferredHeight: root.height
                onAccepted: {
                    AppLauncher.matchstr = text
                }
                opacity:0.4
                Layout.alignment:Qt.AlignCenter
                // anchors.fill: parent

            }
        }
    }
}

