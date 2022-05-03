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
        $0.spacing = 10
        $0.backgroundColor = .blue
    }
    
    // MARK: - Properties
    
    enum MainDataType {
        case morning
        case lunch
        case dinner
        case special
    }
    
    struct MainData {
        var type: MainDataType
        var text: String
    }
    
//    var dataList: [MainData] = [
//        MainData(type: MainDataType.morning, text: "아침"),
//        MainData(type: MainDataType.lunch, text: "점심"),
//        MainData(type: MainDataType.dinner, text: "저녁"),
//        MainData(type: MainDataType.special, text: "왈뿡")
//    ]
    
    var dataList: [MainData] = [
        MainData(type: MainDataType.morning, text: "아침"),
        MainData(type: MainDataType.lunch, text: "점심"),
        MainData(type: MainDataType.dinner, text: "저녁")
    ]
    
//    var dataList: [MainData] = [
//        MainData(type: MainDataType.morning, text: "아침"),
//        MainData(type: MainDataType.lunch, text: "점심")
//    ]
    
//    var dataList: [MainData] = [
//        MainData(type: MainDataType.morning, text: "아침")
//    ]
    
    private lazy var itemViews: [UIView] = dataList.map { data in
        switch data.type {
        case .morning:
            let view = DefaultView()
            view.text = data.text
            return view
        case .lunch:
            let view = DefaultView()
            view.text = data.text
            return view
        case .dinner:
            let view = DefaultView()
            view.text = data.text
            return view
        case .special:
            let view = SpecialView()
            view.text = data.text
            return view
        }
    }
            

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        print(dataList.count)
        DispatchQueue.main.async {
            if self.dataList.count == 1 {
                self.walStackView.snp.updateConstraints {
                    $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(41)
                    $0.leading.trailing.equalToSuperview().inset(139)
                    $0.height.equalTo(90)
                    $0.centerX.equalToSuperview()
                }
            } else if self.dataList.count == 2 {
                self.walStackView.snp.updateConstraints {
                    $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(41)
                    $0.leading.trailing.equalToSuperview().inset(86)
                    $0.height.equalTo(90)
                    $0.centerX.equalToSuperview()
                }
            } else if self.dataList.count == 3 {
                self.walStackView.snp.updateConstraints {
                    $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(41)
                    $0.leading.trailing.equalToSuperview().inset(32)
                    $0.height.equalTo(90)
                    $0.centerX.equalToSuperview()
                }
            } else if self.dataList.count == 4 {
                self.walStackView.snp.updateConstraints {
                    $0.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(41)
                    $0.leading.trailing.equalToSuperview().inset(22)
                    $0.height.equalTo(90)
                    $0.centerX.equalToSuperview()
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
        
        for view in itemViews {
            walStackView.addArrangedSubview(view)
            view.backgroundColor = .gray
        }
        
        walImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(300)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(188)
            $0.height.equalTo(103)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(walImageView.snp.bottom).offset(36)
            $0.centerX.equalToSuperview()
        }
        
        walStackView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(41)
            $0.leading.trailing.equalToSuperview().inset(86)
            $0.height.equalTo(90)
            $0.centerX.equalToSuperview()
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

// MARK: - Network
extension ViewController {
    private func getData() {
        guard
            let jsonData = self.load(),
            let data = try? JSONDecoder().decode(MainResponse.self, from: jsonData)
        else { return }

        dump(data)
    }
}

