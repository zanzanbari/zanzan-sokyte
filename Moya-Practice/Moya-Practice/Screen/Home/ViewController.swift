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
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
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
    private func getWalHistory() {
        
    }
}

