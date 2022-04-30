//
//  HistoryViewController.swift
//  WAL-History-Pratice
//
//  Created by 소연 on 2022/04/30.
//

import UIKit

import SnapKit
import Then

final class HistoryViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var navigationBar = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    private lazy var historyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = .zero
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .clear
            $0.isScrollEnabled = true
            $0.showsHorizontalScrollIndicator = false
            
            $0.register(HistoryCollectionViewCell.self, forCellWithReuseIdentifier: HistoryCollectionViewCell.cellIdentifier)
            
            $0.register(HistoryCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HistoryCollectionReusableView.identifier)
            $0.register(HistoryCompleteCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HistoryCompleteCollectionReusableView.identifier)
        }
    }()
    
    private var sendingData = [HistoryData]()
    private var completeData = [HistoryData]()
    
    var expandCellDatasource =  ExpandingTableViewCellContent()
    var expandedHeight : CGFloat = 200
    var notExpandedHeight : CGFloat = 50
    
    var sizingCell = SizingCell()

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.getHistoryData()
            self.historyCollectionView.reloadData()
        }
        configUI()
        setLayout()
        setCollectionView()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        
    }
    
    private func setLayout() {
        view.addSubview(navigationBar)
        view.addSubview(historyCollectionView)
        
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        historyCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method
    
    private func setCollectionView() {
        historyCollectionView.delegate = self
        historyCollectionView.dataSource = self
    }
    
    private func load() -> Data? {
        let fileNm: String = "HistoryDummyData"
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

// MARK: - UICollectionView Protocol

extension HistoryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            self.historyCollectionView.reloadItems(at: [indexPath])
        }, completion: { success in
            print("success")
        })
    }
}

extension HistoryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = collectionView.frame.width - 20 - 20
        let cellHeight = CGFloat(116)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: collectionView.frame.width, height: 55)
        } else {
            return CGSize(width: collectionView.frame.width, height: 60)
        }
    }
}

extension HistoryViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return sendingData.count
        case 1:
            return completeData.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCollectionViewCell.cellIdentifier, for: indexPath) as? HistoryCollectionViewCell else { return UICollectionViewCell() }
            cell.setData(sendingData[indexPath.item])
            cell.dateLabelColor = .systemMint
            cell.prepareForReuse()
            cell.contentView.layoutSubviews()
            cell.contentView.layoutIfNeeded()
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HistoryCollectionViewCell.cellIdentifier, for: indexPath) as? HistoryCollectionViewCell else { return UICollectionViewCell() }
            cell.setData(completeData[indexPath.item])
            cell.dateLabelColor = .gray
            cell.prepareForReuse()
            cell.contentView.layoutSubviews()
            cell.contentView.layoutIfNeeded()
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HistoryCollectionReusableView.identifier, for: indexPath) as? HistoryCollectionReusableView else { return UICollectionReusableView() }
            header.title = "보내는 중"
            return header
        case 1:
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HistoryCompleteCollectionReusableView.identifier, for: indexPath) as? HistoryCompleteCollectionReusableView else { return UICollectionReusableView() }
            header.title = "완료"
            return header
        default:
            return UICollectionReusableView()
        }
    }
}

// MARK: - Network

extension HistoryViewController {
    private func getHistoryData() {
        guard
            let jsonData = self.load(),
            let historyDataList = try? JSONDecoder().decode(HistoryResponse.self, from: jsonData)
        else { return }
        
        sendingData = historyDataList.sendingData
        completeData = historyDataList.completeData
    }
}
