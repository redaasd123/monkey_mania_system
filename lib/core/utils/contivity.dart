import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();
  bool _isSyncing = false;

  void startMonitoring(Future<void> Function() onConnected) {
    _connectivity.onConnectivityChanged.listen((result) async {
      if (result != ConnectivityResult.none && !_isSyncing) {
        _isSyncing = true;
        await onConnected();
        _isSyncing = false;
      }
    });
  }
}
