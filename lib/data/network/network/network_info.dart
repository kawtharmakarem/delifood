import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetWorkInfo {
  Future<bool> get hasConnection;
  Stream<bool> get onStatusChange;
}

class NetworkInfoImpl implements NetWorkInfo {
  final Connectivity _connectivity;
  NetworkInfoImpl(this._connectivity);
  @override
  Future<bool> get hasConnection async {
    final result = await _connectivity.checkConnectivity();
    return (!result.contains(ConnectivityResult.none));
  }

  @override
  Stream<bool> get onStatusChange =>
      _connectivity.onConnectivityChanged.map((result) {
        return !result.contains(ConnectivityResult.none);
      });
}
