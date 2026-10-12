import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import '/app/di.dart';
import '/app/functions.dart';
import '/domain/usecases/login_use_case.dart';
import '/domain/usecases/register_usecase.dart';
import '/presentation/base/base_view_model.dart';
import '/presentation/common/freezed/login_Object.dart';
import '/presentation/common/freezed/register_object.dart';
import '/presentation/common/state_renderer/flow_state.dart';
import '/presentation/resources/app_assets.dart';
import '/presentation/resources/app_strings.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/models/auth_models.dart';

class AuthViewModel extends BaseViewModel
    implements AuthViewModelInputs, AuthViewModelOutputs {
  //streamControllers
  final StreamController<String> _logEmailStreamController =
      StreamController<String>.broadcast();
  final StreamController<String> _logPasswordStreamController =
      StreamController<String>.broadcast();
  final StreamController<bool> _logPasswordVisibleStreamController =
      StreamController<bool>.broadcast();
  final StreamController<void> _areAlllLogInputsValidStreamController =
      StreamController<void>.broadcast();
  final StreamController<bool> _isLoadingController =
      StreamController<bool>.broadcast();
  final StreamController isUserLoggedInSuccessfulyStreamController =
      StreamController<bool>();
  bool _isLogPasswordVisible = false;

  final LoginUseCase _loginUseCase;
  final RegisterUsecase _registerUsecase;
  AuthViewModel(this._loginUseCase, this._registerUsecase);
  var loginObject = LoginObject("", "");
  var registerObject = RegisterObject("", "", "", "", "", "");
  bool _isLoading = false;
  //textFeilds
  final TextEditingController logEmailController = TextEditingController();
  final TextEditingController logPasswordController = TextEditingController();

  final TextEditingController regUserNameController = TextEditingController();
  final TextEditingController regMobileNumberController =
      TextEditingController();
  final TextEditingController regEmailController = TextEditingController();
  final TextEditingController regPasswordController = TextEditingController();
  final TextEditingController regProfileController = TextEditingController();
  //register stream controllers
  final StreamController _regUserNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _regMobileNumberStreamController =
      StreamController<String>.broadcast();
  final StreamController _regEmailStreamController =
      StreamController<String>.broadcast();
  final StreamController _regPasswordStreamController =
      StreamController<String>.broadcast();
  final StreamController _regProfilePictureStreamController =
      StreamController<File>.broadcast();
  final StreamController _regAreAllInputsValidStreamController =
      StreamController<void>.broadcast();
  StreamController regIsUserRegisteredSuccessfully = StreamController<bool>();

  //stickers
  final Random _random = Random(42);
  late List<FoodItemData> _items;
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

  //streamControllers
  final StreamController<int> _tabController =
      StreamController<int>.broadcast();

  final StreamController<Sticker> _stickersController =
      StreamController<Sticker>();
  @override
  void dispose() {
    _isLoadingController.close();
    _tabController.close();
    _stickersController.close();
    _logEmailStreamController.close();
    _logPasswordStreamController.close();
    _logPasswordVisibleStreamController.close();
    _areAlllLogInputsValidStreamController.close();
    _regEmailStreamController.close();
    _regPasswordStreamController.close();
    _regProfilePictureStreamController.close();
    regIsUserRegisteredSuccessfully.close();
    _regAreAllInputsValidStreamController.close();
    _regUserNameStreamController.close();
    _regMobileNumberStreamController.close();
  }

  @override
  void start() {
    inputLogPasswordVisibility.add(_isLogPasswordVisible);
    _items = _generateItems();
    inputStickers.add(Sticker(items: _items));
    inputState.add(ContentState());
  }

  @override
  void selectTab(int index) {
    inputSelectedTab.add(index);
  }

  @override
  Sink<int> get inputSelectedTab => _tabController.sink;

  @override
  Stream<int> get outputSelectedTab => _tabController.stream;

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
  Sink<Sticker> get inputStickers => _stickersController.sink;

  @override
  Stream<Sticker> get outputStickers => _stickersController.stream;

  @override
  Sink<String> get inputLogEmail => _logEmailStreamController.sink;

  @override
  Sink<String> get inputLogPassword => _logPasswordStreamController.sink;

  @override
  login() async {
    if (_isLoading) return;
    _isLoading = true;
    _isLoadingController.add(true);
    inputState.add(LoadingState());
    (await _loginUseCase.execute(
      LoginUseCaseInput(loginObject.email, loginObject.password),
    )).fold(
      (failure) {
        _isLoading = false;
        _isLoadingController.add(false);
        inputState.add(ErrorState(failure: failure, onRetry: login));
      },
      (data) {
        _isLoading = false;
        _isLoadingController.add(false);
        inputState.add(ContentState());
        //inputState.add(SuccessState(message: "Welcome ${data.customer?.name}"));
        isUserLoggedInSuccessfulyStreamController.add(true);
      },
    );
  }

  @override
  void setLogEmail(String email) {
    inputLogEmail.add(email);
    loginObject = loginObject.copyWith(email: email);
    inputAreAllLogInputsValid.add(null);
  }

  @override
  void setLogPassword(String password) {
    inputLogPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllLogInputsValid.add(null);
  }

  @override
  Stream<bool> get outputIsLogEmailValid =>
      _logEmailStreamController.stream.map((email) => _isLogEmailValid(email));

  @override
  Stream<bool> get outputIsLogPasswordValid => _logPasswordStreamController
      .stream
      .map((password) => _isLogPasswordValid(password));
  //functions
  bool _isLogEmailValid(String email) {
    return email.isNotEmpty;
  }

  bool _isLogPasswordValid(String password) {
    return password.isNotEmpty;
  }

  @override
  Sink<bool> get inputLogPasswordVisibility =>
      _logPasswordVisibleStreamController.sink;

  @override
  Stream<bool> get outputLogPasswordVisibility =>
      _logPasswordVisibleStreamController.stream;

  @override
  void toggleLogPasswordVisibility() {
    _isLogPasswordVisible = !_isLogPasswordVisible;
    inputLogPasswordVisibility.add(_isLogPasswordVisible);
  }

  @override
  Sink<void> get inputAreAllLogInputsValid =>
      _areAlllLogInputsValidStreamController.sink;

  @override
  Stream<bool> get outputAreAllLogInputsValid =>
      _areAlllLogInputsValidStreamController.stream.map(
        (_) => _areAllLogInputsValid(),
      );

  bool _areAllLogInputsValid() {
    return _isLogEmailValid(loginObject.email) &&
        _isLogPasswordValid(loginObject.password);
  }

  @override
  Stream<bool> get outputIsLoading => _isLoadingController.stream;

  @override
  Sink<dynamic> get inputRegEmail => _regEmailStreamController.sink;

  @override
  Sink<dynamic> get inputRegIsAllInputsValid =>
      _regAreAllInputsValidStreamController.sink;

  @override
  Sink<dynamic> get inputRegMobileNumber =>
      _regMobileNumberStreamController.sink;

  @override
  Sink<dynamic> get inputRegPassword => _regPasswordStreamController.sink;

  @override
  Sink<dynamic> get inputRegProfilePicture =>
      _regProfilePictureStreamController.sink;

  @override
  Sink<dynamic> get inputRegUserName => _regUserNameStreamController.sink;

  @override
  Stream<bool> get outputRegIsEmailValid =>
      _regEmailStreamController.stream.map((email) => isEmailValid(email));
  @override
  Stream<String?> get outputRegErrorEmail => outputRegIsEmailValid.map(
    (isEmail) => isEmail ? null : AppStrings.emailInvalid,
  );

  @override
  Stream<bool> get outputRegIsMobileNumberValid =>
      _regMobileNumberStreamController.stream.map(
        (mobileNumber) => _regIsMobileNumberValid(mobileNumber),
      );
  @override
  Stream<String?> get outputRegErrorMobileNumber =>
      outputRegIsMobileNumberValid.map(
        (isMobileNumber) =>
            isMobileNumber ? null : AppStrings.mobileNumberInvalid,
      );

  @override
  Stream<bool> get outputRegIsPasswordValid => _regPasswordStreamController
      .stream
      .map((password) => _regIsPasswordValid(password));
  @override
  Stream<String?> get outputRegErrorPassword => outputRegIsPasswordValid.map(
    (isPassword) => (isPassword) ? null : AppStrings.passwordInvalid,
  );

  @override
  Stream<bool> get outputRegIsUserNameValid => _regUserNameStreamController
      .stream
      .map((userName) => _regIsUserNameValid(userName));
  @override
  Stream<String?> get outputRegErrorUserName => outputRegIsUserNameValid.map(
    (isUserNameValid) => (isUserNameValid) ? null : AppStrings.userNameInvalid,
  );

  @override
  Stream<File> get outputRegProfilePicture =>
      _regProfilePictureStreamController.stream.map((file) => file);

  @override
  Stream<bool> get outputRegIsAllInputsValid =>
      _regAreAllInputsValidStreamController.stream.map(
        (_) => _regAreAllInputsValid(),
      );

  @override
  void register() async {
    inputState.add(LoadingState());
    (await _registerUsecase.execute(
      RegisterUsecaseInputs(
        userName: registerObject.userName,
        countryMobileCode: registerObject.countryMobileCode,
        mobileNumber: registerObject.mobileNumber,
        email: registerObject.email,
        password: registerObject.password,
        profilePicture: registerObject.profilePicture,
      ),
    )).fold(
      (failure) {
        inputState.add(ErrorState(failure: failure, onRetry: () {}));
      },
      (data) {
        inputState.add(
          SuccessState(
            message: "Registered Successfully ${data.customer!.name}",
          ),
        );
        regIsUserRegisteredSuccessfully.add(true);
      },
    );
  }

  @override
  void setRegEmail(String email) {
    inputRegEmail.add(email);
    if (isEmailValid(email)) {
      registerObject = registerObject.copyWith(email: email);
    } else {
      registerObject = registerObject.copyWith(email: "");
    }
    _validate();
  }

  @override
  void setRegMobileNumber(String mobileNumber) {
    inputRegMobileNumber.add(mobileNumber);
    if (_regIsMobileNumberValid(mobileNumber)) {
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    _validate();
  }

  @override
  void setRegPassword(String password) {
    inputRegPassword.add(password);
    if (_regIsPasswordValid(password)) {
      registerObject = registerObject.copyWith(password: password);
    } else {
      registerObject = registerObject.copyWith(password: "");
    }
    _validate();
  }

  @override
  void setRegProfilePicture(File profilePicture) {
    inputRegProfilePicture.add(profilePicture);
    if (profilePicture.path.isNotEmpty) {
      registerObject = registerObject.copyWith(
        profilePicture: profilePicture.path,
      );
    } else {
      registerObject = registerObject.copyWith(profilePicture: "");
    }
    _validate();
  }

  Future<void> pickImage() async {
    final XFile? image = await instance<ImagePicker>().pickImage(
      source: ImageSource.gallery,
    );
    if (image == null) return;
    final file = File(image.path);
    regProfileController.text = image.name;
    setRegProfilePicture(file);
  }

  @override
  void setRegUserName(String userName) {
    inputRegUserName.add(userName);
    if (_regIsUserNameValid(userName)) {
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      registerObject = registerObject.copyWith(userName: "");
    }
    _validate();
  }

  bool _regIsUserNameValid(String userName) {
    return userName.length > 6;
  }

  bool _regIsPasswordValid(String password) {
    return password.length > 5;
  }

  bool _regIsMobileNumberValid(String mobileNumber) {
    return mobileNumber.length > 9;
  }

  bool _regAreAllInputsValid() {
    return registerObject.userName.isNotEmpty &&
        registerObject.countryMobileCode.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty &&
        registerObject.profilePicture.isNotEmpty;
  }

  void _validate() {
    inputRegIsAllInputsValid.add(null);
  }

  @override
  void setCountryCode(String countryCode) {
    if (countryCode.isNotEmpty) {
      registerObject = registerObject.copyWith(countryMobileCode: countryCode);
    } else {
      registerObject = registerObject.copyWith(countryMobileCode: "");
    }
    _validate();
  }
}

abstract class AuthViewModelInputs {
  void selectTab(int index);
  Sink<int> get inputSelectedTab;
  Sink<Sticker> get inputStickers;
  void setLogEmail(String email);
  void setLogPassword(String password);
  login();
  void toggleLogPasswordVisibility();
  Sink<String> get inputLogEmail;
  Sink<String> get inputLogPassword;
  Sink<bool> get inputLogPasswordVisibility;
  Sink<void> get inputAreAllLogInputsValid;
  //register
  Sink get inputRegUserName;
  Sink get inputRegMobileNumber;
  Sink get inputRegEmail;
  Sink get inputRegPassword;
  Sink get inputRegProfilePicture;
  Sink get inputRegIsAllInputsValid;
  void register();
  void setRegUserName(String userName);
  void setCountryCode(String countryCode);
  void setRegMobileNumber(String mobileNumber);
  void setRegEmail(String email);
  void setRegPassword(String password);
  void setRegProfilePicture(File profilePicture);
}

abstract class AuthViewModelOutputs {
  Stream<int> get outputSelectedTab;
  Stream<Sticker> get outputStickers;
  Stream<bool> get outputIsLogEmailValid;
  Stream<bool> get outputIsLogPasswordValid;
  Stream<bool> get outputLogPasswordVisibility;
  Stream<bool> get outputAreAllLogInputsValid;
  Stream<bool> get outputIsLoading;
  //register
  Stream<bool> get outputRegIsUserNameValid;
  Stream<String?> get outputRegErrorUserName;

  Stream<bool> get outputRegIsMobileNumberValid;
  Stream<String?> get outputRegErrorMobileNumber;

  Stream<bool> get outputRegIsEmailValid;
  Stream<String?> get outputRegErrorEmail;

  Stream<bool> get outputRegIsPasswordValid;
  Stream<String?> get outputRegErrorPassword;

  Stream<File> get outputRegProfilePicture;
  Stream<bool> get outputRegIsAllInputsValid;
}
