// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/modules/business/business_screen.dart';
import 'package:new_app/modules/science/science_screen.dart';
import 'package:new_app/modules/search/search_screen.dart';
import 'package:new_app/modules/sports/sports_screen.dart';
import 'package:new_app/shared/cubit/states.dart';

import '../network/local/cashe_helper.dart';
import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: "Science",
    ),

    /* BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: "Settings",
    ),*/
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  List<dynamic> search = [];

  bool isDark = false;

  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    if (business.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'business',
          'apiKey': '32e32876f22b40bfa5cf065e18135eaa',
        },
      )
          .then((value) => {
                business = value.data['articles'],
                print(business[0]['titles']),
                emit(NewsGetBusinessSucessState()),
              })
          .catchError((error) => {
                print(error.toString()),
                print(NewsGetBusinessErrorState(error.toString()))
              });
    } else {
      emit(NewsGetBusinessSucessState());
    }
  }

  void getSports() {
    emit(NewsGetSportsLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '32e32876f22b40bfa5cf065e18135eaa',
        },
      )
          .then((value) => {
                sports = value.data['articles'],
                emit(NewsGetSportsSucessState()),
              })
          .catchError((error) => {
                print(error.toString()),
                print(NewsGetSportsErrorState(error.toString()))
              });
    } else {
      emit(NewsGetSportsSucessState());
    }
  }

  void getScience() {
    emit(NewsGetScienceLoadingState());
    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '32e32876f22b40bfa5cf065e18135eaa',
        },
      )
          .then((value) => {
                science = value.data['articles'],
                emit(NewsGetScienceSucessState()),
              })
          .catchError((error) => {
                print(error.toString()),
                print(NewsGetScienceErrorState(error.toString()))
              });
    } else {
      emit(NewsGetScienceSucessState());
    }
  }

  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());
    search = [];
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '32e32876f22b40bfa5cf065e18135eaa',
      },
    )
        .then((value) => {
      search = value.data['articles'],
      emit(NewsGetSearchSucessState()),
    })
        .catchError((error) => {
      emit(NewsGetSearchErrorState(error)),

    });
  }

  void changeThemeMode({bool? fromShared})
  {
    if(fromShared !=null){
      isDark = fromShared;
      emit(ChangeThemeState());
    }
    else{
      isDark = !isDark;
      CasheHelper.putData(value: isDark, key: 'isDark').then((value) => {
        emit(ChangeThemeState()),
      });
    }

  }
}
