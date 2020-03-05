//
//  searchSongViewController.swift
//  altar
//
//  Created by Juan Moreno on 1/16/20.
//  Copyright © 2020 Juan Moreno. All rights reserved.
//

import UIKit
import Alamofire

class searchSongViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var resultados = [elementoVideo] ()
  //  @IBOutlet weak var lista: UICollectionView!
    weak var lista : UICollectionView!
    var cellId = "cellID"
    var pageToken = ""
    var isLoading = false
    var seleccion = elementoVideo ()
    
     override func loadView() {
           super.loadView()

           let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
            self.lista = collectionView
            self.lista.backgroundColor = .lightGray
            self.view.addSubview(searchBar)

            self.view.addSubview(lista)
            searchBar.translatesAutoresizingMaskIntoConstraints = false
            lista.translatesAutoresizingMaskIntoConstraints = false
 
        
        
        searchBar.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: lista.topAnchor, right: view.rightAnchor, paddingTop: 90, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 60)
        lista.anchor(top: searchBar.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 500)
           
         
           self.lista = collectionView
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        view.backgroundColor = .white
        lista.dataSource = self
        lista.delegate = self 
        lista.register(VideoResultcolCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        
  //      let refreshControl = UIRefreshControl()
  //      lista.addSubview(refreshControl)
        
        
        

        
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func searchToYouTube (busqueda: String) {
    

        let parameters = ["part": "snippet", "key" : "AIzaSyCEDNW-3mRvjhXq33TG2AhkOThqqEGaIY0", "q": busqueda, "order": "viewCount", "maxResults": "20", "type":"video", "pageToken": pageToken]
         
        AF.request("https://www.googleapis.com/youtube/v3/search", parameters: parameters).responseJSON { response in
            print(response.debugDescription)
            print(response.data)
            print("----------------------------------------")
            print("Response: \(response)")
            
            do {


                let decoded = try JSONDecoder().decode(YTResult.self, from: response.data!)
                
                
                for itema in decoded.items {
                    
                    var a = elementoVideo()
                    a.title = itema.snippet.title
                    a.description = itema.snippet.description
                    a.urlImage = itema.snippet.thumbnails.medium.url
                    a.videoId = itema.id.videoId
                    
                    self.resultados.append(a)
                    
                    self.lista.reloadData()
                    
                }
               
            
      


                //Now access the data
                print(decoded.pageInfo.resultsPerPage) // 25

                //since the items is array we take first for now
                if  let firstItem = decoded.items.first {
                    //to print the first one
                    print(firstItem.snippet.channelTitle) // "fouseyTUBE"

                    //same for URL
                    print(firstItem.snippet.thumbnails.medium.url) //
                }
                
                print(self.resultados.count)
                
                self.pageToken = decoded.nextPageToken


            } catch {
                debugPrint("\(error.localizedDescription)")
                
                
                
            }
            
            
                 }
       
    }

}

extension searchSongViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        print(searchBar.text)
        if let aBuscar = searchBar.text {
        searchToYouTube(busqueda: aBuscar)
        }
      //  searchBar.text = ""
        
    }
    
}


extension searchSongViewController: UICollectionViewDataSource {
    
    
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return resultados.count
    }
    
    internal func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? VideoResultcolCollectionViewCell)!
        
        if resultados.count > 0 {
        
        cell.resultado = resultados[indexPath.row]
       
        }
       return cell
   }
    
    
    
    
}

extension searchSongViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     //   let a = seleccionVideoViewController ()
    //    a.seleccionVideo = resultados[indexPath.row]
        advengers.shared.seleccionVideo = resultados[indexPath.row]
        performSegue(withIdentifier: "selecionVideo", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "selecionVideo" {
            
            let a = seleccionVideoViewController ()
            a.seleccionVideo = seleccion
        }
    }
   

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offsetY = scrollView.contentOffset.y
            let contentHeight = scrollView.contentSize.height

            if (offsetY > contentHeight - scrollView.frame.height * 4) && !isLoading {
                loadMoreData()
            }
        }
    
    
    func loadMoreData() {
        if !self.isLoading {
            self.isLoading = true
            DispatchQueue.global().async {
                // Fake background loading task for 2 seconds
                sleep(2)
                if let aBuscar = self.searchBar.text {
                    self.searchToYouTube(busqueda: aBuscar)
                }
                DispatchQueue.main.async {
                    self.lista.reloadData()
                    self.isLoading = false
                }
            }
        }
    }
    
    
}


extension searchSongViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 120)
    }

    /*
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0) //.zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
 
 */
    
}
