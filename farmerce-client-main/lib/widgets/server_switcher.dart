import 'package:farmerce_client/config/urls.dart';
import 'package:farmerce_client/core/auth_service.dart';
import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../client.dart';
import '../../locator.dart';

class ServerSwitcher extends StatefulWidget {
  final bool disableChanging;

  const ServerSwitcher({Key? key, this.disableChanging = false})
      : super(key: key);

  @override
  State<ServerSwitcher> createState() => _ServerSwitcherState();
}

class _ServerSwitcherState extends State<ServerSwitcher> {
  int lastTap = DateTime.now().millisecondsSinceEpoch;
  int consecutiveTaps = 0;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    await Future.wait(
      [
        getIt.isReady<Urls>(),
        getIt.isReady<PackageInfo>(),
      ],
    );
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const LinearProgressIndicator();
    }
    return ListTile(
      onTap: widget.disableChanging
          ? null
          : () {
              int now = DateTime.now().millisecondsSinceEpoch;
              if (now - lastTap < 1000) {
                consecutiveTaps++;
                if (consecutiveTaps == 3) {
                  Get.toNamed('/server_switcher');
                }
              } else {
                consecutiveTaps = 0;
              }
              lastTap = now;
            },
      title: Text(
        "v${getIt<PackageInfo>().version}",
        textAlign: TextAlign.center,
      ),
      subtitle: Obx(() {
        return Text(
          getIt<Urls>().getServerString(),
          textAlign: TextAlign.center,
        );
      }),
    );
  }
}

class ServerPickerPage extends StatefulWidget {
  const ServerPickerPage({Key? key}) : super(key: key);

  @override
  State<ServerPickerPage> createState() => _ServerPickerPageState();
}

class _ServerPickerPageState extends State<ServerPickerPage> {
  final _log = Logger('ServerSwitcher');

  Future<void> save() async {
    // TODO: @mitesh clean up when user data is clear
    // getIt<Cache>()
    //     .evict("${ast.ProfileType.name.value}:${getIt<AppBloc>().userId}");
    // _log.fine("client server: ${getIt<Client>().hashCode}");
    await getIt<Urls>().saveServer();
    // await cleanRegisterClient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              await save();
              String lastPage = "/root";
              if (getIt<AuthService>().gUserData.value.userProfile != null)
                lastPage = '/home';
              Navigator.of(context).pushNamedAndRemoveUntil(
                  "/root", ModalRoute.withName(lastPage));
            },
            child: Text(
              "Save",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () {
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  for (String server in Urls.serverChoices.keys)
                    RadioListTile<String>(
                      title: Text(
                        server.toUpperCase(),
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        getIt<Urls>()
                            .getServerString(Urls.serverChoices[server]),
                      ),
                      value: server,
                      groupValue: Urls.defaultServerKey.value,
                      onChanged: (value) {
                        if (value == null) return;
                        Urls.defaultServerKey.value = value;
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: const ServerSwitcher(disableChanging: true),
    );
  }
}
