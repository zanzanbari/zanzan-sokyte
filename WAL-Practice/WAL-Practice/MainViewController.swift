//
//  MainViewController.swift
//  WAL-Practice
//
//  Created by 소연 on 2022/05/07.
//

import UIKit

import SnapKit
import Then

final class MainViewController: UIViewController {

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
    
    private var walCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = .zero
        
        return UICollectionView(frame: .zero, collectionViewLayout: layout).then {
            $0.backgroundColor = .clear
            $0.isScrollEnabled = false
        }
    }()
    
    private var dataCount: Int = 0
    private var dataList = [MainData]()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setLayout()
        setCollectionView()
        DispatchQueue.main.async {
            self.getData()
            self.walCollectionView.reloadData()
            if self.dataCount == 1 {
                self.walCollectionView.snp.updateConstraints {
                    $0.leading.trailing.equalToSuperview().inset(139)
                }
            } else if self.dataCount == 2 {
                self.walCollectionView.snp.updateConstraints {
                    $0.leading.trailing.equalToSuperview().inset(86)
                }
            } else if self.dataCount == 3 {
                self.walCollectionView.snp.updateConstraints {
                    $0.leading.trailing.equalToSuperview().inset(32)
                }
            } else if self.dataCount == 4 {
                self.walCollectionView.snp.updateConstraints {
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
        view.addSubview(walCollectionView)
        
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
        
        walCollectionView.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(41)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(73)
        }
    }
    
    // MARK: - Custom Method
    
    private func setCollectionView() {
        walCollectionView.delegate = self
        walCollectionView.dataSource = self
        
        walCollectionView.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.cellIdentifier)
    }
    
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

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = CGFloat(77)
        let cellHeight = collectionView.frame.height
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ItemCell else {
            return true
        }
        if cell.isSelected {
            contentLabel.isHidden = true
            collectionView.deselectItem(at: indexPath, animated: false)
            return false
        } else {
            contentLabel.isHidden = false
            contentLabel.text = dataList[indexPath.item].content
            return true
        }
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.cellIdentifier, for: indexPath) as? ItemCell else { return UICollectionViewCell() }
        cell.setData(type: dataList[indexPath.item].type, content: dataList[indexPath.item].content, canOpen: dataList[indexPath.item].canOpen)
        
        if dataList[indexPath.item].canOpen {
            cell.isUserInteractionEnabled = true
        } else {
            cell.isUserInteractionEnabled = false
        }

        return cell
    }
}

// MARK: - Network

extension MainViewController {
    private func getData() {
        guard
            let jsonData = self.load(),
            let response = try? JSONDecoder().decode(MainResponse.self, from: jsonData)
        else { return }

        dataCount = response.data.count
        dataList = response.data
    }
}

// MARK: - ItemCell

protocol ItemCellDelegate: AnyObject {
    func selectedCell(content: String)
}

final class ItemCell: UICollectionViewCell {
    static var cellIdentifier: String { return String(describing: self) }
    
    private var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    var content: String = ""
    
    weak var delegate: ItemCellDelegate?
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            delegate?.selectedCell(content: content)
            contentView.layer.borderColor = isSelected ? UIColor.orange.cgColor : UIColor.systemGray5.cgColor
        }
    }
    
    private func configUI() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray5.cgColor
    }
    
    private func setLayout() {
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(16)
            $0.leading.trailing.equalToSuperview().inset(18)
        }
    }
    
    internal func setData(type: String, content: String, canOpen: Bool) {
        switch type {
        case "스페셜":
            imageView.image = UIImage(named: " ")
        default:
            imageView.image = UIImage(named: "gray")
        }
        
        if canOpen {
            imageView.image = UIImage(named: "orange")
        } else {
            imageView.image = UIImage(named: "gray")
        }
        
        self.content = content
    }
}

