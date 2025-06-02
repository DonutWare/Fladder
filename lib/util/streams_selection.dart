import 'package:fladder/models/items/media_streams_model.dart';

int? selectAudioStream(
  bool rememberAudioSelection,
  AudioAndSubStreamModel? previousStream,
  List<AudioAndSubStreamModel>? currentStream,
  int? defaultStream,
) {
  if (!rememberAudioSelection) {
    return defaultStream;
  }
  return _selectStream(previousStream, currentStream, defaultStream);
}

int? selectSubStream(
  bool rememberSubSelection,
  AudioAndSubStreamModel? previousStream,
  List<AudioAndSubStreamModel>? currentStream,
  int? defaultStream,
) {
  if (!rememberSubSelection) {
    return defaultStream;
  }
  return _selectStream(previousStream, currentStream, defaultStream);
}

int? _selectStream(
  AudioAndSubStreamModel? previousStream,
  List<AudioAndSubStreamModel>? currentStream,
  int? defaultStream,
) {
  if (currentStream == null || previousStream == null) {
    return defaultStream;
  }

  int? bestStreamIndex;
  int bestStreamScore = 0;

  // Find the relative index of the previous stream
  int prevRelIndex = 0;
  for (var stream in currentStream) {
    if (stream.index == previousStream.index) break;
    prevRelIndex += 1;
  }

  int newRelIndex = 0;
  for (var stream in currentStream) {
    int score = 0;

    if (previousStream.codec == stream.codec) score += 1;
    if (prevRelIndex == newRelIndex) score += 1;
    if (previousStream.displayTitle == stream.displayTitle) {
      score += 2;
    }
    if (previousStream.language != 'und' && previousStream.language == stream.language) {
      score += 2;
    }

    if (score > bestStreamScore && score >= 3) {
      bestStreamScore = score;
      bestStreamIndex = stream.index;
    }

    newRelIndex += 1;
  }
  return bestStreamIndex ?? defaultStream;
}
