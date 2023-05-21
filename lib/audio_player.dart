import 'package:audioplayers/audioplayers.dart';

class AudioPlayerHelper {
  AudioCache audioCache = AudioCache();

  Future<void> preloadAudio() async {
    await audioCache.load('media/button.wav');
  }

  //button sound
  void playAudio() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource('media/button.wav'));
  }

  // dice sound
  void playAudioDice() async {
    AudioPlayer audioPlayer = AudioPlayer();
    await audioPlayer.play(AssetSource('media/dice.mp3'));
  }
}
