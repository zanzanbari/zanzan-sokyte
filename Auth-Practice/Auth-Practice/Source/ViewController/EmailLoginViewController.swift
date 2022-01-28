//
//  ViewController.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/01/29.
//

import UIKit

import SnapKit
import Then

import Moya

final class EmailLoginViewController: UIViewController {

    // MARK: - Properties
    
    private var backButton = UIButton().then {
        $0.setTitle("", for: .normal)
        $0.setImage(UIImage(named: "btnBack"), for: .normal)
    }
    
    private var emailLoginLabel = UILabel().then {
        $0.text = "이메일 로그인"
        $0.textColor = .darkGray
        $0.font = .Pretendard(type: .medium, size: 23)
    }
    
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        view.backgroundColor = .white
    }
    
    private func setupLayout() {
        
    }
    
    // MARK: - Custom Method
}

