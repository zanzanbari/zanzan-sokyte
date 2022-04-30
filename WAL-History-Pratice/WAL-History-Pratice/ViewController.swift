//
//  ViewController.swift
//  WAL-History-Pratice
//
//  Created by 소연 on 2022/04/27.
//

import UIKit

import SnapKit
import Then

final class ViewController: UIViewController {

    // MARK: - Properties
    
    private lazy var navigationBar = UIView().then {
        $0.backgroundColor = .systemGray6
    }
    
    private lazy var historyTableView = UITableView(frame: .zero, style: .grouped).then {
        $0.backgroundColor = .clear
        
        $0.delegate = self
        $0.dataSource = self
        $0.register(HistoryTableViewCell.self,
                    forCellReuseIdentifier: HistoryTableViewCell.cellIdentifier)
        $0.separatorStyle = .none
        
        $0.rowHeight = UITableView.automaticDimension
    }
    
    var expandCellDatasource =  ExpandingTableViewCellContent()
    var showCellDatasource =  ShowingTableViewCellContent()
    
    private var sendingData = [HistoryData]()
    private var completeData = [HistoryData]()
    
    
    var swipeIndex: Int = 0
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.getHistoryData()
            self.historyTableView.reloadData()
        }
        configUI()
        setLayout()
        setTableView()
    }
    
    // MARK: - Init UI
    
    private func configUI() {
        view.backgroundColor = .white
    }
    
    private func setLayout() {
        view.addSubview(navigationBar)
        view.addSubview(historyTableView)
        
        navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        historyTableView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Custom Method

    private func setTableView() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(sender:)))
        historyTableView.addGestureRecognizer(longPress)
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
    
    // MARK: - @objc
    
    @objc private func handleLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            let touchPoint = sender.location(in: historyTableView)
            if let indexPath = historyTableView.indexPathForRow(at: touchPoint) {
                let content = expandCellDatasource
                content.expanded.toggle()
                
                let showContent = showCellDatasource
                showContent.showed.toggle()
                
                historyTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        } else {
            let touchPoint = sender.location(in: historyTableView)
            if let indexPath = historyTableView.indexPathForRow(at: touchPoint) {
//                guard let cell = historyTableView.cellForRow(at: indexPath) as? HistoryTableViewCell else { return }
                
                let content = expandCellDatasource
                content.expanded.toggle()
                
                let showContent = showCellDatasource
                showContent.showed.toggle()
                
                historyTableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 52
        case 1:
            return 70
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let header = HistorySendingHeaderView()
            header.title = "보내는 중"
            return header
        case 1:
            let header = HistoryCompleteHeaderView()
            header.title = "완료"
            return header
        default:
            return UIView()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let content = expandCellDatasource
        content.expanded.toggle()
        
        historyTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        .leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let resendAction = UIContextualAction(style: .normal, title: "재전송") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("수정")
            success(true)
        }
        
        resendAction.accessibilityFrame = CGRect(x: 0, y: 0, width: 106, height: tableView.rowHeight - 12)
        resendAction.backgroundColor = .systemMint

        if let cell = historyTableView.cellForRow(at: indexPath) as? HistoryTableViewCell {
            cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
            if cell.isExpanded {
                resendAction.image = UIImage(named: "ic_rt")
            } else {
                resendAction.image = nil
            }
        }

        let cancelAction = UIContextualAction(style: .normal, title: "예약 취소") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("예약 취소")
            success(true)
        }
        
        cancelAction.backgroundColor = .systemPink

        if let cell = historyTableView.cellForRow(at: indexPath) as? HistoryTableViewCell {
//            cell.radius = 0
            if cell.isExpanded {
                cancelAction.image = UIImage(named: "ic_trash")
            } else {
                cancelAction.image = nil
            }
        }

        let deleteAction = UIContextualAction(style: .normal, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("삭제")
            success(true)
        }
        deleteAction.backgroundColor = .systemPink

        if let cell = historyTableView.cellForRow(at: indexPath) as? HistoryTableViewCell {
            if cell.isExpanded {
                deleteAction.image = UIImage(named: "ic_trash")
            } else {
                resendAction.image = nil
            }
        }

        if indexPath.section == 0 {
            let config = UISwipeActionsConfiguration(actions: [cancelAction])
            config.performsFirstActionWithFullSwipe = false
            return config
        } else {
            return UISwipeActionsConfiguration(actions:[deleteAction, resendAction])
        }
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return sendingData.count
        case 1:
            return completeData.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.cellIdentifier) as? HistoryTableViewCell else { return UITableViewCell() }
            cell.tapCell(isTapped: expandCellDatasource)
            cell.pressCell(isPressed: showCellDatasource)
            
            cell.selectionStyle = .none
            cell.dateLabelColor = .systemMint
            cell.setData(sendingData[indexPath.row])
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.cellIdentifier) as? HistoryTableViewCell else { return UITableViewCell() }
            cell.tapCell(isTapped: expandCellDatasource)
            cell.pressCell(isPressed: showCellDatasource)
            
            cell.selectionStyle = .none
            cell.dateLabelColor = .gray
            cell.setData(completeData[indexPath.row])

            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - Network

extension ViewController {
    private func getHistoryData() {
        guard
            let jsonData = self.load(),
            let historyDataList = try? JSONDecoder().decode(HistoryResponse.self, from: jsonData)
        else { return }
        
        sendingData = historyDataList.sendingData
        completeData = historyDataList.completeData
    }
}
