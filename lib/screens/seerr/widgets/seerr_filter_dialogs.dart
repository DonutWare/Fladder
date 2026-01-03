import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'package:fladder/providers/seerr_api_provider.dart';
import 'package:fladder/providers/seerr_search_provider.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/seerr/seerr_models.dart';
import 'package:fladder/theme.dart';
import 'package:fladder/util/debouncer.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/util/refresh_state.dart';
import 'package:fladder/widgets/shared/adaptive_range_input.dart';

String yearLabel(BuildContext context, SeerrFilterModel filters) {
  final minYear = filters.yearGte;
  final maxYear = filters.yearLte;

  if (minYear == null && maxYear == null) return context.localized.year(1);
  if (minYear != null && maxYear != null) return '${context.localized.year(1)}: $minYear-$maxYear';
  if (minYear != null) return '${context.localized.year(1)}: $minYear+';
  return '${context.localized.year(1)}: <=$maxYear';
}

String ratingLabel(BuildContext context, SeerrFilterModel filters) {
  final minRating = filters.voteAverageGte;
  final maxRating = filters.voteAverageLte;

  if (minRating == null && maxRating == null) return context.localized.rating(1);
  if (minRating != null && maxRating != null) {
    return '${context.localized.rating(1)}: ${minRating.toStringAsFixed(1)}-${maxRating.toStringAsFixed(1)}';
  }
  if (minRating != null) return '${context.localized.rating(1)}: ${minRating.toStringAsFixed(1)}+';
  return '${context.localized.rating(1)}: <=${maxRating?.toStringAsFixed(1)}';
}

String runtimeLabel(BuildContext context, SeerrFilterModel filters) {
  final minRuntime = filters.runtimeGte;
  final maxRuntime = filters.runtimeLte;

  if (minRuntime == null && maxRuntime == null) return context.localized.runTime;
  if (minRuntime != null && maxRuntime != null) return '${context.localized.runTime}: $minRuntime-$maxRuntime';
  if (minRuntime != null) return '${context.localized.runTime}: $minRuntime+';
  return '${context.localized.runTime}: <=$maxRuntime';
}

Future<void> openSearchModeDialog(
  BuildContext context,
  SeerrSearch notifier,
  SeerrSearchMode selectedMode,
) async {
  return showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(context.localized.search),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          child: ListView(
            shrinkWrap: true,
            children: SeerrSearchMode.values
                .map(
                  (mode) => CheckboxListTile(
                    value: mode == selectedMode,
                    onChanged: (_) {
                      Navigator.pop(dialogContext);
                      notifier.setSearchMode(mode);
                    },
                    title: Row(
                      spacing: 8,
                      children: [
                        Icon(mode.icon),
                        Text(mode.label(context)),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      );
    },
  );
}

Future<void> openYearDialog(
  BuildContext context,
  SeerrSearch notifier,
  SeerrFilterModel filters,
) async {
  final currentYear = DateTime.now().year;
  final sliderMin = currentYear - 100;
  final sliderMax = currentYear + 10;

  return _showRangeDialog(
    context: context,
    title: context.localized.year(1),
    min: sliderMin.toDouble(),
    max: sliderMax.toDouble(),
    initialStart: filters.yearGte?.toDouble(),
    initialEnd: filters.yearLte?.toDouble(),
    divisions: 110,
    wholeNumbers: true,
    allowEmpty: true,
    labelsBuilder: (start, end) => RangeLabels(
      (start ?? sliderMin).toStringAsFixed(0),
      (end ?? sliderMax).toStringAsFixed(0),
    ),
    summaryBuilder: (start, end) => [
      start?.toStringAsFixed(0) ?? context.localized.none,
      end?.toStringAsFixed(0) ?? context.localized.none,
    ].join(' - '),
    onClear: () async => notifier.setYearRange(minYear: null, maxYear: null),
    onSave: (start, end) async => notifier.setYearRange(
      minYear: start?.round(),
      maxYear: end?.round(),
    ),
  );
}

Future<void> openRatingDialog(
  BuildContext context,
  SeerrSearch notifier,
  SeerrFilterModel filters,
) {
  return _showRangeDialog(
    context: context,
    title: context.localized.rating(1),
    min: 0,
    max: 10,
    initialStart: filters.voteAverageGte ?? 0,
    initialEnd: filters.voteAverageLte ?? 10,
    divisions: 100,
    labelsBuilder: (start, end) => RangeLabels(
      (start ?? 0).toStringAsFixed(1),
      (end ?? 10).toStringAsFixed(1),
    ),
    wholeNumbers: false,
    summaryBuilder: (start, end) => '${(start ?? 0).toStringAsFixed(1)} - ${(end ?? 10).toStringAsFixed(1)}',
    onClear: () async {
      notifier.setVoteAverageRange(null, null);
      notifier.submit();
    },
    onSave: (start, end) async {
      notifier.setVoteAverageRange(
        (start ?? 0) > 0 ? start : null,
        (end ?? 10) < 10 ? end : null,
      );
      notifier.submit();
    },
  );
}

Future<void> openRuntimeDialog(
  BuildContext context,
  SeerrSearch notifier,
  SeerrFilterModel filters,
) {
  return _showRangeDialog(
    context: context,
    title: context.localized.runtimeMinutesTitle,
    min: 0,
    max: 300,
    initialStart: (filters.runtimeGte ?? 0).toDouble(),
    initialEnd: (filters.runtimeLte ?? 300).toDouble(),
    divisions: 60,
    labelsBuilder: (start, end) => RangeLabels(
      context.localized.minutesShort((start ?? 0).round()),
      context.localized.minutesShort((end ?? 300).round()),
    ),
    summaryBuilder: (start, end) => context.localized.runtimeRangeMinutes(
      (start ?? 0).round(),
      (end ?? 300).round(),
    ),
    wholeNumbers: true,
    allowEmpty: true,
    onClear: () async {
      notifier.setRuntimeRange(null, null);
      notifier.submit();
    },
    onSave: (start, end) async {
      notifier.setRuntimeRange(
        (start ?? 0) > 0 ? start?.round() : null,
        (end ?? 300) < 300 ? end?.round() : null,
      );
      notifier.submit();
    },
  );
}

Future<void> openSortDialog(
  BuildContext context,
  SeerrSearch notifier,
  SeerrFilterModel filters,
) async {
  return showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(context.localized.sortBy),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          child: ListView(
            shrinkWrap: true,
            children: SeerrSortBy.values
                .map(
                  (sortBy) => CheckboxListTile(
                    value: sortBy == filters.sortBy,
                    onChanged: (_) {
                      if (sortBy != filters.sortBy) {
                        notifier.setSortBy(sortBy);
                        Navigator.pop(dialogContext);
                        notifier.submit();
                      }
                    },
                    title: Text(sortBy.label(context)),
                  ),
                )
                .toList(),
          ),
        ),
      );
    },
  );
}

Future<void> openWatchRegionDialog(
  BuildContext context,
  SeerrSearch notifier,
  SeerrFilterModel filters,
  List<SeerrWatchProviderRegion> watchRegions,
) async {
  final currentRegion = (filters.watchRegion ?? 'US').toUpperCase();
  final regionDisplayNames = <SeerrWatchProviderRegion, String>{
    for (final region in watchRegions) region: region.englishName ?? region.nativeName ?? region.iso31661 ?? '',
  };
  final sortedRegions = [...watchRegions]..sort((a, b) => regionDisplayNames[a]!.compareTo(regionDisplayNames[b]!));

  return showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(context.localized.countryRegion),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.65,
          child: ListView(
            shrinkWrap: true,
            children: sortedRegions.map(
              (region) {
                final code = (region.iso31661 ?? 'US').toUpperCase();
                final isSelected = code == currentRegion;
                return CheckboxListTile(
                  title: Text('${region.englishName ?? region.nativeName ?? region.iso31661 ?? ''} ($code)'),
                  value: isSelected,
                  selected: isSelected,
                  onChanged: (value) {
                    notifier.setWatchRegion(code);
                    Navigator.pop(dialogContext);
                    context.refreshData();
                  },
                );
              },
            ).toList(),
          ),
        ),
      );
    },
  );
}

Future<void> _showRangeDialog({
  required BuildContext context,
  required String title,
  required double min,
  required double max,
  required double? initialStart,
  required double? initialEnd,
  required bool wholeNumbers,
  bool allowEmpty = false,
  int? divisions,
  RangeLabels Function(double? start, double? end)? labelsBuilder,
  String Function(double? start, double? end)? summaryBuilder,
  required Future<void> Function(double? start, double? end) onSave,
  Future<void> Function()? onClear,
}) {
  double? currentStart = initialStart;
  double? currentEnd = initialEnd;

  String defaultSummary(double? start, double? end) {
    if (wholeNumbers) {
      return '${(start ?? min).round()} - ${(end ?? max).round()}';
    }
    return '${(start ?? min).toStringAsFixed(1)} - ${(end ?? max).toStringAsFixed(1)}';
  }

  RangeLabels? buildLabels() {
    if (labelsBuilder == null) return null;
    return labelsBuilder(currentStart, currentEnd);
  }

  void handleRangeChange(double? start, double? end) {
    double? newStart = start;
    double? newEnd = end;

    if (newStart == null && allowEmpty) {
      currentStart = null;
    } else if (newStart != null) {
      newStart = newStart.clamp(min, max).toDouble();
      if (currentEnd != null && newStart > currentEnd!) {
        newStart = currentEnd;
      }
      currentStart = newStart;
    }

    if (newEnd == null && allowEmpty) {
      currentEnd = null;
    } else if (newEnd != null) {
      newEnd = newEnd.clamp(min, max).toDouble();
      if (currentStart != null && currentStart! > newEnd) {
        currentStart = newEnd;
      }
      currentEnd = newEnd;
    }
  }

  return showDialog(
    context: context,
    builder: (dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(title),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                spacing: 12,
                children: [
                  Text((summaryBuilder ?? defaultSummary)(currentStart, currentEnd)),
                  AdaptiveRangeInput(
                    min: min,
                    max: max,
                    start: currentStart,
                    end: currentEnd,
                    divisions: divisions,
                    labels: buildLabels(),
                    wholeNumbers: wholeNumbers,
                    allowEmpty: allowEmpty,
                    onChanged: (start, end) {
                      setState(() {
                        handleRangeChange(start, end);
                      });
                    },
                  ),
                ],
              ),
            ),
            actions: [
              if (onClear != null)
                TextButton(
                  onPressed: () async {
                    await onClear();
                    if (context.mounted) Navigator.pop(dialogContext);
                  },
                  child: Text(context.localized.clear),
                ),
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: Text(context.localized.cancel),
              ),
              TextButton(
                onPressed: () async {
                  await onSave(currentStart, currentEnd);
                  if (context.mounted) Navigator.pop(dialogContext);
                },
                child: Text(context.localized.save),
              ),
            ],
          );
        },
      );
    },
  );
}

Future<void> openStudioDialog(
  BuildContext context,
  SeerrSearch notifier,
  SeerrFilterModel filters,
) async {
  return showDialog(
    context: context,
    builder: (dialogContext) {
      return _StudioSearchDialog(
        notifier: notifier,
        selectedStudio: filters.studio,
      );
    },
  );
}

class _StudioSearchDialog extends StatefulWidget {
  final SeerrSearch notifier;
  final SeerrCompany? selectedStudio;

  const _StudioSearchDialog({
    required this.notifier,
    this.selectedStudio,
  });

  @override
  State<_StudioSearchDialog> createState() => _StudioSearchDialogState();
}

class _StudioSearchDialogState extends State<_StudioSearchDialog> {
  late final TextEditingController _searchController = TextEditingController(text: widget.selectedStudio?.name ?? '');
  final Debouncer _debouncer = Debouncer(const Duration(milliseconds: 500));
  List<SeerrCompany> _searchResults = [];
  bool _isSearching = false;
  SeerrCompany? _selectedStudio;

  @override
  void initState() {
    super.initState();
    _selectedStudio = widget.selectedStudio;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }

    setState(() => _isSearching = true);
    try {
      final api = widget.notifier.ref.read(seerrApiProvider);
      final response = await api.searchCompany(query: query);
      setState(() {
        _searchResults = response.body?.results ?? [];
      });
    } catch (error) {
      setState(() => _searchResults = []);
    } finally {
      setState(() => _isSearching = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.localized.studio(1)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.65,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedTextField(
              controller: _searchController,
              label: '${context.localized.search}...',
              onChanged: (value) {
                _debouncer.run(() {
                  _performSearch(value);
                });
              },
            ),
            const SizedBox(height: 16),
            if (_isSearching)
              const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              )
            else if (_searchResults.isEmpty)
              Center(
                child: Text(context.localized.noResults),
              )
            else
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: _searchResults.map(
                    (studio) {
                      final selected = _selectedStudio?.id == studio.id;
                      return ListTile(
                        selected: selected,
                        selectedTileColor: Theme.of(context).colorScheme.primaryContainer,
                        trailing: studio.logoUrl != null
                            ? Container(
                                width: 120,
                                height: 40,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                  borderRadius: FladderTheme.smallShape.borderRadius,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: studio.logoUrl!,
                                  fit: BoxFit.contain,
                                  errorWidget: (context, url, error) {
                                    return const Icon(IconsaxPlusBold.building);
                                  },
                                ),
                              )
                            : const Icon(IconsaxPlusBold.building),
                        title: Text(studio.name),
                        onTap: () {
                          setState(() => _selectedStudio = studio);
                        },
                      );
                    },
                  ).toList(),
                ),
              ),
          ],
        ),
      ),
      actions: [
        if (_selectedStudio != null)
          TextButton(
            onPressed: () {
              widget.notifier.setStudio(null);
              widget.notifier.submit();
              Navigator.pop(context);
            },
            child: Text(context.localized.clear),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(context.localized.cancel),
        ),
        TextButton(
          onPressed: () {
            widget.notifier.setStudio(_selectedStudio);
            widget.notifier.submit();
            Navigator.pop(context);
          },
          child: Text(context.localized.save),
        ),
      ],
    );
  }
}
