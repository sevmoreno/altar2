//
//  OnlyVideoPostViewController.swift
//  altar
//
//  Created by Juan Moreno on 11/13/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//

import UIKit
import AVFoundation

class OnlyVideoPostViewController: UIViewController {

    @IBOutlet weak var videoView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let urla = URL(string: "https://devstreaming-cdn.apple.com/videos/streaming/examples/img_bipbop_adv_example_ts/master.m3u8")
        else {
        return
        }
            
        let asset = AVAsset(url: urla)
        let playerItem = AVPlayerItem(asset: asset)
        let player = AVPlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.videoView.bounds
        playerLayer.videoGravity = .resizeAspect
        self.videoView.layer.addSublayer(playerLayer)
        player.play()
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
