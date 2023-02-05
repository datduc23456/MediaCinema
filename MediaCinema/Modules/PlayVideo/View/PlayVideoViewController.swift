//
//  PlayVideoViewController.swift
//  MediaCinema
//
//  Created by đạt on 05/02/2023.
//  Copyright © 2023 dat.nguyen. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class PlayVideoViewController: BaseViewController, PlayVideoViewProtocol, YTPlayerViewDelegate {

    @IBOutlet weak var playerView: YTPlayerView!
    var presenter: PlayVideoPresenterProtocol
    
    var key: String? {
        if let key = payload as? String {
            return key
        }
        return nil
    }
    
	init(presenter: PlayVideoPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "PlayVideoViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

	override func viewDidLoad() {
        super.viewDidLoad()

        presenter.view = self
        presenter.viewDidLoad()
        self.view.backgroundColor = .black
        playerView.delegate = self
        playerView.load(withVideoId: key.isNil(value: ""))
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }

}
