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
    
    let flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        return layout
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reusedId)
        
        collectionView.collectionViewLayout = flowLayout
        
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

extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = 3
        let spacing: CGFloat = flowLayout.minimumInteritemSpacing
        let availableWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(availableWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: itemDimension)
     
    }
}

