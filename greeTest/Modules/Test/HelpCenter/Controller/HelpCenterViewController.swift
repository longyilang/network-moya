//
//  HelpCenterViewController.swift
//  greeTest
//
//  Created by Gree on 2021/10/20.
//

import UIKit
import SnapKit

class HelpCenterViewController: UIViewController {

    
    /// 主列表
    private lazy var mainTableView: HelpCenterTableView = {
        let tableView = HelpCenterTableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}


// MARK: - Private Function
extension HelpCenterViewController {
    /// 配置UI
    private func setUI() {
        title = "帮助中心"
        
        view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    private func loadData() {
        
        HelpCenterViewModel.requestPageList { [weak self] (models) in
            self?.mainTableView.dataList = models
        }
        
        
    }

}
