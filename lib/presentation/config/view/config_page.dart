import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equia/presentation/config/account/view/account_page.dart';
import 'package:equia/presentation/config/bloc/config_bloc.dart';
import 'package:equia/presentation/widgets/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const ConfigPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      ConfigBloc(
        authService: context.read<AuthService>(),
        userRepository: context.read<UserRepository>(),
        analyticsManager: context.read<AnalyticsManager>(),
      )
        ..add(const ConfigInitEvent()),
      child: const ConfigView(),
    );
  }
}

class ConfigView extends StatelessWidget {
  const ConfigView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;

    return BaseView(
      child: Expanded(
        child: BlocBuilder<ConfigBloc, ConfigState>(
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
                          leading: const Icon(Icons.account_box_rounded),
                          title: Text(S.account),
                          onTap: () => Navigator.of(context).push(AccountPage.route()),
                        ),
                        // TODO: Privacy policy
                        // ListTile(
                        //   leading: const Icon(Icons.privacy_tip),
                        //   title: Text(S.privacy_policy),
                        //   onTap: () {
                        //     final _url = Uri.parse(Constants.privacyPolicyUrl);
                        //
                        //     launchUrl(_url);
                        //   },
                        // ),
                      ],
                    ).toList(),
                  ),
                ),
                Text('${S.version}: ${state.version}'),
              ],
            );
          },
        ),
      ),
    );
  }
}
