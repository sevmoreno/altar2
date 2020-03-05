//
//  EventoSeleccionado.swift
//  altar
//
//  Created by Juan Moreno on 2/18/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import Foundation
import UIKit

import Firebase

//protocol deleteDelegate {
//
//    func deleteEvennt(controller:UIViewController)
//}
class EventoSeleccionado: UIViewController {
    
    var devo = Event(dictionary: ["text":"text"])
    let imagen: CustomImageView = {
               let iv = CustomImageView()
               iv.contentMode = .scaleAspectFill
            
               iv.clipsToBounds = true
               iv.backgroundColor = .blue
               return iv
           }()
           
    
    lazy var titulo: UILabel = {
                 let label2 = UILabel ()
                 label2.font = UIFont(name: "Avenir-Heavy", size: 25)
                 label2.text = "You prayed 1"
              label2.textColor = .white
              //   button.setImage(UIImage(named: "cellPrayIcon")?.withRenderingMode(.alwaysOriginal), for: .normal)
                // button.addTarget(self, action: #selector(handleLike), for: .touchUpInside)
        label2.textAlignment = .center
                 return label2
             }()
       
    lazy var deleteButton : UIButton = {
        
        
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "trash")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(deleteEvent), for: .touchUpInside)
        
      return button
        
    } ()
    
    @objc func deleteEvent () {
        
        
        print("Pimer llamado")
        //delegate?.deleteEvennt(controller: self)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "deleteEvent"), object: nil)
        //deleteEvent
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    let textoDevocional: UITextView = {
        
        let a = UITextView ()
        
        
        return a
        
    } ()
    
     //var delegate: deleteDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
      //  devo = advengers.shared.devocionalSeleccinado
        
     //   view.backgroundColor = .white
       // textoDevocional.loadAttributedText(urlString: devo.urltexto)
        
        view.addSubview(imagen)
        
        view.addSubview(titulo)
        
        view.addSubview(textoDevocional)
        
        if advengers.shared.isPastor {
        view.addSubview(deleteButton)
        
        deleteButton.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 100, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        }
        imagen.loadImage(urlString: advengers.shared.eventolSeleccinado.photoURL!)
        
        titulo.text = advengers.shared.eventolSeleccinado.title
        titulo.textAlignment = .center
        titulo.font = UIFont(name: "Avenir-Heavy", size: 18)
   //     view.addSubview(textoDevocional)
        titulo.numberOfLines = 0
        imagen.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
        
       
        titulo.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
        titulo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titulo.centerYAnchor.constraint(equalTo: imagen.centerYAnchor).isActive = true

        
        textoDevocional.anchor(top: imagen.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        
        let loading = NSAttributedString(string: "Loading...")
        DispatchQueue.main.async {
                           self.textoDevocional.attributedText = loading
                           }
      //  print(devo.urltexto)
    //   print(devo.title)
    //    guard let url = URL(string: devo.urltexto) else { return }
        guard let url = URL(string: advengers.shared.eventolSeleccinado.urltexto) else { return }
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
                    self.textoDevocional.attributedText = attributedString
                    }
          //
               
        }.resume()
        
        
        
    }
    
    
}
