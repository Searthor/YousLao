import 'package:get/get.dart';
import 'package:yous_app/pages/first_page.dart';
import 'package:yous_app/pages/history_detail_page.dart';
import 'package:yous_app/pages/history_page.dart';
import 'package:yous_app/pages/home_page.dart';
import 'package:yous_app/pages/login_page.dart';
import 'package:yous_app/pages/profile_page.dart';
import 'package:yous_app/pages/splash.dart';
import 'package:yous_app/routes.dart';

final List<GetPage<dynamic>> initRoute = [
  GetPage(name: Routes.splash, page: () => const Splash()),
  GetPage(name: Routes.home, page: () => FirstPage()),
  GetPage(name: Routes.profile, page: () => ProfilePage()),
  GetPage(name: Routes.login, page: () => LoginPage()),
  GetPage(name: Routes.history, page: () => HistoryPage()),
  GetPage(
      name: Routes.historyDetail,
      page: () {
        HistoryDetailPage page = Get.arguments;
        return page;
      }),
];
