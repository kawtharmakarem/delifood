import 'dart:async';

import '/domain/usecases/details_usecase.dart';
import '/presentation/base/base_view_model.dart';
import '/presentation/common/state_renderer/flow_state.dart';

import '../../../domain/models/home_models.dart';

abstract class DetailsViewModelInputs {
  Sink get inputGetDetails;
  void getDetailsById(int id);
}

abstract class DetailsViewMoelOutputs {
  Stream<Recipe> get outputGetDetails;
}

class DetailsViewModel extends BaseViewModel
    implements DetailsViewModelInputs, DetailsViewMoelOutputs {
  final StreamController<Recipe> _detailsController =
      StreamController<Recipe>.broadcast();
  final DetailsUsecase _detailsUsecase;

  DetailsViewModel({required this._detailsUsecase});

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _detailsController.close();
    super.dispose();
  }

  @override
  void getDetailsById(int id) async {
    (await _detailsUsecase.execute(id)).fold(
      (failure) {
        inputState.add(
          ErrorState(
            failure: failure,
            onRetry: () {
              getDetailsById(id);
            },
          ),
        );
      },
      (data) {
        inputState.add(ContentState());
        inputGetDetails.add(data);
      },
    );
  }

  @override
  Sink<dynamic> get inputGetDetails => _detailsController.sink;

  @override
  Stream<Recipe> get outputGetDetails => _detailsController.stream;
}
