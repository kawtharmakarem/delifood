import 'dart:async';

import '/domain/models/home_models.dart';
import '/domain/usecases/home_usecase.dart';
import '/presentation/base/base_view_model.dart';
import '/presentation/common/state_renderer/flow_state.dart';
import '/presentation/common/state_renderer/presentation_style.dart';

import 'package:rxdart/rxdart.dart';

abstract class MainViewModelInputs {
  void changeNavIndex(int index);
  Sink get inputHomeData;
  void getHomeData();
}

abstract class MainViewModelOutputs {
  Stream<int> get outputSelectedNavIndexStream;
  Stream<RecipesModel> get outputHomeData;
}

class MainViewModel extends BaseViewModel
    implements MainViewModelInputs, MainViewModelOutputs {
  final BehaviorSubject<int> _selectedNavIndexSubject =
      BehaviorSubject<int>.seeded(0);
  int get currentPage => _selectedNavIndexSubject.value;

  final BehaviorSubject<RecipesModel> _dataStreamController =
      BehaviorSubject<RecipesModel>();

  final MainUsecase _mainUsecase;
  MainViewModel(this._mainUsecase);

  @override
  void start() {
    getHomeData();
  }

  @override
  void dispose() {
    super.dispose();
    _selectedNavIndexSubject.close();
    _dataStreamController.close();
  }

  @override
  Stream<int> get outputSelectedNavIndexStream =>
      _selectedNavIndexSubject.stream;

  @override
  void changeNavIndex(int index) {
    if (currentPage == index) return;
    _selectedNavIndexSubject.sink.add(index);
  }

  @override
  Sink<dynamic> get inputHomeData => _dataStreamController.sink;

  @override
  Stream<RecipesModel> get outputHomeData => _dataStreamController.stream;

  @override
  void getHomeData() async {
    inputState.add(LoadingState(style: PresentationStyle.fullScreen));
    (await _mainUsecase.execute(null)).fold(
      (failure) {
        inputState.add(
          ErrorState(
            failure: failure,
            onRetry: () {
              //todo later
            },
            style: PresentationStyle.fullScreen,
          ),
        );
      },
      (data) {
        inputState.add(ContentState());
        inputHomeData.add(data);
      },
    );
  }
}
