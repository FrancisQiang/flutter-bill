import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bill/router/application.dart';
import 'package:flutter_bill/router/routes.dart';
import 'package:flutter_bill/util/provider_util.dart';
import 'package:flutter_bill/util/theme_util.dart';
import 'package:provider/provider.dart';
import 'model/global_model.dart';

void main() {
  Router router = Router();
  Routes.configureRoutes(router);
  Application.router = router;
  runApp(ProviderUtil.getGlobalModelAndMyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalModel>(
      builder: (context, globalModel, child) {
        globalModel.getCurrentTheme();
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'flutter bill',
            theme: ThemeUtil.getTheme(globalModel.currentThemeBean),
            home: ProviderUtil.getHomePage()
        );
      },
    );
  }
}
