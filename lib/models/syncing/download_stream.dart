import 'package:background_downloader/background_downloader.dart' as dl;

class DownloadStream {
  final String id;
  final dl.DownloadTask? task;
  final double progress;
  final String downloadSpeed;
  final dl.TaskStatus status;
  DownloadStream({
    required this.id,
    this.task,
    this.progress = -1,
    this.downloadSpeed = "",
    required this.status,
  });

  DownloadStream.empty()
      : id = '',
        task = null,
        progress = -1,
        downloadSpeed = "",
        status = dl.TaskStatus.notFound;

  bool get hasDownload => progress != -1.0 && status != dl.TaskStatus.notFound && status != dl.TaskStatus.complete;

  DownloadStream copyWith({
    String? id,
    dl.DownloadTask? task,
    double? progress,
    String? downloadSpeed,
    dl.TaskStatus? status,
  }) {
    return DownloadStream(
      id: id ?? this.id,
      task: task ?? this.task,
      progress: progress ?? this.progress,
      downloadSpeed: downloadSpeed ?? this.downloadSpeed,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'DownloadStream(id: $id, task: $task, progress: $progress, status: $status)';
  }
}
