import "package:flutter_bloc/flutter_bloc.dart";
import "package:wide_vpn/api/available_servers.dart";

import "../widgets/available_servers.dart";

part "servers_state.dart";
part "servers_event.dart";

class ServersBloc extends Bloc<ServersEvent, ServersState> {
  ServersBloc(this.availableServers) : super(ServersInitial()) {
    on<LoadServers>((event, emit) async {
      final availableServersList = await availableServers.getServers();
      availableServersList.sort((a, b) => a.ping.compareTo(b.ping));

      emit(ServersLoaded(availableServers: availableServersList));
    });
  }
  final AvailableServers availableServers;
}

class SavedServersBloc extends Bloc<SavedServersEvent, SavedServersState> {
  SavedServersBloc(this.availableServers) : super(SavedServersInitial()) {
    on<LoadSavedServers>((event, emit) async {
      final savedServersList = await availableServers.getSavedServers();
      if (savedServersList.isNotEmpty) {
        emit(SavedServersLoaded(savedServers: savedServersList));
      }
    });
  }
  final SavedServers availableServers;
}