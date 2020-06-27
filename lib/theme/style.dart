import 'package:wallet_apps/index.dart';

class AppStyle {
  static ThemeData myTheme(){
    return ThemeData(
      appBarTheme: AppBarTheme(
        textTheme: TextTheme(bodyText2: TextStyle(color: getHexaColor(AppColors.appBarTextColor))),
        color: Colors.transparent,
        iconTheme: IconThemeData(color: getHexaColor(AppColors.appBarTextColor))
      ),
      /* Color All Text */
      textTheme: TextTheme(bodyText2: TextStyle(color: getHexaColor(AppColors.textColor))),
      canvasColor: getHexaColor("#FFFFFF"),
      cardColor: getHexaColor(AppConfig.darkBlue50),
      bottomAppBarTheme: BottomAppBarTheme(color: getHexaColor(AppConfig.darkBlue50)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: getHexaColor(AppColors.textColor)),
      fontFamily: "Avenir",
      scaffoldBackgroundColor: Colors.transparent
    );
  }
}