// ignore_for_file: constant_identifier_names

extension BitrateFormats on int? {
  String? get audioBitrateFormat {
    final bitrate = this;
    if (bitrate == null) return null;
    return "${(bitrate / 1000).round()} kbps";
  }

  String? get videoBitrateFormat {
    const int highBitrateCutoff = 10000000;
    const int kb = 1000;
    const int Mb = kb * kb;

    final bitrate = this;
    if (bitrate == null) return null;
    if (bitrate >= highBitrateCutoff) {
      return "${(bitrate / Mb).toStringAsFixed(1)} Mbps";
    } else {
      return "${(bitrate / kb).round()} kbps";
    }
  }
}
