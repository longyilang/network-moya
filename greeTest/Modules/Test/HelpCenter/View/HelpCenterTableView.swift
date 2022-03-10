//
//  HelpCenterTableView.swift
//  greeTest
//
//  Created by Gree on 2021/10/20.
//

import UIKit

class HelpCenterTableView: UITableView {

    static let selsetActionKey = "selsetActionKey"

    var dataList: [HelpCenterModel] = [] {
        didSet {
            reloadData()
        }
    }
    
    private static let cellIndentifier: String = "HelpCenterCell"
    private static let headIdentifier: String = "HelpCenterHeadView"
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .grouped)
        separatorStyle = .none
        delegate = self
        dataSource = self
        register(HelpCenterTableViewCell.self, forCellReuseIdentifier: HelpCenterTableView.cellIndentifier)
        register(HelpCenterHeadView.self, forHeaderFooterViewReuseIdentifier: HelpCenterTableView.headIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - TableViewDelegate,TableViewDataSource
extension HelpCenterTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("你点击了：\(dataList[indexPath.section].categoryList[indexPath.row].pageTitleOne)")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HelpCenterTableViewCell = tableView.dequeueReusableCell(withIdentifier: HelpCenterTableView.cellIndentifier) as! HelpCenterTableViewCell
        cell.model = dataList[indexPath.section].categoryList[indexPath.row]
        if indexPath.row ==  dataList[indexPath.section].categoryList.count - 1 {
            cell.isHiddenLine = true
        } else {
            cell.isHiddenLine = false
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataList[section].categoryList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dataList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        48.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50.0
    }
    
    // 分区头
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView: HelpCenterHeadView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HelpCenterTableView.headIdentifier) as! HelpCenterHeadView
        headView.model = dataList[section]
        return headView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.0
    }

}
