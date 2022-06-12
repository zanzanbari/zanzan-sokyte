//
//  ViewController.swift
//  Photo-Practice
//
//  Created by 소연 on 2022/06/13.
//

import UIKit

import Photos
import PhotosUI

class ViewController: UIViewController {

    @IBOutlet weak var photoTableView: UITableView!
    
    var fetchResuls: [PHFetchResult<PHAsset>] = [] //앨범 정보
    let imageManager = PHCachingImageManager() //앨범에서 사진 받아오기 위한 객체
    var fetchOptions: PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        
        return fetchOptions
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkPermission()
        
        photoTableView.delegate = self
        photoTableView.dataSource = self
    }


    func checkPermission() {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            self.requestImageCollection()
        case .denied: break
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                switch $0 {
                case .authorized:
                    self.requestImageCollection()
                case .denied: break
                default:
                    break
                }
            })
        default:
            break
        }
    }

    func requestImageCollection() {
        let cameraRoll = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        let favoriteList = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumFavorites, options: nil)
        let albumList = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)
        addAlbums(collection: cameraRoll)
        addAlbums(collection: favoriteList)
        addAlbums(collection: albumList)
        
        OperationQueue.main.addOperation {
            self.photoTableView.reloadData()
        }
    }

    private func addAlbums(collection : PHFetchResult<PHAssetCollection>){
        for i in 0 ..< collection.count {
            let collection = collection.object(at: i)
            self.fetchResuls.append(PHAsset.fetchAssets(in: collection, options: fetchOptions))
        }
    }

}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResuls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell else {
            return UITableViewCell()
        }
        guard let asset = fetchResuls[indexPath.row].firstObject as? PHAsset else {
            return UITableViewCell()
        }
        
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil) { (image, _) in
            cell.imageView?.image = image
        }
        return cell
    }
}
