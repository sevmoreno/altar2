//
//  seleccionVideoViewController.swift
//  altar
//
//  Created by Juan Moreno on 1/17/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit
import WebKit

class seleccionVideoViewController: UIViewController {
    
    
    var seleccionVideo: elementoVideo!
    
    var videoURL:URL!  // has the form "https://www.youtube.com/embed/videoID"
      var didLoadVideo = false
    
    
    @IBOutlet weak var videoConteiner: WKWebView!
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
       
        
        
        print("llego la selecciono")
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        
        
     super.viewDidLayoutSubviews()
        
        /*
        videoURL = URL(string: "https://www.youtube.com/embed/" + seleccionVideo.videoId)
        print(videoURL.lastPathComponent)
        */
        
    var embedVideoHtml:String {
        return """
        <!DOCTYPE html>
        <html>
        <body>
        <!-- 1. The <iframe> (and video player) will replace this <div> tag. -->
        <div id="player"></div>

        <script>
        var tag = document.createElement('script');

        tag.src = "https://www.youtube.com/player_api";
        var firstScriptTag = document.getElementsByTagName('script')[0];
        firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

        var player;
        function onYouTubeIframeAPIReady() {
        player = new YT.Player('player', {
        playerVars: { 'autoplay': 1, 'controls': 1, 'fs': 0, 'playsinline': 1 },
        height: '\(videoConteiner.frame.height)',
        width: '\(videoConteiner.frame.width)',
        videoId: '\(advengers.shared.seleccionVideo.videoId)',
        events: {
        'onReady': onPlayerReady
        }
        });
        }

        function onPlayerReady(event) {
        event.target.playVideo();
        }
        </script>
        </body>
        </html>
        """
    }
    

        
        print("Este es el elemnto en Seleccion video")
        
        print(advengers.shared.seleccionVideo.videoId)
        print(videoConteiner.frame.height)
        
        
  //   if !didLoadVideo {
        
        videoConteiner.loadHTMLString(embedVideoHtml, baseURL: nil)
        
        didLoadVideo = true
  //   }
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
