import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'config_event.dart';

part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  ConfigBloc({
    required UserRepository userRepository,
    required AnalyticsManager analyticsManager,
  })  : _analyticsManager = analyticsManager,
        super(const ConfigState()) {
    on<ConfigInitEvent>(_onConfigInitEvent);
  }

  final AnalyticsManager _analyticsManager;

  Future<void> _onConfigInitEvent(ConfigInitEvent event, Emitter<ConfigState> emit) async {
    var packageInfo = await PackageInfo.fromPlatform();
    var version = '${packageInfo.version}+${packageInfo.buildNumber}';

    emit(state.copyWith(version: version));
    _analyticsManager.logEvent(ConfigPageEvent());
  }
}
