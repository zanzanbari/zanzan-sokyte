//
//  MainViewController.swift
//  Auth-Practice
//
//  Created by soyeon on 2022/02/09.
//

import UIKit

import SnapKit
import Then

final class MainViewController: UIViewController {

    // MARK: - Properties
    
    private var mainLabel = UILabel().then {
        $0.text = "라벨입니다."
        $0.textColor = .black
        $0.font = .PretendardM(size: 15)
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setupLayout()
    }
    
    // MARK: - InitUI
    
    private func configUI() {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        view.backgroundColor = .white
        
        if let name = UserDefaults.standard.value(forKey: "name") {
            mainLabel.text = "\(name)님, 환영합니다!"
        }
    }
    
    private func setupLayout() {
        view.addSubview(mainLabel)
        
        mainLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
