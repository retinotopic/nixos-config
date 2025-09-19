pragma Singleton

pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris

Singleton {
    id: root
    readonly property list<MprisPlayer> availablePlayers: Mpris.players.values

    property MprisPlayer activePlayer: availablePlayers.find(p => p.isPlaying) ?? availablePlayers.find(p => p.canControl && p.canPlay) ?? null

    function list(): string {
        return availablePlayers.map(p => p.identity).join("\n")
    }

    function play(): void {
        if (activePlayer && activePlayer.canPlay) {
            activePlayer.play()
        }
    }

    function pause(): void {
        if (activePlayer && activePlayer.canPause) {
            activePlayer.pause()
        }
    }

    function playPause(): void {
        if (activePlayer && activePlayer.canTogglePlaying) {
            activePlayer.togglePlaying()
        }
    }

    function previous(): void {
        if (activePlayer && activePlayer.canGoPrevious) {
            activePlayer.previous()
        }
    }

    function next(): void {
        if (activePlayer && activePlayer.canGoNext) {
            activePlayer.next()
        }
    }

    function stop(): void {
        if (activePlayer) {
            activePlayer.stop()
        }
    }
}
