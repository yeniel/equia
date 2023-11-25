import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equia/presentation/agenda/bloc/agenda_bloc.dart';
import 'package:equia/presentation/widgets/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AgendaPage extends StatelessWidget {
  const AgendaPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const AgendaPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AgendaBloc(
        userRepository: context.read<UserRepository>(),
        analyticsManager: context.read<AnalyticsManager>(),
      )..add(const AgendaInitEvent()),
      child: const AgendaView(),
    );
  }
}

class AgendaView extends StatelessWidget {
  const AgendaView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;

    return BaseView(
      title: S.agenda,
      child: Expanded(
        child: BlocBuilder<AgendaBloc, AgendaState>(
          builder: (context, state) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: 30,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Text('Item $index'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
