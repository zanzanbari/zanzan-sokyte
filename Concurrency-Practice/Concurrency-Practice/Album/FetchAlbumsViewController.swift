//
//  ViewController.swift
//  Concurrency-Practice
//
//  Created by 소연 on 2022/06/03.
//

import UIKit

final class FetchAlbumsViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    @IBOutlet weak var collectionView: UICollectionView!

    private var dataSource: UICollectionViewDiffableDataSource<Section, Album>!
    private var snapshot: NSDiffableDataSourceSnapshot<Section, Album>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layoutConfig = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)
        collectionView.collectionViewLayout = listLayout
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Album> { (cell, indexPath, album) in
            
            var content = cell.defaultContentConfiguration()
            content.text = album.collectionName
            content.secondaryText = "Price: \(album.collectionPrice)"
            
            cell.contentConfiguration = content
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Album>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Album) -> UICollectionViewCell? in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: identifier)
            return cell
        }
    }
    
    private func updateCollectionViewSnapshot(_ albums: [Album]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Album>()
        snapshot.appendSections([.main])
        snapshot.appendItems(albums, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    
    @IBAction func closureButtonTapped(_ sender: Any) {
        updateCollectionViewSnapshot([])
        
        AlbumsFetcher.fetchAlbums { [unowned self] result in
            switch result {
            case .success(let albums):
                DispatchQueue.main.async { [self] in
                    // Update collection view content
                    self.updateCollectionViewSnapshot(albums)
                }
                
            case .failure(let error):
                print("Request failed with error: \(error)")
            }
        }
    }
    

    @IBAction func continuationButtonTapped(_ sender: Any) {
        updateCollectionViewSnapshot([])
        Task {
            do {
                let albums = try await AlbumsFetcher.fetchAlbumWithContinuation()
                updateCollectionViewSnapshot(albums)
                
            } catch {
                print("Request failed with error: \(error)")
            }
        }
    }
    
    @IBAction func asyncURLSessionButtonTapped(_ sender: Any) {
        updateCollectionViewSnapshot([])
        Task {
            do {
                let albums = try await AlbumsFetcher.fetchAlbumWithAsyncURLSession()
                updateCollectionViewSnapshot(albums)
            } catch {
                print("Request failed with error: \(error)")
            }
        }
    }
}
