//
//  PlayerController.swift
//  Navigation
//
//  Created by Oleg Popov on 17.11.2022.
//

import Foundation
import UIKit
import AVFoundation

final class PlayerController: UIViewController {
    
    private var player = AVAudioPlayer()
    public var position: Int = 0
    private var timer: Timer?
    
    private let trackName: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 25, weight: .bold)
        lable.textColor = .white
        lable.textAlignment = .center
        lable.toAutoLayout()
        return lable
    }()
    
    private let artistName: UILabel = {
        let lable = UILabel()
        lable.font = .systemFont(ofSize: 20, weight: .bold)
        lable.textColor = .white
        lable.textAlignment = .center
        lable.toAutoLayout()
        return lable
    }()
    
    private let trackImg: UIImageView = {
        let img = UIImageView()
        img.layer.borderWidth = 1
        img.layer.backgroundColor = UIColor.systemGray.cgColor
        img.layer.cornerRadius = 8
        img.layer.shadowOffset = CGSize(width: 4, height: 4)
        img.layer.shadowRadius = 4
        img.layer.shadowColor = UIColor.black.cgColor
        img.layer.shadowOpacity = 0.7
        img.contentMode = .scaleToFill
        img.clipsToBounds = true
        img.toAutoLayout()
        return img
    }()
    
    private lazy var playAndPauseButton = PlayerButton(image: "play")
    private lazy var stopButton = PlayerButton(image: "stop")
    private lazy var nextSongButton = PlayerButton(image: "forward")
    private lazy var backwordSongButton = PlayerButton(image: "backward")
    
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
        lable.font = .systemFont(ofSize: 15, weight: .light)
        lable.textColor = .white
        lable.textAlignment = .center
        lable.toAutoLayout()
        return lable
    }()
    
    private let  remainingTimeValueLable: UILabel = {
       let lable = UILabel()
        lable.text = "2:13"
        lable.font = .systemFont(ofSize: 15, weight: .light)
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
    
    private let minSound = PlayerButton(image: "speaker.wave.1")
    private let maxSound = PlayerButton(image: "speaker.wave.3")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        
        view.addSubviews(artistName,trackImg, trackName, timeSlider, buttonsStack, elapsedTimeValueLable, remainingTimeValueLable, soundStack)
        
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
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            
            artistName.topAnchor.constraint(equalTo: view.topAnchor, constant: 45),
            artistName.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            trackImg.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 10),
            trackImg.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trackImg.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -60),
            trackImg.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60),
            trackImg.heightAnchor.constraint(equalTo: trackImg.widthAnchor),

            trackName.topAnchor.constraint(equalTo: trackImg.bottomAnchor, constant: 10),
            trackName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            timeSlider.topAnchor.constraint(equalTo: trackName.centerYAnchor, constant: 70),
            timeSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeSlider.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40),
            timeSlider.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40),
            timeSlider.heightAnchor.constraint(equalToConstant: 1.5),
            
            buttonsStack.topAnchor.constraint(equalTo: timeSlider.bottomAnchor, constant: 35),
            buttonsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStack.heightAnchor.constraint(equalToConstant: 50),
            
            soundStack.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: 25),
            soundStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            soundStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15),
            soundStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),
            
            elapsedTimeValueLable.bottomAnchor.constraint(equalTo: timeSlider.topAnchor, constant: -20),
            elapsedTimeValueLable.leftAnchor.constraint(equalTo: view.leftAnchor, constant:  15),
            
            remainingTimeValueLable.bottomAnchor.constraint(equalTo: timeSlider.topAnchor, constant: -20),
            remainingTimeValueLable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15),

            playAndPauseButton.widthAnchor.constraint(equalToConstant: 50),
            playAndPauseButton.heightAnchor.constraint(equalToConstant: 50),

            stopButton.widthAnchor.constraint(equalToConstant: 50),
            stopButton.heightAnchor.constraint(equalToConstant: 50),

            backwordSongButton.widthAnchor.constraint(equalToConstant: 25),
            nextSongButton.widthAnchor.constraint(equalToConstant: 25),
          
            
        ])
    }
    
    
    private func setUpPlayer() {
        
        let track = TrackModel.tracks[position]
        
        trackImg.image = track.image
        trackName.text = track.trackName
        artistName.text = track.artistName
        
        guard let path = Bundle.main.path(forResource: track.fileName, ofType: "mp3") else {
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
                player.stop()
                playAndPauseButton.setImage(UIImage(systemName: "play"), for: .normal)
            } else {
                player.play()
                playAndPauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
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
                player.play()
                playAndPauseButton.setImage(UIImage(systemName: "pause"), for: .normal)
            }
        }
        
        backwordSongButton.buttonAction = { [self] in
            if position != 0 {
                position -= 1
                setUpPlayer()
                player.play()
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



