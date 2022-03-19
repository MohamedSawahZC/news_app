import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/layouts/home_screen.dart';
import 'package:new_app/shared/bloc_observer.dart';
import 'package:new_app/shared/cubit/cubit.dart';
import 'package:new_app/shared/cubit/states.dart';
import 'package:new_app/shared/network/local/cashe_helper.dart';
import 'package:new_app/shared/network/remote/dio_helper.dart';
import 'dart:ui' as ui;
import 'package:hexcolor/hexcolor.dart';

// ignore: prefer_const_constructors

void main() async{
  // بيتأكد من انتهاء كل شئ في الميقود ويعمل run للـ App
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    ()  async {
      var isDark= CasheHelper.getData(key: 'isDark');
      DioHelper.init();
      await CasheHelper.init();
      runApp(MyApp(isDark));
    },
    blocObserver: MyBlocObserver(),

  );


}
// ignore: prefer_const_constructors

class MyApp extends StatelessWidget {
  var isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsCubit()
        ..getBusiness()
        ..getScience()
        ..getSports()..changeThemeMode(fromShared: isDark),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {
          // ignore: todo
        },
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.black,
                 ),
              ),
              primarySwatch: Colors.deepOrange,
// ignore: prefer_const_constructors
              appBarTheme: AppBarTheme(
// ignore: prefer_const_constructors
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
// ignore: prefer_const_constructors
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.red,
                  statusBarIconBrightness: Brightness.dark,
                ),
// ignore: prefer_const_constructors
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),

                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
// ignore: prefer_const_constructors
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.deepOrange,
                elevation: 20.0,
                backgroundColor: Colors.white,
              ),
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              textTheme: const TextTheme(
                  bodyText1: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              )),
// ignore: prefer_const_constructors
              appBarTheme: AppBarTheme(
// ignore: prefer_const_constructors
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
// ignore: prefer_const_constructors
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.red,
                  statusBarIconBrightness: Brightness.light,
                ),
// ignore: prefer_const_constructors
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),

                backgroundColor: HexColor('333739'),
                elevation: 20.0,
              ),
// ignore: prefer_const_constructors
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                unselectedItemColor: Colors.grey,
                selectedItemColor: Colors.deepOrange,
                elevation: 20.0,
                backgroundColor: HexColor('333739'),
              ),
              scaffoldBackgroundColor: HexColor('333739'),
            ),
           themeMode: cubit.isDark ? ThemeMode.light : ThemeMode.dark,
           // themeMode: ,
// ignore: prefer_const_constructors
            home: Directionality(
              textDirection: ui.TextDirection.rtl,
              child: const HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}
