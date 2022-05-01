//
//  ViewController.swift
//  WAL-History-Practice
//
//  Created by 소연 on 2022/05/01.
//

import UIKit

import SnapKit
import Then

final class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private var navigationBar = UIView().then {
        $0.backgroundColor = .systemGray
    }
    
    private var historyTableView = UITableView().then {
        $0.backgroundColor = .clear
    }

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
    }

    // MARK: - Custom Method
    
    private func configUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        
    }
}

