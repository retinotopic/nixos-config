pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire

Singleton {
    id: root

    property string cpuUsageKernel: ""
    property string cpuUsageUserspace: ""
    property string cpuTemp: ""
    property string gpuTemp: ""
    property string memoryUsage: ""
    property string diskUsage: ""

    property string clockdate: Qt.formatDateTime(clock.date, "yyyy-MM-dd")
    property string clocktime: Qt.formatDateTime(clock.date, "hh:mm:ss")
    
    property var polls: [1,2,8,32,64] // intervals in seconds (must be power of 2)
    property var pollids: [0,1,1,1,3] // indices in polls
    property list<Process> metrics: [cpuusage,cputemp,gputemp,memusage,diskusage]
    
// niri msg action switch-layout 0
// niri msg keyboard-layouts

    SystemClock {
      id: clock
      precision: SystemClock.Seconds
    }

    Process {
        id: gputemp
        running: false
        command: ["sh","-c",`sensors | awk '/^edge/ {print substr($2,2)}'`]
        stdout: SplitParser { onRead: data => {
            console.log("GPU temp:", data)
            root.gpuTemp = data
        }}
    }
    Process {
        id: cpuusage
        running: false
        command: ["sh","-c",`iostat -c | awk 'NR==4' | awk '{print $1,$3}'`]
        stdout: SplitParser { onRead: data => {
            console.log("CPU usage:", data)
            root.cpuUsageUserspace = data
        }}
    }
    Process {
        id: memusage
        running: false
        command: ["sh","-c",`free -h -L | grep -o "MemUse.*" | awk '{print $2}'`]
        stdout: SplitParser { onRead: data => {
            console.log("MEM usage:", data)
            root.memoryUsage = data
        }}
    }
    Process {
        id: cputemp
        running: false
        command: ["sh","-c",`sensors | grep 'Tctl' | awk '{print $2}'`]
        stdout: SplitParser { onRead: data => {
            console.log("CPU temp:", data)
            root.cpuTemp = data
        }}
    }
    Process {
        id: diskusage
        running: false
        command: ["sh","-c",`dysk -s size-desc --csv -c free -u BINARY | awk 'NR==2' | awk '{print $1}'`]
        stdout: SplitParser { onRead: data => {
            console.log("Disk usage:", data)
            root.diskUsage = data
        }}
    }
    Timer {
        interval: root.polls[minInterval]*1000
        repeat: true
        running: true

        property int counter: 0
        property int minInterval: 0

        onTriggered: {
            counter += root.polls[minInterval]
            for (let i=0; i<root.metrics.length; i++) {
                if (root.polls[minInterval] > root.polls[i]) {
                    minInterval = i
                    counter = 0
                    return
                }
                if (counter % root.polls[root.pollids[i]] === 0) {
                    root.metrics[i].running = true
                }
            }
            if (counter >= root.polls[root.polls.length - 1]) {
                counter = 0
            }
        }
    }
}
