import { Audio } from 'expo-av';

let sound = null;

export const playBackgroundMusic = async () => {
  try {
    if (sound) return;

    const { sound: newSound } = await Audio.Sound.createAsync(
      require('../assets/TiledSlapbackLoop.mp3'),
      {
        shouldPlay: true,
        isLooping: true,
        volume: 0.5,
      }
    );

    sound = newSound;

    await sound.playAsync();
  } catch (error) {
    console.log('Music Error:', error);
  }
};