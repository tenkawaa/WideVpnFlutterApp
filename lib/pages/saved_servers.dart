import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wide_vpn/api/available_servers.dart';
import 'package:wide_vpn/bloc/servers_bloc.dart';
import 'package:wide_vpn/theme/nav_bar.dart';
import 'package:wide_vpn/widgets/available_servers.dart';

class WideVpnSavedServers extends StatefulWidget {
  const WideVpnSavedServers({super.key});

  @override
  State<WideVpnSavedServers> createState() => _WideVpnSavedServersState();
}

class _WideVpnSavedServersState extends State<WideVpnSavedServers> {
  final _savedServersBloc = SavedServersBloc(SavedServers());
  var servers = <SavedServer>[];

  @override
  void initState() {
    super.initState();
    _savedServersBloc.add(LoadSavedServers());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: navBar,
      child: SafeArea(
        child: Center(
          child: Column(
            children: [
              BlocBuilder<SavedServersBloc, SavedServersState>(
              bloc: _savedServersBloc,
              builder: (context, state) {
                if (state is SavedServersLoaded) {
                  return Padding(
                    padding: const EdgeInsets.only(
                      right: 16,
                      left: 16,
                      bottom: 8
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height - 220,
                      child: ListView.builder(
                        itemCount: state.savedServers.length + 1,
                        itemBuilder: (context, index) {
                          if (index == state.savedServers.length) {
                            return TextButton(
                              child: const Text("добавить сервер"),
                              onPressed: () async {await SavedServers.addNewServer(context, null);},
                            );
                          }
                          return state.savedServers[index];
                        },
                      ),
                    ),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(color: CupertinoColors.black,),
                );
              },
              ),
            ],
          ),
        )
      ),
    );
  }
  
}