//
//  MovieCollectionViewCell.swift
//  Movie-Practice
//
//  Created by 소연 on 2022/06/02.
//

import UIKit

import SnapKit
import Then

final class MovieCollectionViewCell: UICollectionViewCell {
    static var cellIdentifier: String { return String(describing: self) }
    
    // MARK: - Properties
    
    private var movieTitle = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
    }
    
    private var movieYear = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
    }
    
    private var movieRate = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
    }
    
    private var movieOverview = UILabel().then {
        $0.font = .systemFont(ofSize: 10)
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    private var moviePoster = UIImageView()
    
    private var urlString: String = ""
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        contentView.backgroundColor = .white
    }
    
    private func setLayout() {
        contentView.addSubview(movieTitle)
        contentView.addSubview(movieRate)
        contentView.addSubview(movieYear)
        contentView.addSubview(movieOverview)
        contentView.addSubview(moviePoster)
        
        moviePoster.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(150)
        }
        
        movieTitle.snp.makeConstraints {
            $0.top.equalTo(moviePoster.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        movieYear.snp.makeConstraints {
            $0.top.equalTo(movieTitle.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(10)
        }
        
        movieRate.snp.makeConstraints {
            $0.top.equalTo(movieTitle.snp.bottom).offset(5)
            $0.leading.equalTo(movieYear.snp.trailing).offset(10)
        }
        
        movieOverview.snp.makeConstraints {
            $0.top.equalTo(movieYear.snp.bottom).offset(5)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.bottom.equalToSuperview().inset(10)
        }
    }
    
    // MARK: - Custom Method
    
    internal func setCellWithValuesOf(_ movie:Movie) {
        updateUI(title: movie.title, releaseDate: movie.year, rating: movie.rate, overview: movie.overview, poster: movie.posterImage)
    }
    
    private func updateUI(title: String?, releaseDate: String?, rating: Double?, overview: String?, poster: String?) {
        movieTitle.text = title
        
        movieYear.text = convertDateFormater(releaseDate)
        
        guard let rate = rating else {return}
        movieRate.text = String(rate)
        
        movieOverview.text = overview
        
        guard let posterString = poster else {return}
        urlString = "https://image.tmdb.org/t/p/w300" + posterString
        
        guard let posterImageURL = URL(string: urlString) else {
            moviePoster.image = UIImage(named: "noImageAvailable")
            return
        }
        moviePoster.image = nil
        
        Task {
            do {
                moviePoster.image = try await fetchImage(from: posterImageURL)
            } catch {}
        }
    }
    
//    private func getImageDataFrom(url: URL) {
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            // Handle Error
//            if let error = error {
//                print("DataTask error: \(error.localizedDescription)")
//                return
//            }
//
//            guard let data = data else {
//                // Handle Empty Data
//                print("Empty Data")
//                return
//            }
//
//            DispatchQueue.main.async {
//                if let image = UIImage(data: data) {
//                    self.moviePoster.image = image
//                }
//            }
//        }.resume()
//    }
    
    func fetchImage(from url: URL) async throws -> UIImage {
        if #available(iOS 15.0, *) {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw FetchError.notOK }
            guard let image = UIImage(data: data) else { throw FetchError.badData }
            return image
        } else {
            throw NetworkError.versionError
        }
    }
    
    func convertDateFormater(_ date: String?) -> String {
        var fixDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let originalDate = date {
            if let newDate = dateFormatter.date(from: originalDate) {
                dateFormatter.dateFormat = "dd.MM.yyyy"
                fixDate = dateFormatter.string(from: newDate)
            }
        }
        return fixDate
    }
}
