import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:material_ui/material_ui.dart';

Future<DateTime?> showAdaptiveDatePicker(
  BuildContext context, {
  DateTime? initialDateTime,
}) async {
  final ThemeData theme = Theme.of(context);
  if (theme.platform == TargetPlatform.iOS) {
    return _buildCupertinoDatePicker(
      context,
      initialDateTime: initialDateTime,
    );
  } else {
    return _buildMaterialDatePicker(
      context,
      initialDateTime: initialDateTime,
    );
  }
}

Future<DateTime?> _buildCupertinoDatePicker(
  BuildContext context, {
  DateTime? initialDateTime,
}) async {
  DateTime? newDate;
  showModalBottomSheet(
    context: context,
    builder: (BuildContext builder) {
      return Container(
        height: MediaQuery.of(context).copyWith().size.height / 3,
        color: Theme.of(context).colorScheme.surface,
        child: CupertinoDatePicker(
          onDateTimeChanged: (value) {
            newDate = value;
          },
          initialDateTime: initialDateTime,
          dateOrder: DatePickerDateOrder.ymd,
        ),
      );
    },
  );
  return newDate;
}

Future<DateTime?> _buildMaterialDatePicker(
  BuildContext context, {
  DateTime? initialDateTime,
}) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: initialDateTime ?? DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2025),
  );
  return picked;
}
