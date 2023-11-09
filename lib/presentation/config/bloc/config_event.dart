part of 'config_bloc.dart';

abstract class ConfigEvent extends Equatable {
  const ConfigEvent();
}

class ConfigInitEvent extends ConfigEvent {
  const ConfigInitEvent();

  @override
  List<Object?> get props => [];
}
