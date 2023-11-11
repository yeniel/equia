import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equia/presentation/config/config.dart';
import 'package:equia/presentation/widgets/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const AccountPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      AccountBloc(
        authService: context.read<AuthService>(),
        userRepository: context.read<UserRepository>(),
        analyticsManager: context.read<AnalyticsManager>(),
      )
        ..add(const AccountInitEvent()),
      child: const AccountView(),
    );
  }
}

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;

    return BaseView(
      title: S.account,
      child: Expanded(
        child: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: [
                        // TODO: Account data
                        ListTile(
                          leading: const Icon(FontAwesomeIcons.google),
                          title: Text(S.logged_in),
                          subtitle: Text(state.user?.profile.email ?? ''),
                        ),
                        ListTile(
                          leading: const Icon(Icons.logout_rounded),
                          title: Text(S.logout),
                          onTap: () => context.read<AccountBloc>().add(const AccountLogoutEvent()),
                        ),
                      ],
                    ).toList(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
