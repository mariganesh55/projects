import 'package:farmerce_client/modules/auth/login_controller.dart';
import 'package:farmerce_client/widgets/server_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logging/logging.dart';

import '../../locator.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  final _log = Logger('LoadingView');

  @override
  void initState() {
    super.initState();
    _log.fine("Loading started");
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _init();
    });
  }

  // GUserData? _tryCachedUser(String uid) {
  //   return getIt<Cache>().readQuery(GUserReq((b) => b..vars.uid = uid));
  // }

  Future<void> _init() async {
    await getIt.allReady();
    // await Future.delayed(Duration(seconds: 1));

    _log.fine("Loading finished");
    Navigator.of(context).pushReplacementNamed('/root');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoadingWidget(),
      bottomNavigationBar: ServerSwitcher(),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Container(
          //   // margin: const EdgeInsets.only(bottom: 20.0),
          //   child: Image.asset(
          //     'assets/logo.png',
          //     height: 120,
          //   ),
          // ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(
              // color: C.yellow,
              strokeWidth: 3.0,
            ),
          ),
          Column(
            children: [
              Text(
                "Learn as if you were to live forever.",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(fontSize: 18.0),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Text(
                "- Mahatma Gandhi",
                style: Theme.of(context).textTheme.subtitle1,
              )
            ],
          )
        ],
      ),
    );
  }
}
