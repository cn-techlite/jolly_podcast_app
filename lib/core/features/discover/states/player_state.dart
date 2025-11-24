import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:jolly_podcast/core/components/utils/package_export.dart';
import 'package:jolly_podcast/core/features/discover/model/player_state_model.dart';

class CurrentAudioManager extends AsyncNotifier<AudioPlayer?> {
  @override
  FutureOr<AudioPlayer?> build() => null;

  /// Save this as the currently active player
  void setCurrentPlayer(AudioPlayer player) {
    state = AsyncData(player);
  }

  /// Stop the currently playing audio
  Future<void> stopCurrent() async {
    final p = state.value;
    if (p != null) {
      await p.stop();
    }
    state = const AsyncData(null);
  }
}

final currentAudioManagerProvider =
    AsyncNotifierProvider<CurrentAudioManager, AudioPlayer?>(
      CurrentAudioManager.new,
    );

class PlayerStateController extends AsyncNotifier<PlayerStateModel> {
  PlayerStateController(this.audioUrl);

  final String audioUrl;

  @override
  FutureOr<PlayerStateModel> build() async {
    final audioPlayer = AudioPlayer();

    await audioPlayer.setSourceUrl(audioUrl);
    // release mode required on Android
    await audioPlayer.setReleaseMode(ReleaseMode.stop);

    final model = PlayerStateModel(
      isPlaying: false,
      position: Duration.zero,
      duration: null,
      audioPlayer: audioPlayer,
    );

    state = AsyncData(model);

    // Listen for duration
    audioPlayer.onDurationChanged.listen((d) {
      updateState(duration: d);
    });

    // Listen for position
    audioPlayer.onPositionChanged.listen((pos) {
      updateState(position: pos);
    });

    // Listen for playing status
    audioPlayer.onPlayerStateChanged.listen((event) {
      updateState(isPlaying: event == PlayerState.playing);
    });

    // Dispose correctly when provider goes away
    ref.onDispose(() {
      audioPlayer.dispose();
    });

    return model;
  }

  void updateState({bool? isPlaying, Duration? position, Duration? duration}) {
    final s = state.value!;
    state = AsyncData(
      s.copyWith(
        isPlaying: isPlaying ?? s.isPlaying,
        position: position ?? s.position,
        duration: duration ?? s.duration,
      ),
    );
  }

  /// Ensures only ONE audio plays at a time
  Future<void> playPause() async {
    final player = state.value!.audioPlayer;

    final manager = ref.read(currentAudioManagerProvider.notifier);
    final currentActive = ref.read(currentAudioManagerProvider).value;

    // Stop previous audio if another is active
    if (currentActive != null && currentActive != player) {
      await manager.stopCurrent();
    }

    // Mark this player as the active audio
    manager.setCurrentPlayer(player);

    final isPlaying = state.value!.isPlaying;

    if (isPlaying) {
      await player.pause();
    } else {
      await player.resume();
    }
  }

  Future<void> seek(Duration position) async {
    await state.value!.audioPlayer.seek(position);
  }
}

final playerStateControllerProvider =
    AsyncNotifierProvider.family<
      PlayerStateController,
      PlayerStateModel,
      String
    >(PlayerStateController.new);
