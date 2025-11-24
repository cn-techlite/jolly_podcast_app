import 'package:audioplayers/audioplayers.dart';

class PlayerStateModel {
  final bool isPlaying;
  final Duration position;
  final Duration? duration;
  final AudioPlayer audioPlayer;

  PlayerStateModel({
    required this.isPlaying,
    required this.position,
    required this.duration,
    required this.audioPlayer,
  });

  PlayerStateModel copyWith({
    bool? isPlaying,
    Duration? position,
    Duration? duration,
    AudioPlayer? audioPlayer,
  }) {
    return PlayerStateModel(
      isPlaying: isPlaying ?? this.isPlaying,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      audioPlayer: audioPlayer ?? this.audioPlayer,
    );
  }
}
