import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';

import '/app/functions.dart';
import '/domain/usecases/forgotpassword_usecase.dart';
import '/presentation/base/base_view_model.dart';
import '/presentation/common/state_renderer/flow_state.dart';

import '../../../domain/models/auth_models.dart';
import '../../resources/app_assets.dart';

abstract class ForgotpasswordInputs {
  void setEmail(String email);
  void forgotpassword();
  Sink get inputEmail;
  Sink get inputIsAllInputsValid;
}

abstract class ForgotpasswordOutputs {
  Stream<bool> get outputIsEmailValid;
  Stream<bool> get outputIsAllInputsValid;
}

class ForgotpasswordViewmodel extends BaseViewModel
    implements ForgotpasswordInputs, ForgotpasswordOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();
  final StreamController _isAllInputsValidStreamController =
      StreamController<void>.broadcast();
  final ForgotpasswordUsecase _forgotpasswordUsecase;
  ForgotpasswordViewmodel(this._forgotpasswordUsecase);
  var email = "";
  TextEditingController emailController = TextEditingController();

  //stickers
  final Random _random = Random(42);
  late List<FoodItemData> items;
  final List<String> _images = [
    AppAssets.banana,
    AppAssets.bread,
    AppAssets.broccoli,
    AppAssets.burger,
    AppAssets.chili,
    AppAssets.cupCake,
    AppAssets.ginger,
    AppAssets.leaf,
    AppAssets.onion,
    AppAssets.potato,
  ];

  @override
  void start() {
    items = _generateItems();
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _isAllInputsValidStreamController.close();
  }

  //functions
  List<FoodItemData> _generateItems() {
    return _images.map((image) {
      return FoodItemData(
        image: image,
        x: 0.05 + _random.nextDouble() * 0.8,
        y: 0.05 + _random.nextDouble() * 0.8,
        rotation: (_random.nextDouble() - 0.5) * 0.9,
        size: 45,
      );
    }).toList();
  }

  @override
  void forgotpassword() async {
    inputState.add(LoadingState());
    (await _forgotpasswordUsecase.execute(email)).fold(
      (failure) {
        inputState.add(
          ErrorState(
            failure: failure,
            onRetry: () {
              forgotpassword();
            },
          ),
        );
      },
      (supportMessage) {
        inputState.add(SuccessState(message: supportMessage));
      },
    );
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;
  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Sink<dynamic> get inputIsAllInputsValid =>
      _isAllInputsValidStreamController.sink;

  @override
  Stream<bool> get outputIsAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  @override
  void setEmail(String email) {
    inputEmail.add(email);
    this.email = email;
    inputIsAllInputsValid.add(null);
  }

  bool _isAllInputsValid() {
    return isEmailValid(email);
  }
}
