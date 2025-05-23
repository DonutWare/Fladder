import 'package:desktop_drop/desktop_drop.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/adaptive_layout/adaptive_layout.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FladderFile {
  final String name;
  final String? path;
  final Uint8List? data;
  FladderFile({
    required this.name,
    this.path,
    this.data,
  });

  static final Set<String> imageTypes = {
    "png",
    "jpg",
    "jpeg",
    "webp",
    "gif",
  };

  @override
  String toString() => 'FladderFile(name: $name, path: $path, data: ${data?.length})';
}

class FilePickerBar extends ConsumerStatefulWidget {
  final Function(List<FladderFile> file)? onFilesPicked;
  final Function(String url)? urlPicked;
  final Set<String> extensions;
  final bool multipleFiles;
  final double stripesAngle;
  const FilePickerBar({
    this.onFilesPicked,
    this.urlPicked,
    this.multipleFiles = false,
    this.stripesAngle = -0.90,
    this.extensions = const {},
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilePickerBarState();
}

class _FilePickerBarState extends ConsumerState<FilePickerBar> {
  final TextEditingController controller = TextEditingController();
  bool dragStart = false;
  bool inputField = false;

  @override
  Widget build(BuildContext context) {
    final offColor = Theme.of(context).colorScheme.secondaryContainer;
    final onColor = Theme.of(context).colorScheme.secondaryContainer.withValues(alpha: 0.7);
    final contentColor = Theme.of(context).colorScheme.onSecondaryContainer;
    return DropTarget(
      enable: !inputField,
      onDragEntered: (details) => setState(() => dragStart = true),
      onDragDone: (details) async {
        if (widget.multipleFiles) {
          List<FladderFile> newFiles = [];
          await Future.forEach(details.files, (element) async {
            if (widget.extensions.contains(p.extension(element.path).substring(1))) {
              newFiles.add(
                FladderFile(
                  name: element.name,
                  path: element.path,
                  data: await element.readAsBytes(),
                ),
              );
            }
          });
          widget.onFilesPicked?.call(newFiles);
        } else {
          final file = details.files.lastOrNull;
          if (file != null) {
            widget.onFilesPicked?.call([
              FladderFile(
                name: file.name,
                path: file.path,
                data: await file.readAsBytes(),
              )
            ]);
          }
        }
      },
      onDragExited: (details) => setState(() => dragStart = false),
      child: Container(
        constraints: const BoxConstraints(minHeight: 50, minWidth: 50),
        decoration: BoxDecoration(
          color: Colors.grey,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(widget.stripesAngle, -0),
            stops: [0.0, 0.5, 0.5, 1],
            colors: [offColor, offColor, onColor, onColor],
            tileMode: TileMode.repeated,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: inputField
              ? OutlinedTextField(
                  controller: controller,
                  autoFocus: true,
                  onSubmitted: (value) {
                    if (_parseUrl(value)) {
                      widget.urlPicked?.call(value);
                    }
                    controller.text = "";
                    setState(() => inputField = false);
                  },
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (AdaptiveLayout.of(context).isDesktop || kIsWeb)
                      Row(
                        children: [
                          Text(
                            widget.multipleFiles ? "drop multiple file(s)" : "drop a file",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: contentColor),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            IconsaxPlusBold.folder_add,
                            color: contentColor,
                          )
                        ],
                      ),
                    TextButton(
                      onPressed: () => setState(() => inputField = true),
                      child: Text(
                        "enter a url",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: contentColor),
                      ),
                    ),
                    FilledButton(
                      onPressed: dragStart
                          ? null
                          : () async {
                              FilePickerResult? result = await FilePicker.platform.pickFiles(
                                allowMultiple: widget.multipleFiles,
                                allowedExtensions: widget.extensions.toList(),
                                type: FileType.custom,
                                withData: true,
                              );
                              if (result != null && result.count != 0) {
                                List<FladderFile> newFiles = [];
                                await Future.forEach(result.files, (element) async {
                                  newFiles.add(
                                    FladderFile(
                                      name: element.name,
                                      path: element.path,
                                      data: element.bytes,
                                    ),
                                  );
                                });
                                widget.onFilesPicked?.call(newFiles);
                              }
                              FilePicker.platform.clearTemporaryFiles();
                            },
                      child: Text(
                        widget.multipleFiles ? "file(s) picker" : "file picker",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

bool _parseUrl(String url) {
  if (url.isEmpty) {
    return false;
  }
  if (!Uri.parse(url).isAbsolute) {
    return false;
  }

  if (!url.startsWith('https://') && !url.startsWith('http://')) {
    return false;
  }
  return true;
}
