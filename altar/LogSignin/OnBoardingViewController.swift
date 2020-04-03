//
//  OnBoardingViewController.swift
//  altar
//
//  Created by Juan Moreno on 4/1/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var btnGetStarted: UIButton!
    @IBOutlet var btnSignIn: UIButton!

    var scrollWidth: CGFloat! = 0.0
    var scrollHeight: CGFloat! = 0.0

    //data for the slides
    var titles = ["Invite your church members","Add content","Engage"]
    var descs = ["Select the Settings icon in the upper left corner. Select Share App and you then  can share your app access via e-mail, text message, and more.","Now you can create prayers request, devotionals, events and selected a worship channel to your church.","Every day Altar app is going to remember your church to engage in prayer, worship, and reading the word. You can do the same!"]
    var imgs = ["intro1","intro4","intro5"]

    //get dynamic width and height of scrollview and save it
    override func viewDidLayoutSubviews() {
        scrollWidth = scrollView.frame.size.width
        scrollHeight = scrollView.frame.size.height
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        //to call viewDidLayoutSubviews() and get dynamic width and height of scrollview

        self.scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false

        //crete the slides and add them
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)

        for index in 0..<titles.count {
            frame.origin.x = scrollWidth * CGFloat(index)
            frame.size = CGSize(width: scrollWidth, height: scrollHeight)

            let slide = UIView(frame: frame)

            //subviews
            let imageView = UIImageView.init(image: UIImage.init(named: imgs[index]))
            imageView.frame = CGRect(x:0,y:0,width:300,height:300)
            imageView.contentMode = .scaleAspectFit
            imageView.center = CGPoint(x:scrollWidth/2,y: scrollHeight/2 - 50)
          
            let txt1 = UILabel.init(frame: CGRect(x:32,y:imageView.frame.maxY+30,width:scrollWidth-64,height:30))
            txt1.textAlignment = .center
            txt1.font = UIFont.boldSystemFont(ofSize: 20.0)
            txt1.textColor = .white
            txt1.text = titles[index]
            

            let txt2 = UILabel.init(frame: CGRect(x:32,y:txt1.frame.maxY+10,width:scrollWidth-64,height:120))
            txt2.textAlignment = .center
            txt2.numberOfLines = 4
            txt2.font = UIFont.systemFont(ofSize: 18.0)
            txt2.textColor = .white
            txt2.text = descs[index]

            slide.addSubview(imageView)
            slide.addSubview(txt1)
            slide.addSubview(txt2)
            scrollView.addSubview(slide)
            
            
        

        }
        
        btnGetStarted.backgroundColor = UIColor.rgb(red: 247, green: 131, blue: 97)
      //  btnGetStarted.layer.cornerRadius = 22
        btnGetStarted.layer.masksToBounds = true
        btnGetStarted.setTitleColor(.white , for: .normal)
        btnGetStarted.setTitle("Skip tutorial", for: .normal)
        btnGetStarted.setTitleColor(UIColor.white.withAlphaComponent(0.3), for: .highlighted )
        btnGetStarted.applyGradient(colors: [WelcomeViewController.UIColorFromRGB(0xF78361).cgColor,WelcomeViewController.UIColorFromRGB(0xF54B64).cgColor])

        //set width of scrollview to accomodate all the slides
        scrollView.contentSize = CGSize(width: scrollWidth * CGFloat(titles.count), height: scrollHeight)

        //disable vertical scroll/bounce
        self.scrollView.contentSize.height = 1.0

        //initial state
        pageControl.numberOfPages = titles.count
        pageControl.currentPage = 0

    }

    //indicator
    @IBAction func pageChanged(_ sender: Any) {
        scrollView!.scrollRectToVisible(CGRect(x: scrollWidth * CGFloat ((pageControl?.currentPage)!), y: 0, width: scrollWidth, height: scrollHeight), animated: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setIndiactorForCurrentPage()
    }

    func setIndiactorForCurrentPage()  {
        let page = (scrollView?.contentOffset.x)!/scrollWidth
        pageControl?.currentPage = Int(page)
    }

}
