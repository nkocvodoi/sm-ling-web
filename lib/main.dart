import 'package:SMLingg/app/choose_book/book.provider.dart';
import 'package:SMLingg/app/choose_book/choose_book.view.dart';
import 'package:SMLingg/app/class_screen/class.provider.dart';
import 'package:SMLingg/app/lesson/answer/sort_words.dart';
import 'package:SMLingg/app/lesson/finish_screen/finish_lesson.view.dart';
import 'package:SMLingg/app/login/login.provider.dart';
import 'package:SMLingg/app/login/login.view.dart';
import 'package:SMLingg/app/report/report.provider.dart';
import 'package:SMLingg/app/setting/setting.view.dart';
import 'package:SMLingg/app/setting/setting_provider.dart';
import 'package:SMLingg/app/splash_screen/splash_screen.view.dart';
import 'package:SMLingg/app/unit/unit.provider.dart';
import 'package:SMLingg/app/unit/unit.view.dart';
import 'package:SMLingg/models/book/book_list.dart';
import 'package:SMLingg/models/lesson/lesson_info.dart';
import 'package:SMLingg/models/unit/unit_list.dart';
import 'package:SMLingg/utils/api.dart';
import 'package:SMLingg/utils/check_locale.dart';
import 'package:SMLingg/utils/push_notification.dart';
import 'package:SMLingg/utils/shared_preferences.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:provider/provider.dart';

import 'app/class_screen/class.view.dart';
import 'app/lesson/answer/match_pair.dart';
import 'app/lesson/lesson.provider.dart';
import 'app/lesson/lesson.view.dart';
import 'app/loading_screen/loading.view.dart';
import 'app/user_profile/user.profile.service.dart';
import 'config/application.dart';
import 'models/ranking/ranking.dart';
import 'models/user_profile/user.dart';

Future<void> main() async {
  // print(NumberToWord().convert('en-in',int.tryParse("100"))); //hundred
  // print(NumberToWord().convert('en-in',10)); //ten
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance.resamplingEnabled = true;
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  Application.sharePreference = await SpUtil.getInstance();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClassModel()),
        ChangeNotifierProvider(create: (_) => LoginModel()),
        ChangeNotifierProvider(create: (_) => UserProfileService()),
        ChangeNotifierProvider(create: (_) => LessonModel()),
        ChangeNotifierProvider(create: (_) => BookModel()),
        ChangeNotifierProvider(create: (_) => MatchPairModel()),
        ChangeNotifierProvider(create: (_) => UnitModel()),
        ChangeNotifierProvider(create: (_) => SortWordsModel()),
        ChangeNotifierProvider(create: (_) => ReportModel()),
        ChangeNotifierProvider(create: (_) => SettingStates()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp() {
    Application.api = API();
    Application.user = User();
    Application.bookList = BookList();
    Application.unitList = UnitList();
    Application.lessonInfo = LessonInfo();
    Application.ranking = Ranking();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Application.sharePreference.putInt("setGrade", 0);
    PushNotificationsManager().pushNotification();
  }

  @override
  Widget build(BuildContext context) {
    return I18n(
        initialLocale: checkLocale(),
        child: GetMaterialApp(
          defaultTransition: Transition.rightToLeftWithFade,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: [

          ],
          supportedLocales: [const Locale('en', "US"), const Locale('vi', "VN")],
          title: 'SMLing',
          theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            canvasColor: Colors.white,
            accentColor: Colors.redAccent,
            fontFamily: "Quicksand",
          ),
          home: SplashScreen(),
          getPages: [
            GetPage(name: "login", page: () => LoginPage()),
            GetPage(name: "class", page: () => ClassScreen()),
            GetPage(name: "splash", page: () => SplashScreen()),
            GetPage(name: "loading", page: () => LoadingScreen()),
            GetPage(name: "lesson", page: () => LessonScreen()),
            GetPage(name: "book", page: () => ChooseBook()),
            GetPage(name: "unit", page: () => UnitScreen()),
            GetPage(name: "finish", page: () => FinishLessonScreen()),
            GetPage(name: "setting", page: () => Setting()),
          ],
        ));
  }
}
