part of 'config_bloc.dart';

class ConfigState extends Equatable {
  const ConfigState({this.version = '0'});

  final String version;

  ConfigState copyWith({ordersWebUrl, blogUrl, version}) {
    return ConfigState(
      version: version ?? this.version,
    );
  }

  @override
  List<Object> get props => [version];
}
