import 'package:equia/presentation/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var S = AppLocalizations.of(context)!;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        // TODO: STATUS
        // if (state.status == LoginStatus.submissionFailureInvalidCredentials) {
        //   ScaffoldMessenger.of(context)
        //     ..hideCurrentSnackBar()
        //     ..showSnackBar(
        //       SnackBar(content: Text(S.invalid_credentials_error)),
        //     );
        // } else if (state.status == LoginStatus.submissionFailure) {
        //   ScaffoldMessenger.of(context)
        //     ..hideCurrentSnackBar()
        //     ..showSnackBar(
        //       SnackBar(content: Text(S.server_error)),
        //     );
        // }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(S.loginHead, style: textTheme.headlineMedium, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          _LoginButton(),
        ],
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return ElevatedButton(
          key: const Key('LoginButton'),
          onPressed: () => context.read<LoginBloc>().add(const LoginSubmitted()),
          child: Text(S.login),
        );
      },
    );
  }
}

