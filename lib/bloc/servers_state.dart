part of 'servers_bloc.dart';

class ServersState {}

class ServersInitial extends ServersState {}

class ServersLoading extends ServersState {}

class ServersLoaded extends ServersState {
  ServersLoaded({
    required this.availableServers
  });

  final List<AvailableServer> availableServers;
}


class SavedServersState {}

class SavedServersInitial extends SavedServersState {}

class SavedServersLoading extends SavedServersState {}

class SavedServersLoaded extends SavedServersState {
  SavedServersLoaded({
    required this.savedServers
  });

  final List<SavedServer> savedServers;
}