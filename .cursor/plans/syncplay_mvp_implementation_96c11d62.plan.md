---
name: SyncPlay MVP Implementation
overview: Implement Jellyfin SyncPlay for synchronized playback between users - MVP scope with group management, basic playback sync (play/pause/seek), WebSocket infrastructure, and time synchronization.
todos:
  - id: models
    content: Create SyncPlay models (group, command, message types) in lib/models/syncplay/
    status: pending
  - id: websocket
    content: Implement WebSocketManager with connection, keep-alive, and message routing
    status: completed
  - id: timesync
    content: Implement TimeSyncService with NTP-like offset calculationImplement SyncPlayApiClient with all REST endpoints
    status: completed
  - id: controller
    content: Implement SyncPlayController with state machine and command scheduling
    status: completed
  - id: adapter
    content: Create SyncPlayPlayerAdapter bridging to BasePlayer
    status: completed
  - id: provider
    content: Create SyncPlayProvider for Riverpod state management
    status: completed
  - id: ui-fab
    content: Add SyncPlay FAB to home screen dashboard
    status: completed
  - id: ui-sheet
    content: Create group list/create bottom sheet
    status: completed
  - id: ui-badge
    content: Add sync indicator badge to video player controls
    status: completed
  - id: player-integration
    content: Hook player events to report buffering/ready and intercept user actions
    status: completed
---

# SyncPlay MVP Implementation

## Architecture Overview

```mermaid
flowchart TB
    subgraph UI[UI Layer]
        FAB[SyncPlay FAB]
        Sheet[Group List Sheet]
        Badge[Player Sync Badge]
    end
    
    subgraph State[State Management]
        Provider[SyncPlayProvider]
        GroupState[Group State]
    end
    
    subgraph Core[Core Services]
        Controller[SyncPlayController]
        TimeSync[TimeSyncService]
        API[SyncPlayApiClient]
        WS[WebSocketManager]
    end
    
    subgraph Player[Player Integration]
        Adapter[SyncPlayPlayerAdapter]
        BasePlayer[Existing BasePlayer]
    end
    
    FAB --> Sheet
    Sheet --> Provider
    Badge --> Provider
    Provider --> Controller
    Controller --> TimeSync
    Controller --> API
    Controller --> WS
    Controller --> Adapter
    Adapter --> BasePlayer
```

## Key Files to Create

| File | Purpose |

|------|---------|

| `lib/services/syncplay/websocket_manager.dart` | WebSocket connection, keep-alive, message routing |

| `lib/services/syncplay/time_sync_service.dart` | NTP-like clock offset calculation |

| `lib/services/syncplay/syncplay_controller.dart` | Command handling, state machine, scheduling |

| `lib/providers/syncplay_provider.dart` | Riverpod state management |

| `lib/widgets/syncplay/syncplay_fab.dart` | FAB widget for home screen |

| `lib/widgets/syncplay/syncplay_group_sheet.dart` | Bottom sheet for group list/create |

| `lib/widgets/syncplay/syncplay_badge.dart` | Badge indicator for player controls |

| `lib/wrappers/syncplay_player_adapter.dart` | Adapter bridging SyncPlay to `BasePlayer` |

## Existing Generated API (No Implementation Needed)

The Jellyfin client at `lib/jellyfin/jellyfin_open_api.swagger.dart` already provides:

**Endpoints:**

- `syncPlayListGet()`, `syncPlayNewPost()`, `syncPlayJoinPost()`, `syncPlayLeavePost()`
- `syncPlayPausePost()`, `syncPlayUnpausePost()`, `syncPlayStopPost()`
- `syncPlaySeekPost()`, `syncPlayBufferingPost()`, `syncPlayReadyPost()`, `syncPlayPingPost()`
- `syncPlaySetNewQueuePost()`, `getUtcTimeGet()`

**Models:**

- `GroupInfoDto`, `SyncPlayCommandMessage`, `SyncPlayGroupUpdateMessage`
- `BufferRequestDto`, `ReadyRequestDto`, `SeekRequestDto`, `PingRequestDto`
- `UtcTimeResponse`, `PlayQueueUpdate`, etc.

## Key Files to Modify

- [`lib/screens/home_screen.dart`](lib/screens/home_screen.dart) - Add SyncPlay FAB to dashboard destination
- [`lib/screens/video_player/video_player_controls.dart`](lib/screens/video_player/video_player_controls.dart) - Add sync badge, intercept user actions
- [`lib/wrappers/media_control_wrapper.dart`](lib/wrappers/media_control_wrapper.dart) - Hook SyncPlay adapter

## Implementation Details

### 1. WebSocket Manager

- Connect to `wss://{server}/socket?api_key={token}&deviceId={deviceId}`
- Handle `ForceKeepAlive` with half-interval pings
- Route `SyncPlayCommand` and `SyncPlayGroupUpdate` messages
- Auto-reconnect with exponential backoff

### 2. Time Sync Service

- Use `/GetUtcTime` endpoint with T1-T4 timestamps
- Calculate offset: `((T2 - T1) + (T3 - T4)) / 2`
- Store 8 measurements, use minimum delay
- Greedy polling (1s) for first 3 pings, then 60s intervals
- Provide `remoteDateToLocal()` / `localDateToRemote()` converters

### 3. SyncPlay Controller

- State machine: Idle -> Waiting -> Playing/Paused
- Command scheduling with `Timer` for future execution
- Duplicate command detection (When + Position + Command + PlaylistItemId)
- Player event interception (distinguish user vs SyncPlay actions)
- Uses existing generated API client methods directly (no new API wrapper needed)

### 4. Player Adapter

Bridge between SyncPlay and existing `BasePlayer` / `MediaControlsWrapper`:

class SyncPlayPlayerAdapter {

final BasePlayer player;

bool _syncPlayAction = false; // Flag to distinguish SyncPlay vs user actions

// Wrap play/pause/seek to set flag

Future<void> syncPlayPause() async {

_syncPlayAction = true;

await player.pause();

_syncPlayAction = false;

}

// Expose streams for buffering/ready detection

Stream<bool> get onBuffering => player.stateStream.map((s) => s.buffering);

}

### 5. UI Components

- **FAB**: Icon changes when in sync session (normal: people icon, active: sync icon with badge)
- **Group Sheet**: List of groups with avatars, tap to join, "Create Group" button with name input
- **Player Badge**: Small indicator in player controls showing sync active + group name

## Data Flow: Join Group and Play

```mermaid
sequenceDiagram
    participant User
    participant FAB
    participant Sheet
    participant Provider
    participant API
    participant WS
    participant Player

    User->>FAB: Tap
    FAB->>Sheet: Open
    Sheet->>API: GET /SyncPlay/List
    API-->>Sheet: Groups[]
    User->>Sheet: Tap group
    Sheet->>API: POST /SyncPlay/Join
    API-->>WS: GroupJoined message
    WS->>Provider: Update state
    Provider->>Sheet: Close, show badge
    
    Note over User: Browses library, selects media
    User->>Player: Play media
    Player->>API: POST /SyncPlay/SetNewQueue
    API-->>WS: PlayQueue update
    WS->>Provider: Sync to all clients
```

## Out of Scope (Future)

- SpeedToSync / SkipToSync drift correction
- Playlist queue management UI
- Participant list display
- Chat functionality