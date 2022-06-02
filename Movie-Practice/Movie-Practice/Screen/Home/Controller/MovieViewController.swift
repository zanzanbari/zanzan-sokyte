//
//  MovieViewController.swift
//  Movie-Practice
//
//  Created by 소연 on 2022/06/02.
//

import UIKit

import SnapKit
import Then

final class MovieViewController: UIViewController {
    
    // MARK: - Properties
    
//    private var movieCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.itemSize = UICollectionViewFlowLayout.automaticSize
//        layout.estimatedItemSize = .zero
//
//        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
//            $0.backgroundColor = .clear
//            $0.isScrollEnabled = true
//            $0.showsHorizontalScrollIndicator = false
//        }
//    }()
    
    private lazy var movieCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupCollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.cellIdentifier)
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: MovieViewController.sectionHeaderElementKind, withReuseIdentifier: HeaderView.reuseIdentifier)
        return collectionView
     }()
    
    private var viewModel = MovieViewModel()
    
    static let sectionHeaderElementKind = "section-header-element-kind"
    
    public enum MovieSection: String, CaseIterable {
       case topRated = "Top Rated Movies"
       case onGoing = "Now Playing Movies"
       case upcoming = "Upcoming Movies"
       case popular = "Popular Movies"
    }
    
//    private var movieDataSource: UICollectionViewDiffableDataSource<MovieSection,Movie>?

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        loadPopularMoviesData()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubview(movieCollectionView)
        
        movieCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    // MARK: - Custom Method
    
    private func loadPopularMoviesData() {
        viewModel.fetchPopularMoviesData { [weak self] in
            self?.movieCollectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.cellIdentifier)
            
            self?.movieCollectionView.dataSource = self
            
            self?.movieCollectionView.reloadData()
        }
    }
    
    func setupCollectionViewLayout() -> UICollectionViewLayout {
       let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
          
          let movieSections = MovieSection.allCases[sectionIndex]
          switch movieSections {
          case .topRated: return self.createTopRatedMovieSection()
          case .onGoing: return self.createTopRatedMovieSection()
          case .upcoming: return self.createTopRatedMovieSection()
          case .popular: return self.createTopRatedMovieSection()
          }
       }
       return layout
    }
    
    fileprivate func createTopRatedMovieSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(140), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
        heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: MovieViewController.sectionHeaderElementKind, alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
}

// MARK: - UICollectionView

extension MovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.cellIdentifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        let movie = viewModel.cellForRowAt(indexPath: indexPath)
        cell.setCellWithValuesOf(movie)
        return cell
    }
}
