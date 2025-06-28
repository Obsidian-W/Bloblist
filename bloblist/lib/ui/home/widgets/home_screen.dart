import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:bloblist/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
//import 'package:go_router/go_router.dart';

//import '../../../../routing/routes.dart';
//import '../../core/local.dart';
import '../view_models/home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime? _lastPressed;
  late BuildContext _scaffoldContext;

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(
      _backInterceptor,
      zIndex: 1,
      name: "exitInterceptor",
    );
  }

  @override
  void dispose() {
    BackButtonInterceptor.removeByName("exitInterceptor");
    super.dispose();
  }

  bool _backInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    final now = DateTime.now();
    if (_lastPressed == null ||
        now.difference(_lastPressed!) > const Duration(seconds: 2)) {
      _lastPressed = now;
      ScaffoldMessenger.of(_scaffoldContext).removeCurrentSnackBar();
      ScaffoldMessenger.of(_scaffoldContext).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.alertDoubleBack)),
      );
      return true; // Prevent pop
    }
    return false; //Exit
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Tamagochi"),
      ),
      body: Builder(
        builder: (scaffoldContext) {
          _scaffoldContext = scaffoldContext;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('You have pushed the button this many times:'),
                Text('0.0', style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    await widget.viewModel.logout(context);
                    if (mounted) {
                      Navigator.of(context).pushReplacementNamed('/login');
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.actionLogout),
                ),
              ],
            ),
          );
        },
      ),
    ); // This trailing comma makes auto
  }
}
