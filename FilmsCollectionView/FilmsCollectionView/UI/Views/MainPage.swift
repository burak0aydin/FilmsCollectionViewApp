//
//  ViewController.swift
//  FilmsCollectionView
//
//  Created by Burak Aydın on 19.09.2023.
//

import UIKit

class MainPage: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var filmsList = [Films] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let f1 = Films(id: 1, name:  "Django", image: "django", price: 24)
        let f2 = Films(id: 2, name: "Interstellar", image: "interstellar", price: 32)
        let f3 = Films(id: 3, name: "Inception", image: "inception", price: 16)
        let f4 = Films(id: 4, name: "The Hateful Eight", image: "thehatefuleight", price: 28)
        let f5 = Films(id: 5, name: "The Pianist", image: "thepianist", price: 18)
        let f6 = Films(id: 6, name: "Anadoluda", image: "anadoluda", price: 10)
        filmsList.append(f1)
        filmsList.append(f2)
        filmsList.append(f3)
        filmsList.append(f4)
        filmsList.append(f5)
        filmsList.append(f6)
        
        designOfCollectionView()
        
       
    }


}

extension MainPage : UICollectionViewDelegate, UICollectionViewDataSource, cellProtocol {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  filmsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let film = filmsList[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "filmsCell", for: indexPath) as! filmsCell
        cell.filmsImageView.image = UIImage(named: film.image!)
        cell.filmsPriceTextLabe.text = "\(film.price!) ₺"
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.3
        cell.layer.cornerRadius = 15
        cell.backgroundColor = UIColor(white: 0.96, alpha: 1)
        
        cell.cellProtocol = self
        cell.indexPath = indexPath
        
        
        return cell
    }
    
    func designOfCollectionView () {
        
        let design = UICollectionViewFlowLayout()
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.minimumInteritemSpacing = 10
        design.minimumLineSpacing = 10
        
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = (screenWidth - 30) / 2
        
        design.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.65)
        collectionView.collectionViewLayout = design
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let film = filmsList[indexPath.row]
        
        print("\(film.name!)")
        performSegue(withIdentifier: "toDetailsVC", sender: film)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            if let film = sender as? Films {
                let toVC = segue.destination as! DetailsPage
                toVC.film = film
            }
        }
    }
    
    func addToList(indexPath: IndexPath) {
        let film = filmsList[indexPath.row]
        print ("\(film.name!) added to list ")
    }
    
    
}
