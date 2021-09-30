//
//  PhotoCollectionViewController.swift
//  VK
//
//  Created by Михаил Чертов on 11.08.2021.
//

import UIKit


class PhotoCollectionViewController: UICollectionViewController {
    
    var friendId: Int = 0
    var userPhoto: [Photo]?
    lazy var vkApi = VKApi()
    lazy var repository = Repository()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFromCache()
        vkApi.getFriendsPhoto(ownerId: friendId) {
            [weak self] in
            self?.loadFromCache()
        }

    }
    
    
    private func loadFromCache() {
        userPhoto = repository.fetchPhotos(ownerId: friendId)
        collectionView?.reloadData()
    }

    
    // MARK: - Navigation
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toShowPhoto", sender: nil)
    }

   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return userPhoto!.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userPhoto!.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        let photo = userPhoto![indexPath.row]
        let url = URL(string: photo.imageUrl)
        cell.configure(with: url)
        return cell
    }
}

