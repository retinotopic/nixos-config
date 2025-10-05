import Quickshell // for PanelWindow
import Quickshell.Io
import QtQuick // for Text
import QtQuick.Controls
import Quickshell.Widgets
import QtQuick.Layouts
import QtQuick.Shapes
import QtQml
import "../services"
import "../"

BarItem {
    id:root
    itemcount: 3;
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
            width: root.width
            height: scaleheightmin
            scale: 0.9
            contentItem: RowLayout {
                // width: root.width
                // height:scaleheightmin
                // anchors.fill: del
                // anchors.centerIn: del
                TextItem {
                    Layout.fillHeight: true; Layout.fillWidth: true
                    // Layout.preferredWidth: root.width
                    // Layout.preferredHeight: root.scaleheightmin

                    Layout.alignment: Qt.AlignCenter

                    visible: !root.inputEnabled || root.selectedConn != index
                    
                    text: root.selectstatus(index) + ssid + bars + security.trim().split(/\s+/).pop()
                    color: Settings.dark
                }
                //------- VISIBILITY TRICK, THIS PART WILL SHOW UP ONLY ON CLICKING THE WIFI NETWORK
                BarContentItem {
                    Layout.fillHeight: true; Layout.fillWidth: true
                    Layout.alignment: Qt.AlignCenter
                    
                    width: root.scalewidthmax
                    height: root.height
                    visible: root.inputEnabled && root.selectedConn === index
                    contentItem: TextItem {
                        text: "Back"
                    }
                    onBtnclick: {
                        root.inputEnabled = !root.inputEnabled
                    }
                }
                InputItem {
                    id: inp
                   
                    visible: root.inputEnabled && root.selectedConn === index
                    decor: DecorTriangleItem {
                        clr: Settings.dark
                    }
                    implicitWidth:root.scaleheightmin
                    implicitHeight:root.scaleheightmin/1.5
                }
                BarContentItem {
                    Layout.fillHeight: true; Layout.fillWidth: true
                    Layout.alignment: Qt.AlignCenter
                    
                    width: root.scalewidthmax
                    height: root.height
                    visible: root.inputEnabled && root.selectedConn === index
                    contentItem: TextItem {
                        text: "Connect"
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
            }

            onBtnclick: {
                root.selectedConn = index
                root.inputEnabled = !root.inputEnabled
                Network.selected[0] = index;
                Network.selected[1] = 0;
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
