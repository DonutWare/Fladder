sealed class WatchedState {
  const WatchedState();
}

final class Played extends WatchedState {
  const Played();
}

final class Unplayed extends WatchedState {
  const Unplayed();
}

final class PartiallyPlayed extends WatchedState {
  final String label;

  const PartiallyPlayed(this.label);
}
