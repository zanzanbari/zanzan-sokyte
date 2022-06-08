//
//  MovieViewController.swift
//  Concurrency-Practice
//
//  Created by 소연 on 2022/06/03.
//

import UIKit

final class MovieViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var movieCollectionView: UICollectionView = {
       let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupCollectionViewLayout())
       collectionView.translatesAutoresizingMaskIntoConstraints = false
       collectionView.backgroundColor = .systemBackground
       collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.cellIdentifier)
       return collectionView
    }()
    
    internal enum MovieSection: String, CaseIterable {
       case topRated = "Top Rated Movies"
    }
    
    private var dataSource: UICollectionViewDiffableDataSource<MovieSection, Movie>!
    private var snapshot: NSDiffableDataSourceSnapshot<MovieSection, Movie>!
    
    private var movies = [Movie]()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupCollectionView()
        
        Task {
            do {
                let movies = try await MovieFetcher.fetchMovieWithAsyncURLSession()
                dump(movies)
            } catch {
                print("Request failed with error: \(error)")
            }
        }
    }
    
    // MARK: - Custom Method
    
    private func setupCollectionView() {
       view.addSubview(movieCollectionView)
       NSLayoutConstraint.activate([
          movieCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
          movieCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
          movieCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
          movieCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
       ])
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Movie> { (cell, indexPath, movie) in
            
        }
        
        dataSource = UICollectionViewDiffableDataSource<MovieSection, Movie>(collectionView: movieCollectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Movie) -> UICollectionViewCell? in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: identifier)
            return cell
        }
    }
    
    private func updateCollectionViewSnapshot(_ albums: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<MovieSection, Movie>()
        snapshot.appendSections([.topRated])
        snapshot.appendItems(albums, toSection: .topRated)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func setupCollectionViewLayout() -> UICollectionViewLayout {
       let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
          
          let movieSections = MovieSection.allCases[sectionIndex]
          switch movieSections {
          case .topRated: return self.createTopRatedMovieSection()
          }
       }
       return layout
    }
    
    private func createTopRatedMovieSection() -> NSCollectionLayoutSection {
       let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
       let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(140), heightDimension: .absolute(220))
       let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
       group.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
       
       let section = NSCollectionLayoutSection(group: group)
       section.orthogonalScrollingBehavior = .groupPaging
       return section
    }
}


