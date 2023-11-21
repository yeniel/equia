import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equia/presentation/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              authService: RepositoryProvider.of<AuthService>(context),
              analyticsManager: context.read<AnalyticsManager>(),
            );
          },
          child: const LoginView(),
        ),
      ),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(S.loginHead, style: textTheme.headlineMedium, textAlign: TextAlign.center),
            const Image(image: AssetImage('assets/equia_logo_1024.png'), color: Colors.white),
            const SizedBox(height: 8),
            _LoginButton(),
          ],
        ),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(FontAwesomeIcons.google),
              const SizedBox(width: 8),
              Text(S.login),
            ],
          ),
        );
      },
    );
  }
}
