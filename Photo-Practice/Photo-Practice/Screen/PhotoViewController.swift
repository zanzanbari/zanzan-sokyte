//
//  PhotoViewController.swift
//  Photo-Practice
//
//  Created by 소연 on 2022/06/13.
//

import UIKit

import Photos
import PhotosUI

class PhotoViewController: UIViewController {
    
    var allPhotos: PHFetchResult<PHAsset>!
    let imageManager = PHCachingImageManager()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCollectionView()
        fetchAllPhotos()
    }
    
    private func setCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func fetchAllPhotos() {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        let df = DateFormatter()
        df.dateFormat = "yyyy.MM.dd"
        let startDate = df.date(from: "2022.06.06")! as CVarArg
        let endDate = df.date(from: "2022.06.07")! as CVarArg
        
        allPhotosOptions.predicate = NSPredicate(format: "mediaType = %d AND ( creationDate > %@ && creationDate < %@ )",PHAssetMediaType.image.rawValue, startDate, endDate)
        
        allPhotos = PHAsset.fetchAssets(with: allPhotosOptions)
        collectionView?.reloadData()
    }
    
}

extension PhotoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("")
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCell else {
            return true
        }
        
        if cell.isSelected {
            collectionView.deselectItem(at: indexPath, animated: false)
            return false
        } else {
            let vc = MainViewController()
            if let image = cell.imageView.image {
                vc.image = image
            }
            dismiss(animated: true)
            return true
        }
    }
}

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - 20) / 5
        let cellHeight = (collectionView.frame.height) / 5
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let assetCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCell
        let asset = allPhotos.object(at: indexPath.item)
        assetCell.representedAssetIdentifier = asset.localIdentifier
        
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil, resultHandler: { image, _ in
            if assetCell.representedAssetIdentifier == asset.localIdentifier {
                assetCell.imageView.image = image
            }
        })
        
        return assetCell
    }
}

class ImageCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override var isSelected: Bool {
        didSet {
            contentView.layer.borderColor = isSelected ? UIColor.blue.cgColor : UIColor.clear.cgColor
            contentView.layer.borderWidth = isSelected ? 5 : 0
        }
    }
    
    var representedAssetIdentifier: String!
}

extension String {
    func toDate() -> NSDate? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "ko_KR")
        if let date = dateFormatter.date(from: self) {
            return date as NSDate
        } else {
            return nil
        }
    }
}

