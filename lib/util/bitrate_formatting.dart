// ignore_for_file: constant_identifier_names

extension BitrateFormats on int? {
  String? get audioBitrateFormat {
    final bitrate = this;
    if (bitrate == null) return null;
    return "${(bitrate / 1000).round()} kbps";
  }

  String? get videoBitrateFormat {
    const int VIDEO_HIGH_BITRATE_CUTOFF = 10000000;
    const int Kb = 1000;
    const int Mb = Kb * Kb;

    final bitrate = this;
    if (bitrate == null) return null;
    if (bitrate >= VIDEO_HIGH_BITRATE_CUTOFF) {
      return "${(bitrate / Mb).toStringAsFixed(1)} Mbps";
    } else {
      return "${(bitrate / Kb).round()} kbps";
    }
  }
}
