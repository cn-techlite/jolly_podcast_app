import 'dart:async';
import 'package:jolly_podcast/core/components/utils/package_export.dart';

/// --- Enum
enum ConnectivityStatus { notDetermined, isConnected, isDisconnected }

class ConnectivityUtility {
  static bool isOnline(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
      case ConnectivityResult.vpn:
      case ConnectivityResult.other:
        return true;
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.none:
        return false;
    }
  }
}

class ConnectivityNotifier extends AsyncNotifier<ConnectivityStatus> {
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  @override
  FutureOr<ConnectivityStatus> build() async {
    // Initial state
    final initialList = await Connectivity().checkConnectivity();
    final initialStatus = initialList.contains(ConnectivityResult.none)
        ? ConnectivityStatus.isDisconnected
        : ConnectivityStatus.isConnected;

    // Listen to connectivity changes
    _subscription = Connectivity().onConnectivityChanged.listen((results) {
      final online = results.any((r) => ConnectivityUtility.isOnline(r));

      if (!ref.mounted) return;

      final newState = online
          ? ConnectivityStatus.isConnected
          : ConnectivityStatus.isDisconnected;

      // Only update if changed
      if (state.value != newState) {
        state = AsyncData(newState);
      }
    });

    // Ensure cleanup
    ref.onDispose(() {
      _subscription?.cancel();
      _subscription = null;
    });

    return initialStatus;
  }

  Future<void> refreshNow() async {
    final results = await Connectivity().checkConnectivity();
    final online = results.contains(ConnectivityResult.none) == false;

    if (!ref.mounted) return;

    state = AsyncData(
      online
          ? ConnectivityStatus.isConnected
          : ConnectivityStatus.isDisconnected,
    );
  }
}

final connectivityStatusProviders =
    AsyncNotifierProvider<ConnectivityNotifier, ConnectivityStatus>(
      ConnectivityNotifier.new,
    );
