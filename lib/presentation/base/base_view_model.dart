import 'dart:async';

import '/presentation/common/state_renderer/flow_state.dart';

import 'package:rxdart/rxdart.dart';

abstract class BaseViewModel
    implements BaseViewModelInputs, BaseViewModelOutputs {
  final StreamController<FlowState> _controller = BehaviorSubject<FlowState>();

  @override
  void dispose() {
    _controller.close();
  }

  @override
  Sink<FlowState> get inputState => _controller.sink;

  @override
  Stream<FlowState> get outputState => _controller.stream;
}

abstract class BaseViewModelInputs {
  void start();
  void dispose();
  Sink<FlowState> get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
