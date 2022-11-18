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
        lable.font = .systemFont(ofSize: 20, weight: .medium)
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
    
    private let progressBar: UIProgressView = {
       let progress = UIProgressView()
        progress.progressViewStyle = .bar
        progress.setProgress(0.0, animated: true)
        progress.progressTintColor = .white
        progress.trackTintColor = .lightGray
        progress.toAutoLayout()
        
        return progress
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemTeal
        
        view.addSubviews(artistName,trackImg, trackName, progressBar, buttonsStack, elapsedTimeValueLable, remainingTimeValueLable)
        
        buttonsStack.addArrangedSubview(backwordSongButton)
        buttonsStack.addArrangedSubview(playAndPauseButton)
        buttonsStack.addArrangedSubview(stopButton)
        buttonsStack.addArrangedSubview(nextSongButton)
        
        addConstraints()
        setUpPlayer()
        
        addButtunAction()
        
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            
            artistName.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            artistName.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            trackImg.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 20),
            trackImg.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trackImg.widthAnchor.constraint(equalToConstant: 250),
            trackImg.heightAnchor.constraint(equalTo: trackImg.widthAnchor),

            trackName.topAnchor.constraint(equalTo: trackImg.bottomAnchor, constant: 20),
            trackName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            progressBar.topAnchor.constraint(equalTo: trackName.centerYAnchor, constant: 80),
            progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressBar.widthAnchor.constraint(equalToConstant: 250),
            progressBar.heightAnchor.constraint(equalToConstant: 1.5),
            
            buttonsStack.topAnchor.constraint(equalTo: trackImg.bottomAnchor, constant: 180),
            buttonsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStack.heightAnchor.constraint(equalToConstant: 35),
            
            elapsedTimeValueLable.bottomAnchor.constraint(equalTo: progressBar.topAnchor, constant: -5),
            elapsedTimeValueLable.leftAnchor.constraint(equalTo: progressBar.leftAnchor),
            
            remainingTimeValueLable.bottomAnchor.constraint(equalTo: progressBar.topAnchor, constant: -5),
            remainingTimeValueLable.rightAnchor.constraint(equalTo: progressBar.rightAnchor),

            playAndPauseButton.widthAnchor.constraint(equalToConstant: 50),
            stopButton.widthAnchor.constraint(equalToConstant: 50),
            backwordSongButton.widthAnchor.constraint(equalToConstant: 50),
            nextSongButton.widthAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    private func setUpPlayer() {
        
        do {
  
            let track = TrackModel.tracks[position]
            
            trackImg.image = track.image
            trackName.text = track.trackName
            artistName.text = track.artistName
            
        guard let path = Bundle.main.path(forResource: track.fileName, ofType: "mp3") else { return }
            let url = URL(fileURLWithPath: path)
            player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
        } catch {
            print(error)
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
        }
        
        nextSongButton.buttonAction = { [self] in
            if position + 1 < TrackModel.tracks.count {
                position += 1
                setUpPlayer()
                player.play()
            }
        }
        
        backwordSongButton.buttonAction = { [self] in
            if position != 0 {
                position -= 1
                setUpPlayer()
                player.play()
            }
        }
        
        
    }
    
    
}



