//
//  VideoPlayerViewController.swift
//  Navigation
//
//  Created by Oleg Popov on 21.11.2022.
//

import Foundation
import UIKit
import YoutubeKit

class VideoPlayerViewController: UIViewController {
    
    private var player: YTSwiftyPlayer!
    private let videoID: String
    
    init(videoID: String) {
        self.videoID = videoID
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playVideo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        player.stopVideo()
    }
    
    func playVideo() {
        player = YTSwiftyPlayer(frame: CGRect(x: 0, y: 0, width: 640, height: 480),
        playerVars: [
            .playsInline(true),
            .videoID(videoID),
            .loopVideo(true)
        ])
        
        player.autoplay = true
        view = player
        player.delegate = self as? YTSwiftyPlayerDelegate
        player.loadPlayerHTML("https://www.youtube.com/embed/\(videoID)")
    }
}

