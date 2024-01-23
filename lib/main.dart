import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:udharproject/Utils/MutipleLanguage/MutipleLangaugePage.dart';
import 'package:udharproject/Utils/Routesss/RoutesName.dart';
import 'package:udharproject/Utils/Routesss/RoutesPages.dart';
import 'Colors/ColorsClass.dart';
import 'package:device_preview/device_preview.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DevicePreview(
    enabled: true,
    builder: (context) => const MyApp(),
  ));


  //runApp(const MyApp());



}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
    return GestureDetector(onTap: () {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus)
      {
        currentFocus.unfocus();
      }
    },
        child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            translations: MultipleLanguagePage(),
            locale: Locale('hi','In'),
            theme: ThemeData(
              visualDensity: VisualDensity.adaptivePlatformDensity,
              colorScheme: ColorScheme.light(
                primary:  AppColors.lightColorTheme,
                secondary: AppColors.drakColorTheme,

              ),),

            initialRoute: RoutesNamess.splashscreen,
            onGenerateRoute: RoutesPages.generateRoute));
  }
}