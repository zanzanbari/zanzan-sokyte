//
//  ViewController.swift
//  Moya-Practice
//
//  Created by 소연 on 2022/06/14.
//

import UIKit

import SnapKit
import Then

import Moya

final class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var serverMovies: MovieDataModel?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        getMovieListAPI(page: 1)
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        
    }
    
    // MARK: - Custom Method
}

// MARK: - Network

extension ViewController {
    private func getMovieListAPI(page: Int) {
        let param: MovieRequest = MovieRequest.init(Const.apiKey, "ko", page)
        
        MovieAPI.shared.movieList(param: param) { response in
            switch response {
            case .success(let data):
                dump(data)
                if let movies = data as? MovieDataModel {
                    self.serverMovies = movies
                    dump(self.serverMovies)
                }
            case .requestErr(let message):
                print("latestPhotosWithAPI - requestErr: \(message)")
            case .pathErr:
                print("latestPhotosWithAPI - pathErr")
            case .serverErr:
                print("latestPhotosWithAPI - serverErr")
            case .networkFail:
                print("latestPhotosWithAPI - networkFail")
            }
        }
    }
}

