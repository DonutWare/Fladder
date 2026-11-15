import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:fladder/jellyfin/jellyfin_open_api.swagger.dart';
import 'package:fladder/providers/api_provider.dart';

part 'cultures_provider.g.dart';

@riverpod
class Cultures extends _$Cultures {
  @override
  List<CultureDto> build() {
    _fetch();
    return const [];
  }

  Future<void> _fetch() async {
    final api = ref.read(jellyApiProvider);
    final response = await api.localizationCulturesGet();
    if (!ref.mounted) return;
    final cultures = response.body;
    if (cultures != null) {
      state = cultures;
    }
  }
}
