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
                    forCellReuseIdentifier: HistoryTableViewCell.CellIdentifier)
        $0.separatorStyle = .none
        
        $0.rowHeight = UITableView.automaticDimension
    }
    
    var answerFilterDatasource =  ExpandingTableViewCellContent()
    
//    var sendingData: [String] = [
//        """
//        고생 많았젱? 고생했다 나야 퇴근길이겠군 집 들어서가서 씻어치킨먹고싶다 케이에프씨 치킨 내일은 혼자 먹는다고 하고 앞에 치킨먹으러 가야겠다 회사앞에 있던가 없던가 기억이 잘 안나네
//        """,
//        "난 과거에서 온 00이야 오늘하루도 고생 많았젱?",
//        "난 과거에서 온 00이야 오늘하루도 고생 많았젱?",
//        "난 과거에서 온 00이야 오늘하루도 고생 많았젱?",
//        """
//        고생 많았젱? 고생했다 나야 퇴근길이겠군 집 들어서가서 씻어치킨먹고싶다 케이에프씨 치킨 내일은 혼자 먹는다고 하고 앞에 치킨먹으러 가야겠다 회사앞에 있던가 없던가 기억이 잘 안나네
//        """]
    
    var sendingData: [String] = [
        "고생 많았젱? 고생했다 나야 퇴근길이겠군 집 들\n어서가서 씻어치킨먹고싶다 케이에프씨 치킨 내\n일은 혼자 먹는다고 하고 앞에 치킨먹으러 가야겠\n다 회사앞에 있던가 없던가 기억이 잘 안나네",
        "난 과거에서 온 00이야 오늘하루도 고생 많았젱?",
        "난 과거에서 온 00이야 오늘하루도 고생 많았젱?"
    ]
    
    var completeData: [String] = [
        """
        고생 많았젱? 고생했다 나야 퇴근길이겠군 집 들어서가서 씻어치킨먹고싶다 케이에프씨 치킨 내일은 혼자 먹는다고 하고 앞에 치킨먹으러 가야겠다 회사앞에 있던가 없던가 기억이 잘 안나네
        """,
        "난 과거에서 온 00이야 오늘하루도 고생 많았젱?",
        """
        고생 많았젱? 고생했다 나야 퇴근길이겠군 집 들어서가서 씻어치킨먹고싶다 케이에프씨 치킨 내일은 혼자 먹는다고 하고 앞에 치킨먹으러 가야겠다 회사앞에 있던가 없던가 기억이 잘 안나네
        """]
    
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
        let content = answerFilterDatasource
        content.expanded.toggle()
        
        historyTableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let resend = UIContextualAction(style: .normal, title: "재전송") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("수정")
            success(true)
        }
        resend.backgroundColor = .systemMint
        resend.image = UIImage(named: "ic_rt")
        
        let cancel = UIContextualAction(style: .normal, title: "예약 취소") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("예약 취소")
            success(true)
        }
        cancel.backgroundColor = .systemPink
        
        cancel.image = UIImage(named: "ic_trash")
        
        let delete = UIContextualAction(style: .normal, title: "삭제") { (UIContextualAction, UIView, success: @escaping (Bool) -> Void) in
            print("삭제")
            success(true)
        }
        delete.backgroundColor = .systemPink
        delete.image = UIImage(named: "ic_trash")
        
        if indexPath.section == 0 {
            return UISwipeActionsConfiguration(actions:[cancel])
        } else {
            return UISwipeActionsConfiguration(actions:[delete, resend])
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.CellIdentifier) as? HistoryTableViewCell else { return UITableViewCell() }
            cell.initCell(isClicked: answerFilterDatasource)
            cell.selectionStyle = .none
            cell.dateLabelColor = .systemMint
            cell.setData(sendingData[indexPath.row])
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.CellIdentifier) as? HistoryTableViewCell else { return UITableViewCell() }
            cell.initCell(isClicked: answerFilterDatasource)
            cell.selectionStyle = .none
            cell.dateLabelColor = .gray
            cell.setData(completeData[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
}
