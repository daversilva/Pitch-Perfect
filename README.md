# Pitch-Perfect
### iOS Developer Nano Degree Project

The Pitch Perfect app is result of Udacity's iOS Developer Nanodegree course.

The App allows users to Record a sound using the Device’s Microphone. It then Allows Users to Play the Recorded Sound back with six different Sound Modulations.

Basic features Based on the criteria found in here: 
- [PROJECT SPECIFICATION - Pitch Perfect](https://review.udacity.com/#!/rubrics/19/view)

## Implementation
Pitch Perfect has two Scenes: 
- **RecordSoundsViewController** : consists a record button with a microphone image. Tapping this microphone button starts an audio recording session and present a stop button. When the stop button is clicked, the app completes recording and then show the PlaySound controller.
- **PlaySoundsViewController** : contains six buttons to play the recorded sound file with different effects related to the button image and a stop button at the bottom

*The App supports both orientations. I have varied traits for the landscape orientation of PlaySoundsViewController to make it look good with the use of stack views.*

The application uses code from `AVFoundation` to record sounds from the microphone `(AVAudioRecorder)` and play recorded audio with effects `(AVAudioPlayer, AVAudioEngine)`.

## Sound modulations
- Super Slow
- Super Fast
- Chipmunk
- Darth Vader
- Parrot (Echo effect)
- Reverb

## Requirements
- Xcode 9
- Swift 4
