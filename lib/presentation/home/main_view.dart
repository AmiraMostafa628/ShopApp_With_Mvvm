import 'package:clean_architecture/presentation/home/pages/home/view/home_view.dart';
import 'package:clean_architecture/presentation/home/pages/notifications/notification_page.dart';
import 'package:clean_architecture/presentation/home/pages/search/search_page.dart';
import 'package:clean_architecture/presentation/home/pages/setting/settings_page.dart';
import 'package:clean_architecture/presentation/resoures/color_manager.dart';
import 'package:clean_architecture/presentation/resoures/string_manager.dart';
import 'package:clean_architecture/presentation/resoures/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List <Widget> pages = [
    const HomePage(),
    const SearchPage(),
    const NotificationsPage(),
    const SettingsPage(),
  ];
  List <String> title = [
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notifications.tr(),
    AppStrings.settings.tr()
  ];
   int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title[_currentIndex],
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: ColorManager.lightGrey,spreadRadius: AppSize.s1)
          ]
        ),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primary,
          unselectedItemColor: ColorManager.grey,
          currentIndex: _currentIndex,
          onTap: (int index){
            setState(() {
              _currentIndex=index;
            });
          },
          items:  [
            BottomNavigationBarItem(
                icon: const Icon(Icons.home_outlined),label: AppStrings.home.tr()),
            BottomNavigationBarItem(
                icon: const Icon(Icons.search),label: AppStrings.search.tr()),
            BottomNavigationBarItem(
                icon: const Icon(Icons.notifications),label: AppStrings.notifications.tr()),
            BottomNavigationBarItem(
                icon: const Icon(Icons.settings),label: AppStrings.settings.tr()),
          ],
        ),
      ),

    );
  }
}
