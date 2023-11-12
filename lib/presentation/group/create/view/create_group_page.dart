import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../create_group.dart';

class CreateGroupPage extends StatelessWidget {
  const CreateGroupPage({super.key, required this.onCreateGroup});

  final VoidCallback onCreateGroup;

  static Route route({required VoidCallback onCreateGroup}) {
    return MaterialPageRoute(builder: (_) => CreateGroupPage(onCreateGroup: onCreateGroup));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateGroupBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context),
        groupsRepository: RepositoryProvider.of<GroupsRepository>(context),
      )..add(const CreateGroupInitEvent()),
      child: GroupCreateView(onCreateGroup: onCreateGroup),
    );
  }
}

class GroupCreateView extends StatelessWidget {
  const GroupCreateView({Key? key, required this.onCreateGroup}) : super(key: key);

  final VoidCallback onCreateGroup;

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;
    final formKey = GlobalKey<FormBuilderState>();
    final groupNameFieldKey = GlobalKey<FormFieldState>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<CreateGroupBloc, CreateGroupState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.groups, size: 150),
                  FormBuilder(
                    key: formKey,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          key: groupNameFieldKey,
                          name: 'groupName',
                          decoration: InputDecoration(labelText: S.group_name),
                          validator: FormBuilderValidators.compose([
                            FormBuilderValidators.required(),
                            FormBuilderValidators.email(),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  FilledButton(
                    onPressed: () {
                      var createEvent = CreateGroupCreateEvent(
                        groupName: groupNameFieldKey.currentState!.value as String,
                      );

                      context.read<CreateGroupBloc>().add(createEvent);

                      onCreateGroup();
                    },
                    child: Text(S.create_group),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
