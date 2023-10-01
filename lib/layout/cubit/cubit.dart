import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/layout/cubit/states.dart';
import 'package:newsapp/modules/business/business_screen.dart';
import 'package:newsapp/modules/science/science_screen.dart';
import 'package:newsapp/modules/sportes/sport_screen.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business_outlined,
      ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Sciences',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
  ];

  void changeBottomNavItem(int index) {
    currentIndex = index;
    if (index == 1) getSport();
    if (index == 2) getScience();
    emit(NewsBottomNavState());
  }

  List<dynamic> business = [];
  List<dynamic> sport = [];
  List<dynamic> sciences = [];

  void getBusnies() {
    emit(NewsGetBusinessLodingState());
    if (business.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        //business
        query: {
          'country': 'eg',
          'category': 'business',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        },
      ).then((value) {
        business = value.data['articles'];
        emit(NewsGetbusinessSuccessState());
      }).catchError((error) {
        emit(NewsGetbusinessErrorState(error.toString()));
        if (kDebugMode) {
          print(error.toString());
        }
      });
    } else {
      emit(NewsGetbusinessSuccessState());
    }
  }

  void getSport() {
    emit(NewsGetSportLodingState());
    if (sport.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        },
      ).then((value) {
        sport = value.data['articles'];
        emit(NewsGetSportSuccessState());
      }).catchError((error) {
        emit(NewsGetSportErrorState(error.toString()));
        if (kDebugMode) {
          print(error.toString());
        }
      });
    } else {
      emit(NewsGetSportSuccessState());
    }
  }

  void getScience() {
    emit(NewsGetSciencesLodingState());
    if (sciences.isEmpty) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
        },
      ).then((value) {
        sciences = value.data['articles'];
        emit(NewsGetSciencesSuccessState());
      }).catchError((error) {
        emit(NewsGetSciencesErrorState(error.toString()));
        if (kDebugMode) {
          print(error.toString());
        }
      });
    } else {
      emit(NewsGetSciencesSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch({String? value}) {
    emit(NewsGetSearchLodingState());

    //search = [];

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',

        'apiKey': '65f7f556ec76449fa7dc7c0069f040ca',
      },
    ).then((value) {
      search = value.data['articles'];
      if (kDebugMode) {
        print(search[0]['title']);
      }
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(error.toString());
      }
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
