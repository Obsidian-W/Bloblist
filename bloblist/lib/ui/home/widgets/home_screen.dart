import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:bloblist/l10n/app_localizations.dart';
import 'package:bloblist/routing/routes.dart';
import 'package:bloblist/ui/core/themes/dimens.dart';
import 'package:bloblist/ui/home/widgets/todolist_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_3d_controller/flutter_3d_controller.dart';
import 'package:provider/provider.dart';

import '../view_models/home_viewmodel.dart';
import 'home_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Flutter3DController controller = Flutter3DController();
  String srcGlb = 'assets/dq_slime.glb';

  DateTime? _lastPressed;
  late BuildContext _scaffoldContext;

  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(_backInterceptor, zIndex: 1, name: "exitInterceptor");
    controller.onModelLoaded.addListener(() {
      debugPrint('model is loaded : ${controller.onModelLoaded.value}');
    });
  }

  @override
  void dispose() {
    BackButtonInterceptor.removeByName("exitInterceptor");
    super.dispose();
  }

  bool _backInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    final now = DateTime.now();
    if (_lastPressed == null || now.difference(_lastPressed!) > const Duration(seconds: 2)) {
      _lastPressed = now;
      ScaffoldMessenger.of(_scaffoldContext).removeCurrentSnackBar();
      ScaffoldMessenger.of(
        _scaffoldContext,
      ).showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.alertDoubleBack)));
      return true; // Prevent pop
    }
    return false; //Exit
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: const HomeTitle()),
      body: Builder(
        builder: (scaffoldContext) {
          _scaffoldContext = scaffoldContext;
          return Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  //The 3D viewer widget for glb format
                  Flexible(
                    flex: 1,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final maxHeight = MediaQuery.of(context).size.height / 3;
                        final height = constraints.maxHeight > maxHeight ? maxHeight : constraints.maxHeight;

                        return SizedBox(
                          height: height,
                          child: Flutter3DViewer(
                            activeGestureInterceptor: true,
                            progressBarColor: Colors.deepPurple,
                            enableTouch: true,
                            onProgress: (double progressValue) {
                              debugPrint('model loading progress : $progressValue');
                            },
                            onLoad: (String modelAddress) {
                              debugPrint('model loaded : $modelAddress');
                            },
                            onError: (String error) {
                              debugPrint('model failed to load : $error');
                            },
                            controller: controller,
                            src: srcGlb,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: Dimens.paddingVertical),
                  Expanded(
                    child: TodoListView(), // or your ListView widget here
                  ),
                ],
              ),
              Positioned(
                top: Dimens.paddingVertical,
                right: Dimens.paddingHorizontal,
                child: ElevatedButton(
                  onPressed: () async {
                    await viewModel.logout(context);
                    if (context.mounted) {
                      context.go(Routes.login);
                    }
                  },
                  child: Text(AppLocalizations.of(context)!.actionLogout),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
