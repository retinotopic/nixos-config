pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    // property ListModel listm: ListModel {id: netlistmodel}
    property list<var> allNetworks: []
    property bool wifiEnabled: true
    readonly property bool scanning: rescanProc.running

    function enableWifi(enabled: bool): void {
        const cmd = enabled ? "on" : "off";
        enableWifiProc.exec(["nmcli", "radio", "wifi", cmd]);
    }

    function toggleWifi(): void {
        const cmd = wifiEnabled ? "off" : "on";
        enableWifiProc.exec(["nmcli", "radio", "wifi", cmd]);
    }

    function rescanWifi(): void {
        rescanProc.running = true;
    }

    function connectToNetwork(ssid: string, password: string): void {
        connectProc.exec(["nmcli", "device", "wifi", "connect",ssid,"password",password]);
        // ???
        connectProc.exec(["nmcli", "conn", "up", ssid]);
    }

    function disconnectFromNetwork(): void {
        if (active) {
            disconnectProc.exec(["nmcli", "connection", "down", active.ssid]);
        }
    }

    function getWifiStatus(): void {
        wifiStatusProc.running = true;
    }

    Process {
        running: true
        command: ["nmcli", "m"]
        stdout: SplitParser {
            onRead: getNetworks.running = true
        }
    }

    Process {
        id: wifiStatusProc
        running: true
        command: ["nmcli", "radio", "wifi"]
        environment: ({
                LANG: "C.UTF-8",
                LC_ALL: "C.UTF-8"
            })
        stdout: StdioCollector {
            onStreamFinished: {
                root.wifiEnabled = text.trim() === "enabled";
            }
        }
    }

    Process {
        id: enableWifiProc
        onExited: {
            root.getWifiStatus();
            getNetworks.running = true;
        }
    }

    Process {
        id: rescanProc
        command: ["nmcli", "dev", "wifi", "list", "--rescan", "yes"]
        onExited: {
            getNetworks.running = true;
        }
    }

    Process {
        id: connectProc
        stdout: SplitParser {
            onRead: getNetworks.running = true
        }
        stderr: StdioCollector {
            onStreamFinished: console.warn("Network connection error:", text)
        }
    }

    Process {
        id: disconnectProc
        stdout: SplitParser {
            onRead: getNetworks.running = true
        }
    }

    Process {
        id: getNetworks
        running: true
        command: ["nmcli", "-t", "device", "wifi", "list"]
        environment: ({
            LANG: "C.UTF-8",
            LC_ALL: "C.UTF-8"
        })
        stdout: StdioCollector {
            onStreamFinished: {
                const PLACEHOLDER = "STRINGWHICHHOPEFULLYWONTBEUSED";
                const rep = new RegExp("\\\\:", "g");
                const rep2 = new RegExp(PLACEHOLDER, "g");

                root.allNetworks = text.trim().split("\n").map(n => {
                    const net = n.replace(rep, PLACEHOLDER).split(":");
                    return {
                        active: net[0] === "*",
                        bssid: net[1]?.replace(rep2, ":") ?? "",
                        ssid: net[2],
                        signal: parseInt(net[6]),
                        bars: net[7],
                        security: net[8] || "",
                    };
                }).filter(n => n.ssid && n.ssid.length > 0);
            }
        }
    // Process {
    //     id: getNetworks
    //     running: true
    //     command: ["nmcli", "-g", "ACTIVE,SIGNAL,FREQ,SSID,BSSID,SECURITY", "d", "w"]
    //     environment: ({
    //             LANG: "C.UTF-8",
    //             LC_ALL: "C.UTF-8"
    //         })
    //     stdout: StdioCollector {
    //         onStreamFinished: {
    //             const PLACEHOLDER = "STRINGWHICHHOPEFULLYWONTBEUSED";
    //             const rep = new RegExp("\\\\:", "g");
    //             const rep2 = new RegExp(PLACEHOLDER, "g");

    //             const allNetworks = text.trim().split("\n").map(n => {
    //                 const net = n.replace(rep, PLACEHOLDER).split(":");
    //                 return {
    //                     active: net[0] === "yes",
    //                     strength: parseInt(net[1]),
    //                     frequency: parseInt(net[2]),
    //                     ssid: net[3],
    //                     bssid: net[4]?.replace(rep2, ":") ?? "",
    //                     security: net[5] || ""
    //                 };
    //             }).filter(n => n.ssid && n.ssid.length > 0);

    //             // Group networks by SSID and prioritize connected ones
    //             const networkMap = new Map();
    //             for (const network of allNetworks) {
    //                 const existing = networkMap.get(network.ssid);
    //                 if (!existing) {
    //                     networkMap.set(network.ssid, network);
    //                 } else {
    //                     // Prioritize active/connected networks
    //                     if (network.active && !existing.active) {
    //                         networkMap.set(network.ssid, network);
    //                     } else if (!network.active && !existing.active) {
    //                         // If both are inactive, keep the one with better signal
    //                         if (network.strength > existing.strength) {
    //                             networkMap.set(network.ssid, network);
    //                         }
    //                     }
    //                 }
    //             }
    //             for (const [key, value] of networkMap) {
    //                 netlistmodel.append(value);
    //             }
    //         }
    //     }
    }
}
