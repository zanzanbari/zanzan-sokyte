//
//  TaxiMapLocationBottomView.swift
//  KakaoT-Practice
//
//  Created by 소연 on 2022/03/07.
//

import UIKit

import SnapKit
import Then

final class TaxiMapLocationView: UIView {

    private var hereTextField = KakakoTTextField().then {
        $0.textFieldType = .here
        $0.isActivated = false
        $0.text = "현위치: 애오개역 5호선 1번 출구"
        $0.textColor = .black100
    }
    
    private var lineView = UIView().then {
        $0.backgroundColor = .gray400
    }
    
    private var destinationTextField = KakakoTTextField().then {
        $0.textFieldType = .destination
        $0.isActivated = false
        $0.setPlaceholder(placeholder: "어디로 갈까요?")
    }
    
    private var destinationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = .zero
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .clear
            $0.isScrollEnabled = true
            $0.bounces = false
            $0.isPagingEnabled = false
            $0.showsHorizontalScrollIndicator = false
            $0.register(TaxiLocationCollectionViewCell.self, forCellWithReuseIdentifier: TaxiLocationCollectionViewCell.CellIdentifier)
        }
    }()
    
    private var destinationList: [String] = ["집", "회사"]

    init() {
        super.init(frame: .zero)
        configUI()
        setLayout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        backgroundColor = .white
        
        [hereTextField, destinationTextField].forEach {
            $0.isUserInteractionEnabled = false
        }
        
        [hereTextField, lineView, destinationTextField, destinationCollectionView].forEach {
            addSubview($0)
        }
    }
    
    private func setLayout() {
        hereTextField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.top.equalToSuperview().inset(19)
            $0.height.equalTo(48)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(hereTextField.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(1)
        }
        
        destinationTextField.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.height.equalTo(48)
        }
        
        destinationCollectionView.snp.makeConstraints {
            $0.top.equalTo(destinationTextField.snp.bottom).offset(3)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
    
    private func bind() {
        destinationCollectionView.delegate = self
        destinationCollectionView.dataSource = self
    }
    
    private func calculateCellWidth(text: String) -> CGFloat {
        let label = UILabel()
        label.text = text
        label.font = KDSFont.body6
        label.sizeToFit()
        return label.frame.width + 12 + 24 + 6 + 15
    }
}

// MARK: - UICollectionView Delegate

extension TaxiMapLocationView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = calculateCellWidth(text: destinationList[indexPath.item])
        let cellHeight = collectionView.frame.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
}

// MARK: - UICollectionView DataSource

extension TaxiMapLocationView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return destinationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaxiLocationCollectionViewCell.CellIdentifier, for: indexPath) as? TaxiLocationCollectionViewCell else { return UICollectionViewCell() }
        if indexPath.item == 0 {
            cell.setCell(type: .home)
        } else if indexPath.item == 1 {
            cell.setCell(type: .company)
        } else {
            cell.setCell(type: .none)
        }
        return cell
    }
}
