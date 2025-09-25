pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    readonly property list<var> networkTypes: [["wifi"," "], ["ethernet"," "]]

    property string status: "󰈂 "
    property var state: Object.freeze({
        SELECTED: 0,
        PENDING: 1,
        ACTIVE: 2,
    });

    property list<int> selected: [-1,0] // index in wifinetworks and state enum value 
    property bool wifiEnabled: true
    property list<var> wifinetworks: []

    function toggleWifi(): void {
        const cmd = wifiEnabled ? "off" : "on";
        enableWifiProc.exec(["nmcli", "radio", "wifi", cmd]);
    }

    function connectToNetwork(ssid: string, password: string,profExist: bool): void {
        console.log(ssid,password,profExist)
        if (!profExist) {
            connectProc.exec(["nmcli", "device", "wifi", "connect",ssid,"password",password]);
            return
        }
        connectProc.exec(["nmcli", "conn", "up", ssid]);
    }

    function disconnectFromNetwork(): void {
        if (active) {
            disconnectProc.exec(["nmcli", "connection", "down", active.ssid]);
        }
    }
    Process {
        id: connectProc
        // stdout: StdioCollector{
        //      onStreamFinished: {
        //         console.log(text) 
        //     }
        // }
        onExited: (exitCode) => {
            console.log(exitCode,"hmm")
            if (exitCode != 0) {
                root.selected[1] = root.state.SELECTED
                return
            }
            root.selected[1] = root.state.ACTIVE
        }
    }
    Process {
        property list<string> cmnd: ["nmcli", "-t","-f","TYPE,STATE","device"]
        id: checkConnections
        running: false
        command: cmnd
        stdout: StdioCollector {
            onStreamFinished: {
                const data = root.splitterse(text)
                console.log(data)
                for (let i = 0; i < data.length; i++) {
                    for (const type of root.networkTypes) {
                        if (data[i][0] === type[0] && data[i][1] === "connected") {
                            root.status = type[1]
                            return
                        }
                    }
                }
                root.status = "󰈂 "
            }
        }
    }
    Process {
        id: dbusNM
        running: true
        command: [ "dbus-monitor" , "--system", "type='signal',interface='org.freedesktop.NetworkManager',member='StateChanged'"]
        stdout: SplitParser {
            onRead: data => {
                console.log(data)
                checkConnections.exec(checkConnections.cmnd)
            }
        }
    }


    Process {
        id: getNetworks
        running: true
        command: ["sh","-c",`
            nmcli -t -f SSID,ACTIVE,BARS,SECURITY device wifi list \
            --rescan yes | while IFS=: read -r ssid active bars sec; do
                if nmcli -t -f NAME connection show | grep -Fxq "$ssid"; then
                    echo "$ssid:$active:$bars:$sec:true"
                else
                    echo "$ssid:$active:$bars:$sec:false"
                fi
            done
        `]
        environment: ({
            LANG: "C.UTF-8",
            LC_ALL: "C.UTF-8"
        })
        stdout: StdioCollector {
            onStreamFinished: {
                root.wifinetworks = []
                const data = root.splitterse(text)
                var activeconn = {}
                data.forEach((net,i) => {
                    if (net[0].length > 0) {
                        console.log(net)
                        const cn = {
                            ssid: net[0],
                            active: net[1] === "yes",
                            bars: net[2],
                            security: net[3] || "--",
                            profileExist: net[4] === "true",
                        }
                        if (net[1] === "yes") {
                            activeconn = cn
                            root.selected = [0,root.state.ACTIVE]
                            return
                        }
                        root.wifinetworks.push(cn)
                    }
                })
                root.wifinetworks.unshift(activeconn)
            }
        }
    }
    function splitterse(text) {
        const res = text.trim().split("\n").map(t => {
            return t.replace(new RegExp("\\\\:", "g"), "").split(":")
        })
        return res
    }
    // Process {
    //     id: getProfiles2
    //     running: root.profilesactive
    //     command: ["nmcli", "conn", "up","iPhone"]
    //     onExited: {
    //         console.log(exitCode,exitStatus)
    //         root.profilesactive = false
    //     }
    //     stdout: StdioCollector {
    //         onStreamFinished: {
    //             console.log("hmmmm")
    //         }
    //     }
    //     stderr: StdioCollector {
    //         waitForEnd: true
    //         onStreamFinished: {
    //             console.log(data,"damn")
    //         }
    //     }
    // }
}
// const Days = Object.freeze({
//     SUNDAY: 0,
//     MONDAY: 1,
//     TUESDAY: 2,
//     WEDNESDAY: 3,
//     THURSDAY: 4,
//     FRIDAY: 5,
//     SATURDAY: 6
// });
