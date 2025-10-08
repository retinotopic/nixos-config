import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Shapes
import QtQml
import "../services"
import "../decorations"
import "../"

BarItem {
    id:root
    objectName:"Network"
    isscrollable: true;
    popupvisible: true
    invtrngl:false
    datamodel: Network.wifinetworks;
    
    property bool inputEnabled: false
    property int selectedConn: -1
    function selectstatus(idx: string): string {
        return Network.selected[0] != idx ? "" :
        Network.selected[1] == Network.state.SELECTED ? "X ": 
        Network.selected[1] == Network.state.PENDING ? " ": " "
    }
        
    delegatecmpnnt: ListDelegateItem {
        id:del
        required property string ssid; required property bool profileExist;
        required property string bars; required property string security;
        required property int index
        property bool inputEnabled: false
        implicitWidth: root.contentWidth
        implicitHeight: root.scaleheightmin
        decor: DecorTriangleItem {
            clr: Settings.colorpick(root.clr,del.index)
        }

        BarContentItem {
            scale: 0.9
            id: netInfo
            visible: !root.inputEnabled || root.selectedConn != index
            anchors.fill: parent
            TextItem {
                id: name
                anchors.left: parent.left
                width: del.width * 0.7
                height: del.height
                
                text: root.selectstatus(index) + ssid + bars 
                color: Settings.dark
            }
            TextItem {
                id: securityType
                anchors.right: parent.right
                width: del.width * 0.3
                height: del.height

                text: security.trim().split(/\s+/).pop()
                color: Settings.dark
            }
            onBtnclick: {
                root.selectedConn = index
                root.inputEnabled = !root.inputEnabled
                Network.selected[0] = index;
                Network.selected[1] = 0;
            }
        }
        Item {
            scale: 0.9
            id: netAction
            visible: root.inputEnabled && root.selectedConn === index
            anchors.fill: parent
            BarContentItem {
                id: backButton
                anchors.left: parent.left
                width: del.width * 0.2
                height: del.height
                contentItem: TextItem {
                    text: "back"
                }
                onBtnclick: {
                    root.inputEnabled = !root.inputEnabled
                }
            }
            InputItem {
                id: inp
                width: del.width * 0.5
                height: del.height
                anchors.horizontalCenter: parent.horizontalCenter
                decor: DecorTriangleItem {
                    clr: Settings.dark
                }
            }
            Item {
                id: action
                anchors.right: parent.right

                width: del.width * 0.3
                height: del.height
                BarContentItem {
                    id: connectAction
                    anchors.left: parent.left
                    width: action.width * 0.5
                    height: action.height
                    contentItem: TextItem {
                        text: "conn"
                    }
                    onBtnclick: {
                        const inptext = inp.gettext()
                        Network.selected[1] = Network.state.PENDING;
                        if (inptext.length === 0) {
                            Network.connectToNetwork(Network.wifinetworks[Network.selected[0]].ssid,
                                "",Network.wifinetworks[Network.selected[0]].profileExist)
                            Network.selected[1] = Network.state.PENDING;
                            return
                        }
                        Network.connectToNetwork(
                            Network.wifinetworks[Network.selected[0]].ssid,inptext,false)
                    }
                }

                BarContentItem {
                    id: deleteAction
                    anchors.right: parent.right
                    width: action.width * 0.5
                    height: action.height
                    contentItem: TextItem {
                        text: "del"
                    }
                }
            }
        }
    }

    BarContentItem {
        width: root.scaleheightmin
        height: root.scaleheightmin
        contentItem: TextItem {
            text: Network.statusConn[0] + " " + Network.statusConn[1]
        }
        onBtnclick: {
                Settings.curridx = root.indx == Settings.curridx ? -1 : root.indx
            Network.getNetworks = true
        }
    }
    InputItem {
        id: input
        decor: DecorTriangleItem {
            clr: Settings.dark
        }
        visible: root.inputactive
        implicitWidth:root.scaleheightmin*5
        implicitHeight:root.scaleheightmin
    }
}
