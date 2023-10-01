abstract class NewsStates{}

class NewsInitialState extends NewsStates{}

class NewsBottomNavState extends NewsStates{}

class NewsGetBusinessLodingState extends NewsStates{}
class NewsGetbusinessSuccessState extends NewsStates{}
class NewsGetbusinessErrorState extends NewsStates{
  final String? error;

  NewsGetbusinessErrorState(this.error);

}

class NewsGetSportLodingState extends NewsStates{}
class NewsGetSportSuccessState extends NewsStates{}
class NewsGetSportErrorState extends NewsStates{
  final String? error;

  NewsGetSportErrorState(this.error);

}

class NewsGetSciencesLodingState extends NewsStates{}
class NewsGetSciencesSuccessState extends NewsStates{}
class NewsGetSciencesErrorState extends NewsStates{
  final String? error;

  NewsGetSciencesErrorState(this.error);

}

class NewsGetSearchLodingState extends NewsStates{}
class NewsGetSearchSuccessState extends NewsStates{}
class NewsGetSearchErrorState extends NewsStates{
  final String? error;

  NewsGetSearchErrorState(this.error);

}



