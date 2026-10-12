import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/app/di.dart';

import 'package:device_preview_plus/device_preview_plus.dart';

import '/presentation/resources/app_routes.dart';
import '/presentation/resources/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initAppModule();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp._internal();
  static final MyApp _instance = MyApp._internal();
  factory MyApp() => _instance;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliveryApp',
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
    );
  }
}

//https://dummyjson.com/recipes

/**app/build.gradle
  compileOptions {
        isCoreLibraryDesugaringEnabled = true
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    

  

    flutter {
    source = "../.."
}
 
   dependencies{
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
}

 */

/**
 * android/gradle.properties
 
kotlin.incremental=false
kotlin.daemon.useFallbackStrategy=true
kotlin.incremental.useClasspathSnapshot=false
 */

/**
 * flutter clean
flutter pub cache repair
gradlew --stop
gradlew clean
 */

/*rules:
   - prefer_const_constructors 
   - prefer_const_literals_to_create_immutables 
   - prefer_const_declarations*/
