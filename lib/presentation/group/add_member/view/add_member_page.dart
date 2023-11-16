import 'package:data/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../add_member.dart';

class AddMemberPage extends StatelessWidget {
  const AddMemberPage({super.key, required this.onAddMember});

  final VoidCallback onAddMember;

  static Route route({required VoidCallback onCreateGroup}) {
    return MaterialPageRoute(builder: (_) => AddMemberPage(onAddMember: onCreateGroup));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddMemberBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context),
        groupInvitationsRepository: RepositoryProvider.of<GroupInvitationsRepository>(context),
      )..add(const AddMemberInitEvent()),
      child: AddView(onAddMember: onAddMember),
    );
  }
}

class AddView extends StatelessWidget {
  const AddView({Key? key, required this.onAddMember}) : super(key: key);

  final VoidCallback onAddMember;

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;
    var textTheme = Theme.of(context).textTheme;
    final formKey = GlobalKey<FormBuilderState>();
    final memberEmailFieldKey = GlobalKey<FormFieldState>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<AddMemberBloc, AddMemberState>(
          builder: (context, state) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Icon(Icons.group_add, size: 150),
                  Text(
                    S.add_member_description,
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  FormBuilder(
                    key: formKey,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          key: memberEmailFieldKey,
                          name: 'memberEmail',
                          decoration: InputDecoration(labelText: S.member_email),
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
                      var createEvent = AddMemberAddEvent(
                        memberEmail: memberEmailFieldKey.currentState!.value as String,
                      );

                      context.read<AddMemberBloc>().add(createEvent);

                      onAddMember();
                    },
                    child: Text(S.add_member),
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
