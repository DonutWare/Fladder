import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fladder/models/view_model.dart';
import 'package:fladder/providers/user_provider.dart';
import 'package:fladder/providers/views_provider.dart';
import 'package:fladder/screens/shared/outlined_text_field.dart';
import 'package:fladder/util/list_padding.dart';
import 'package:fladder/util/localization_helper.dart';
import 'package:fladder/widgets/shared/filled_button_await.dart';

Future<void> openUserCreateDialog(BuildContext context) {
  return showAdaptiveDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => const ControlUserCreate(),
  );
}

class ControlUserCreate extends ConsumerStatefulWidget {
  const ControlUserCreate({super.key});

  @override
  ConsumerState<ControlUserCreate> createState() => _ControlUserCreateState();
}

class _ControlUserCreateState extends ConsumerState<ControlUserCreate> {
  TextEditingController nameController = TextEditingController();
  TextEditingController password = TextEditingController();

  List<ViewModel> selectedLibraries = [];

  bool enableAllLibraries = false;

  @override
  void dispose() {
    nameController.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModels = ref.watch(viewsProvider.select((value) => value.views));
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(context.localized.createNewUser, style: Theme.of(context).textTheme.headlineSmall),
              ListView(
                shrinkWrap: true,
                children: [
                  AutofillGroup(
                    child: Column(
                      spacing: 8,
                      children: [
                        OutlinedTextField(
                          controller: nameController,
                          autoFillHints: const [AutofillHints.username],
                          textInputAction: TextInputAction.next,
                          autocorrect: false,
                          label: context.localized.userName,
                        ),
                        OutlinedTextField(
                          controller: password,
                          autoFillHints: const [AutofillHints.password],
                          keyboardType: TextInputType.visiblePassword,
                          autocorrect: false,
                          textInputAction: TextInputAction.send,
                          label: context.localized.password,
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  //Enable access to all libraries toggle
                  SwitchListTile(
                    title: Text(context.localized.enableAccessAllLibraries),
                    value: enableAllLibraries,
                    onChanged: (value) {
                      setState(() {
                        enableAllLibraries = value;
                      });
                    },
                  ),

                  if (enableAllLibraries == false) ...[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(context.localized.assignLibraries, style: Theme.of(context).textTheme.titleMedium),
                    ),
                    ...viewModels.map(
                      (library) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: CheckboxListTile(
                          title: Text(library.name),
                          value: selectedLibraries.any((element) => element.id == library.id),
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                selectedLibraries.add(library);
                              } else {
                                selectedLibraries.removeWhere((element) => element.id == library.id);
                              }
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                  FilledButtonAwait(
                    onPressed: () async {
                      await ref.read(userProvider.notifier).createNewUser(
                            nameController.text,
                            password.text,
                            enableAllFolders: enableAllLibraries,
                            enabledFolders: enableAllLibraries ? [] : selectedLibraries.map((e) => e.id).toList(),
                          );
                      Navigator.of(context).pop();
                    },
                    child: Text(context.localized.createUser),
                  ),
                ].addInBetween(const SizedBox(height: 12)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
