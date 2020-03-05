//
//  extensions.swift
//  altar
//
//  Created by Juan Moreno on 12/18/19.
//  Copyright © 2019 Juan Moreno. All rights reserved.
//


import Foundation
import Firebase

import UIKit

extension UIColor {
    
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    //    func someRandomeMethod() {
    //
    //    }
    
    
    
}
extension UIButton {
    func applyGradient(colors: [CGColor]) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = self.frame.height/2

        gradientLayer.shadowColor = UIColor.darkGray.cgColor
        gradientLayer.shadowOffset = CGSize(width: 2.5, height: 2.5)
        gradientLayer.shadowRadius = 5.0
        gradientLayer.shadowOpacity = 0.3
        gradientLayer.masksToBounds = false

        self.layer.insertSublayer(gradientLayer, at: 0)
        self.contentVerticalAlignment = .center
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17.0)
        self.titleLabel?.textColor = UIColor.white
    }
}


extension Database {
    
    static func fetchUserWithUID(uid: String, completion: @escaping (User) -> ()) {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let userDictionary = snapshot.value as? [String: Any] else { return }
            print("Diccionario Usuary")
            print(userDictionary)
//            let user = User(uid: userDictionary["userid"] as? String ?? "", dictionary: userDictionary)
            
            let user = User()
            user.setup(uid: userDictionary["userid"] as? String ?? "", dictionary: userDictionary)
            completion(user)
            
        }) { (err) in
            print("Failed to fetch user for posts:", err)
        }
    }
}



extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?,  paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
}


extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        let month = 4 * week
        
        let quotient: Int
        let unit: String
        if secondsAgo < minute {
            quotient = secondsAgo
            unit = "second"
        } else if secondsAgo < hour {
            quotient = secondsAgo / minute
            unit = "min"
        } else if secondsAgo < day {
            quotient = secondsAgo / hour
            unit = "hour"
        } else if secondsAgo < week {
            quotient = secondsAgo / day
            unit = "day"
        } else if secondsAgo < month {
            quotient = secondsAgo / week
            unit = "week"
        } else {
            quotient = secondsAgo / month
            unit = "month"
        }
        
        return "\(quotient) \(unit)\(quotient == 1 ? "" : "s") ago"
        
    }
    


        var millisecondsSince1970:Int64 {
            return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
        }

        init(milliseconds:Int64) {
            self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
        }
  
}

extension UIImage {
    func getImageRatio() -> CGFloat {
        let imageRatio = CGFloat(self.size.width / self.size.height)
        return imageRatio
    }
    
    

    
    
}

extension UIImageView {
    
    func downloadImage (imgURL: String) {
        
  
            let url = URLRequest(url: URL(string: imgURL)!)
            
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    
                    print(error?.localizedDescription)
                    return
                }
                
                DispatchQueue.main.async {
                    
                    self.image = UIImage(data: data!)
                }
                
            }
        
        task.resume()
        
        
        
    }
    
    
}

extension UILabel {
    private struct AssociatedKeys {
        static var padding = UIEdgeInsets()
    }

    public var padding: UIEdgeInsets? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    override open func draw(_ rect: CGRect) {
        if let insets = padding {
            self.drawText(in: rect.inset(by: insets))
        } else {
            self.drawText(in: rect)
        }
    }

    override open var intrinsicContentSize: CGSize {
        guard let text = self.text else { return super.intrinsicContentSize }

        var contentSize = super.intrinsicContentSize
        var textWidth: CGFloat = frame.size.width
        var insetsHeight: CGFloat = 0.0
        var insetsWidth: CGFloat = 0.0

        if let insets = padding {
            insetsWidth += insets.left + insets.right
            insetsHeight += insets.top + insets.bottom
            textWidth -= insetsWidth
        }

        let newSize = text.boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude),
                                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                        attributes: [NSAttributedString.Key.font: self.font], context: nil)

        contentSize.height = ceil(newSize.size.height) + insetsHeight
        contentSize.width = ceil(newSize.size.width) + insetsWidth

        return contentSize
    }
}

extension UITextView {
    


 //   var imageCache = [String: UIImage]()

  //  class CustomText: UIImageView {
        
     //   var lastURLUsedToLoadImage: String?
        
        func loadAttributedText(urlString: String) {
            
            //lastURLUsedToLoadImage = urlString
            
         //   if let cachedImage = imageCache[urlString] {
       //         self.image = cachedImage
           //     return
       //     }
            
            guard let url = URL(string: urlString) else { return }
            
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                if let err = err {
                    print("Failed to fetch HTML:", err)
                    return
                }
                
                
               // if let attributedString = try! NSAttributedString(data: data!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                let attributedString = try! NSAttributedString(data: data!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
                    print("Este es el texto que bajo")
                    print(attributedString)
                    
                   DispatchQueue.main.async {
                   self.attributedText = attributedString
                    }
               //}

         //       guard let imageData = data else { return }
                
        //        let photoImage = UIImage(data: imageData)
                
         //       imageCache[url.absoluteString] = photoImage
                
         //       DispatchQueue.main.async {
                 //   self.image = photoImage
            //    }
          //
                }.resume()
        }
    

}

extension UITextView {

    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }

    func returnVertical () {
        /*
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
              let size = sizeThatFits(fittingSize)
              let topOffset = (bounds.size.height - size.height * zoomScale) / 2
              let positiveTopOffset = max(1, topOffset)
 */
        
        contentOffset.y  = 0
        
    }
}

extension NSLayoutManager {
    var numberOfLines: Int {
        guard let textStorage = textStorage else { return 0 }

        var count = 0
        enumerateLineFragments(forGlyphRange: NSMakeRange(0, numberOfGlyphs)) { _, _, _, _, _ in
            count += 1
        }
        return count
    }
}
