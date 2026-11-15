import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:fladder/models/home_model.dart';
import 'package:fladder/models/library_filters_model.dart';
import 'package:fladder/providers/jellyfin_websocket_provider.dart';
import 'package:fladder/providers/library_filters_provider.dart';

mixin DashboardFiltersMixin<T> on StateNotifier<T> {
  static const _limit = 15;

  final requests = LatestRequests();

  Ref get ref;

  FilterSortKey get filterSortKey;

  List<DashboardFilterModel> get dashboardFilters;

  set dashboardFilters(List<DashboardFilterModel> filters);

  Object _key(String id) => (DashboardFilterModel, id);

  Future<List<DashboardFilterModel>> _fetch(Iterable<LibraryFiltersModel> filters) =>
      Future.wait(filters.map((filter) => filter.fetchDashboardFilter(ref, limit: _limit)));

  Future<void> fetchDashboardFilters() async {
    final filters = ref.read(libraryFiltersByKeyProvider(filterSortKey));
    final revision = requests.startAll([DashboardFilterModel, ...filters.map((filter) => _key(filter.id))]);
    final rows = await _fetch(filters);
    if (!requests.isLatest(DashboardFilterModel, revision)) return;
    final current = {for (final row in dashboardFilters) row.filter.id: row};
    dashboardFilters = rows
        .map((row) => requests.isLatest(_key(row.filter.id), revision) ? row : current[row.filter.id] ?? row)
        .toList();
  }

  Future<void> refreshDashboardFilters(bool Function(LibraryFiltersModel filter) affected) async {
    final filters = dashboardFilters.map((row) => row.filter).where(affected).toList();
    if (filters.isEmpty) return;
    final revision = requests.startAll(filters.map((filter) => _key(filter.id)));
    try {
      final rows = {
        for (final row in await _fetch(filters))
          if (requests.isLatest(_key(row.filter.id), revision)) row.filter.id: row,
      };
      if (rows.isNotEmpty) dashboardFilters = dashboardFilters.map((row) => rows[row.filter.id] ?? row).toList();
    } catch (_) {}
  }
}
