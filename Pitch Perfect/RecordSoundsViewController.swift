//
//  ViewController.swift
//  Pitch Perfect
//
//  Created by David Rodrigues on 28/06/2018.
//  Copyright © 2018 David Rodrigues. All rights reserved.
//

import UIKit
import AVFoundation
import RxSwift
import RxCocoa

class RecordSoundsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var btnStarRecording: UIButton!
    @IBOutlet weak var btnStopRecording: UIButton!
    
    // MARK: Variables
    var audioRecorder: AVAudioRecorder!
    let disposeBag = DisposeBag()
    var isRecordingEvent = BehaviorRelay<Bool>(value: false)
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViews()
    }

}

extension RecordSoundsViewController {
    
    // MARK: Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }

}

extension RecordSoundsViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("Recording was not successful")
        }
    }
}


// MARK: - Setups
extension RecordSoundsViewController {
    
    private func bindViews() {
        
        isRecordingEvent.accept(true)
        
        btnStarRecording.rx.tap.bind { [weak self] in
            self?.isRecordingEvent.accept(false)
            
            let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
            let recordingName = "recordedVoice.wav"
            let pathArray = [dirPath, recordingName]
            let filePath = URL(string: pathArray.joined(separator: "/"))
            
            let session = AVAudioSession.sharedInstance()
            try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
            
            try! self?.audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
            self?.audioRecorder.delegate = self
            self?.audioRecorder.isMeteringEnabled = true
            self?.audioRecorder.prepareToRecord()
            self?.audioRecorder.record()
        }.disposed(by: disposeBag)
        
        btnStopRecording.rx.tap.bind { [weak self] in
            self?.isRecordingEvent.accept(true)
            self?.audioRecorder.stop()
            let audioSession = AVAudioSession.sharedInstance()
            try! audioSession.setActive(false)
        }.disposed(by: disposeBag)
        
        isRecordingEvent.bind { [weak self] isRecording in
            self?.recordingLabel.text = isRecording ? "Tap to Record" : "Recoding in progress"
            self?.btnStarRecording.isEnabled = isRecording
            self?.btnStopRecording.isEnabled = !isRecording
        }.disposed(by: disposeBag)
    }
    
}
