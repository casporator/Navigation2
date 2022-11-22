//
//  VideoPlayerViewController.swift
//  Navigation
//
//  Created by Oleg Popov on 21.11.2022.
//

import Foundation
import UIKit
import AVFoundation

final class VideoPlayerController: UIViewController {
    
    private var player = AVAudioPlayer()
    public var position: Int = 0
    private var timer: Timer?
    public var tracklist = VideoModel.videoList
   
    private let videoName: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 25, weight: .bold)
        lable.textColor = .white
        lable.textAlignment = .center
        lable.toAutoLayout()
        return lable
    }()
    
    private let videoImg: UIImageView = {
        let img = UIImageView()
        img.layer.borderWidth = 2
        img.layer.backgroundColor = UIColor.white.cgColor
        img.layer.cornerRadius = 8
        img.contentMode = .scaleToFill
        img.clipsToBounds = true
        img.toAutoLayout()
        return img
    }()
    
    private let soundView: UIView = {
        let view = UIView()
        view.alpha = 20
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(hexString: "#333333")
        view.toAutoLayout()
        return view
    }()
    
    private let timeView: UIView = {
        let view = UIView()
        view.alpha = 20
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(hexString: "#333333")
        view.toAutoLayout()
        return view
    }()
    
    private let soundTitle: UILabel = {
        let lable = UILabel()
        lable.text = "Volume"
        lable.font = .systemFont(ofSize: 12, weight: .bold)
        lable.textColor = .white
        lable.textAlignment = .center
        lable.toAutoLayout()
        return lable
    }()
    
    private let minTitle: UILabel = {
        let lable = UILabel()
        lable.text = "Min."
        lable.font = .systemFont(ofSize: 10, weight: .bold)
        lable.textColor = .white
        lable.textAlignment = .center
        lable.toAutoLayout()
        return lable
    }()
    
    private let maxTitle: UILabel = {
        let lable = UILabel()
        lable.text = "Max."
        lable.font = .systemFont(ofSize: 10, weight: .bold)
        lable.textColor = .white
        lable.textAlignment = .center
        lable.toAutoLayout()
        return lable
    }()
    
    
    private lazy var playAndPauseButton = PlayerButton(image: "play")
    private lazy var stopButton = PlayerButton(image: "stop")
    private lazy var nextSongButton = PlayerButton(image: "forward")
    private lazy var backwordSongButton = PlayerButton(image: "backward")
    
    private let minSound = PlayerButton(image: "speaker.wave.1")
    private let maxSound = PlayerButton(image: "speaker.wave.3")
    
    private lazy var buttonsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 25.0
        stackView.toAutoLayout()
        return stackView
    }()
    
    private let timeSlider: UISlider = {
       let slider = UISlider()
        slider.tintColor = .white
        slider.maximumTrackTintColor = .lightGray
        slider.minimumTrackTintColor = .white
        slider.thumbTintColor = .white
        slider.minimumValue = 0.0
        slider.toAutoLayout()
        
        return slider
    }()
    
    private let volumeSlider: UISlider = {
       let slider = UISlider()
        slider.tintColor = .white
        slider.maximumTrackTintColor = .lightGray
        slider.minimumTrackTintColor = .white
        slider.thumbTintColor = .white
        slider.minimumValue = 0.0
        slider.maximumValue = 1
        slider.value = 0.5
        slider.toAutoLayout()
    
        return slider
    }()
    
    private let elapsedTimeValueLable: UILabel = {
       let lable = UILabel()
        lable.text = "0:00"
        lable.font = .systemFont(ofSize: 17, weight: .light)
        lable.textColor = .white
        lable.textAlignment = .center
        lable.toAutoLayout()
        return lable
    }()
    
    private let  remainingTimeValueLable: UILabel = {
       let lable = UILabel()
        lable.text = "2:13"
        lable.font = .systemFont(ofSize: 17, weight: .light)
        lable.textColor = .white
        lable.textAlignment = .center
        lable.toAutoLayout()
        return lable
    }()
    
    private lazy var soundStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10.0
        stackView.toAutoLayout()
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        view.addSubviews(videoImg, timeView, soundView, videoName, soundTitle, minTitle, maxTitle, timeSlider, buttonsStack, elapsedTimeValueLable, remainingTimeValueLable, soundStack)
        
        buttonsStack.addArrangedSubview(backwordSongButton)
        buttonsStack.addArrangedSubview(playAndPauseButton)
        buttonsStack.addArrangedSubview(stopButton)
        buttonsStack.addArrangedSubview(nextSongButton)
        
        soundStack.addArrangedSubview(minSound)
        soundStack.addArrangedSubview(volumeSlider)
        soundStack.addArrangedSubview(maxSound)
        
        addConstraints()
        setUpPlayer()
        
        addButtunAction()
        volumeSlider.addTarget(self, action: #selector(changeVolume), for: .valueChanged)
        timeSlider.addTarget(self, action: #selector(changeTime), for: .valueChanged)
        changeTime(sender: timeSlider)
        changeVolume()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        player.stop()
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            
            
            videoImg.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            videoImg.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            videoImg.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            videoImg.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            videoImg.heightAnchor.constraint(equalToConstant: 270),
            
            
            //time:
            
            timeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeView.topAnchor.constraint(equalTo: videoImg.bottomAnchor, constant: 20),
            timeView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            timeView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            timeView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
           
            timeSlider.topAnchor.constraint(equalTo: timeView.topAnchor, constant: 55),
            timeSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeSlider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -35),
            timeSlider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 35),
            timeSlider.heightAnchor.constraint(equalToConstant: 1.5),
            
            elapsedTimeValueLable.bottomAnchor.constraint(equalTo: timeSlider.topAnchor, constant: -25),
            elapsedTimeValueLable.leftAnchor.constraint(equalTo: view.leftAnchor, constant:  15),
            
            remainingTimeValueLable.bottomAnchor.constraint(equalTo: timeSlider.topAnchor, constant: -25),
            remainingTimeValueLable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            videoName.topAnchor.constraint(equalTo: timeSlider.bottomAnchor, constant: 35),
            videoName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //buttons
            
            buttonsStack.bottomAnchor.constraint(equalTo: soundView.topAnchor, constant: -25),
            buttonsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStack.heightAnchor.constraint(equalToConstant: 50),
            
            backwordSongButton.widthAnchor.constraint(equalToConstant: 25),
            backwordSongButton.heightAnchor.constraint(equalToConstant: 25),
            
            playAndPauseButton.widthAnchor.constraint(equalToConstant: 50),
            playAndPauseButton.heightAnchor.constraint(equalToConstant: 50),

            stopButton.widthAnchor.constraint(equalToConstant: 50),
            stopButton.heightAnchor.constraint(equalToConstant: 50),

            backwordSongButton.widthAnchor.constraint(equalToConstant: 25),
            nextSongButton.widthAnchor.constraint(equalToConstant: 25),
            
            //sound:
            
            soundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            soundView.bottomAnchor.constraint(equalTo: timeView.bottomAnchor, constant: -20),
            soundView.heightAnchor.constraint(equalToConstant: 80),
            soundView.leftAnchor.constraint(equalTo: timeView.leftAnchor, constant: 5),
            soundView.rightAnchor.constraint(equalTo: timeView.rightAnchor, constant: -5),
            
            soundTitle.topAnchor.constraint(equalTo: soundView.topAnchor, constant: 5),
            soundTitle.leftAnchor.constraint(equalTo: soundView.leftAnchor, constant: 10),
            
            soundStack.topAnchor.constraint(equalTo: soundView.topAnchor, constant: 25),
            soundStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            soundStack.leftAnchor.constraint(equalTo: soundView.leftAnchor, constant: 5),
            soundStack.rightAnchor.constraint(equalTo: soundView.rightAnchor, constant: -5),
            
            minTitle.topAnchor.constraint(equalTo: soundStack.bottomAnchor),
            minTitle.leftAnchor.constraint(equalTo: soundStack.leftAnchor, constant: 2),
            
            maxTitle.topAnchor.constraint(equalTo: soundStack.bottomAnchor),
            maxTitle.rightAnchor.constraint(equalTo: soundStack.rightAnchor, constant: -2),
            
          
            
        ])
    }
    
    
    private func setUpPlayer() {
        
        let video = VideoModel.videoList[position]
        
        videoImg.image = video.image
        videoName.text = video.title
 
        
        guard let path = Bundle.main.path(forResource: video.fileName, ofType: "MP4") else {
            return
            
        }
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 0.0001, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
        }
     
        do {
            let url = URL(fileURLWithPath: path)
            player = try AVAudioPlayer(contentsOf: url)
                player.volume = 0.5
                timeSlider.maximumValue = Float(player.duration)
                player.prepareToPlay()

         
            } catch let error {
                print(error.localizedDescription)
            }
    }
            
    func addButtunAction() {
        
        playAndPauseButton.buttonAction = { [self] in
            if player.isPlaying {
                playAndPauseButton.setImage(UIImage(systemName: "play"), for: .normal)
                player.stop()
            } else {
                playAndPauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
                player.play()
            }
        }
        
        stopButton.buttonAction = { [self] in
            player.stop()
            playAndPauseButton.setImage(UIImage(systemName: "play"), for: .normal)
            player.currentTime = 0.0
            timeSlider.value = 0.0

        }
        
        nextSongButton.buttonAction = { [self] in
            if position + 1 < TrackModel.tracks.count {
                position += 1
                setUpPlayer()
                playAndPauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
            }
        }
        
        backwordSongButton.buttonAction = { [self] in
            if position != 0 {
                position -= 1
                setUpPlayer()
                playAndPauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
              
            }
        }
        
        minSound.buttonAction = { [self] in
            volumeSlider.value = volumeSlider.minimumValue
            player.volume = volumeSlider.value
        }
        
        maxSound.buttonAction = { [self] in
            volumeSlider.value = volumeSlider.maximumValue
            player.volume = volumeSlider.value
        }
        
    }
    
        @objc func updateProgress() {
            timeSlider.value = Float(player.currentTime)
            let remainingTime = player.duration - player.currentTime
            remainingTimeValueLable.text = getFormattedTime(timeInterval: remainingTime)
            elapsedTimeValueLable.text = getFormattedTime(timeInterval: player.currentTime)
        }
        
    @objc func changeTime(sender: UISlider) {
        player.currentTime = TimeInterval(sender.value)
        player.play()
    }
    
    @objc func changeVolume() {
        self.player.volume = volumeSlider.value
    }
    
    
    private func getFormattedTime(timeInterval: TimeInterval) -> String {
        
        let mins = timeInterval / 60
        let secs = timeInterval.truncatingRemainder(dividingBy: 60)
        let timeFormatter = NumberFormatter()
        timeFormatter.minimumIntegerDigits = 2
        timeFormatter.minimumFractionDigits = 0
        timeFormatter.roundingMode = .down
        
        guard let minString = timeFormatter.string(from: NSNumber(value: mins)) , let secStr = timeFormatter.string(from: NSNumber(value: secs)) else {
            return "0:00"
        }
        return "\(minString): \(secStr)"
    }
    
}



