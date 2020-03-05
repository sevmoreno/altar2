//
//  DevocionalSeleccionado.swift
//  altar
//
//  Created by Juan Moreno on 1/20/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import Foundation
import UIKit

class DevocionalSeleccionado: UIViewController {
    
    var devo = Devo(dictionary: ["text":"text"])
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
                 return label2
             }()
       
    
    let textoDevocional: UITextView = {
        
        let a = UITextView ()
        
        
        return a
        
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      //  devo = advengers.shared.devocionalSeleccinado
        
     //   view.backgroundColor = .white
       // textoDevocional.loadAttributedText(urlString: devo.urltexto)
        
        view.addSubview(imagen)
        
        view.addSubview(titulo)
        
        view.addSubview(textoDevocional)
        
        textoDevocional.isEditable = false
        
        imagen.loadImage(urlString: advengers.shared.devocionalSeleccinado.photoURL!)
        
        titulo.text = advengers.shared.devocionalSeleccinado.title
   //     view.addSubview(textoDevocional)
        
        imagen.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 300)
        
       
        titulo.anchor(top: nil, left: imagen.leftAnchor, bottom: imagen.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
        
        
        textoDevocional.anchor(top: imagen.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0)
        
      DispatchQueue.main.async {
                        let cargando = NSAttributedString(string: "Loading...")
                        self.textoDevocional.attributedText = cargando
                    }
        
        guard let url = URL(string: advengers.shared.devocionalSeleccinado.urltexto) else { return }
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
