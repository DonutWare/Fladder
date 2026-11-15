import 'package:material_ui/material_ui.dart';

class ThemesData extends InheritedWidget {
  const ThemesData({
    super.key,
    required this.light,
    required this.dark,
    required super.child,
  });

  final ThemeData light;
  final ThemeData dark;

  static ThemesData? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ThemesData>();
  }

  static ThemesData of(BuildContext context) {
    final ThemesData? result = maybeOf(context);
    return result!;
  }

  @override
  bool updateShouldNotify(ThemesData oldWidget) => light != oldWidget.light || dark != oldWidget.dark;
}
