import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wide_vpn/api/available_servers.dart';
import 'package:wide_vpn/bloc/servers_bloc.dart';
import 'package:wide_vpn/theme/nav_bar.dart';

class WideVpnServersPage extends StatefulWidget {
  const WideVpnServersPage({super.key});

  @override
  State<WideVpnServersPage> createState() => _WideVpnServersPageState();
}

class _WideVpnServersPageState extends State<WideVpnServersPage> {
  final _availableServersBloc = ServersBloc(AvailableServers());

  @override
  void initState() {
    super.initState();
    _availableServersBloc.add(LoadServers());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: navBar,
      child: SafeArea(
        child: BlocBuilder<ServersBloc, ServersState>(
          bloc: _availableServersBloc,
          builder: (context, state) {
            if (state is ServersLoaded) {
              return CupertinoListSection.insetGrouped(
                  children: state.availableServers
              );
            }
            return const Center(
              child: CircularProgressIndicator(color: CupertinoColors.black,),
            );
          },
        ),
      ),
    );
  }
}