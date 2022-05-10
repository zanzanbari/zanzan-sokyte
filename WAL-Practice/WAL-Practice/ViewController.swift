//
//  ViewController.swift
//  WAL-Practice
//
//  Created by 소연 on 2022/05/01.
//

import UIKit

import SnapKit
import Then

final class ViewController: UIViewController {
    
    // MARK: - Properties
    
    private var walImageView = UIImageView().then {
        $0.backgroundColor = .yellow
    }
    
    private var contentLabel = UILabel().then {
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.isHidden = true
    }
    
    private var walStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.alignment = .center
        $0.spacing = 9
    }
    
    private var dataCount: Int = 0
    private var dataList = [MainData]()
    
    private lazy var itemViews = [DefaultView]()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        DispatchQueue.main.async {
            self.getData()
            if self.dataCount == 1 {
                self.walStackView.snp.updateConstraints {
                    $0.leading.trailing.equalToSuperview().inset(139)
                }
            } else if self.dataCount == 2 {
                self.walStackView.snp.updateConstraints {
                    $0.leading.trailing.equalToSuperview().inset(86)
                }
            } else if self.dataCount == 3 {
                self.walStackView.snp.updateConstraints {
                    $0.leading.trailing.equalToSuperview().inset(32)
                }
            } else if self.dataCount == 4 {
                self.walStackView.snp.updateConstraints {
                    $0.leading.trailing.equalToSuperview().inset(20)
                }
            }
        }
    }

    // MARK: - Init UI
    
    private func configUI() {
        view.backgroundColor = .white
    }

    private func setLayout() {
        view.addSubview(walImageView)
        view.addSubview(contentLabel)
        view.addSubview(walStackView)
        
        walImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(300)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(188)
            $0.height.equalTo(103)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(walImageView.snp.bottom).offset(36)
            $0.leading.trailing.equalToSuperview().inset(30)
        }
        
        walStackView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(41)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(73)
        }
    }

    // MARK: - Custom Method
    
    private func load() -> Data? {
        let fileNm: String = "Main"
        let extensionType = "json"
        guard let fileLocation = Bundle.main.url(forResource: fileNm, withExtension: extensionType) else { return nil }
        
        do {
            let data = try Data(contentsOf: fileLocation)
            return data
        } catch {
            print("파일 로드 실패")
            return nil
        }
    }
}

// MARK: - Custom Delegate

extension ViewController: DefaultViewDelegate {
    func touchUpView(content: String, index: Int) {
        contentLabel.text = content
        contentLabel.isHidden.toggle()
    }
}

// MARK: - Network

extension ViewController {
    private func getData() {
        guard
            let jsonData = self.load(),
            let response = try? JSONDecoder().decode(MainResponse.self, from: jsonData)
        else { return }

        dataCount = response.data.count
        dataList = response.data
        
        itemViews = dataList.map { data in
            switch data.type {
            case "아침":
                let view = DefaultView()
                view.content = data.content
                view.imageName = "orange"
                view.delegate = self
                view.canOpen = data.canOpen
                return view
            case "점심":
                let view = DefaultView()
                view.content = data.content
                view.imageName = "orange"
                view.delegate = self
                view.canOpen = data.canOpen
                return view
            case "저녁":
                let view = DefaultView()
                view.content = data.content
                view.imageName = "gray"
                view.delegate = self
                view.canOpen = data.canOpen
                return view
            case "스페셜":
                let view = DefaultView()
                view.content = data.content
                view.imageName = "gray"
                view.delegate = self
                view.canOpen = data.canOpen
                return view
            default:
                return DefaultView()
            }
        }
        
        for view in itemViews {
            walStackView.addArrangedSubview(view)
        }
        
        for i in 0...itemViews.count - 1 {
            itemViews[i].index = i
        }
    }
}

