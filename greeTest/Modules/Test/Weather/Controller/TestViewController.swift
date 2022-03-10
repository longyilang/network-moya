//
//  TestViewController.swift
//  greeTest
//
//  Created by mac on 2021/10/16.
//

import UIKit
import SnapKit

class TestViewController: UIViewController {
    
    
    /// 主列表
    private lazy var mainTableView: TestTableView = {
        let tableView = TestTableView(frame: .zero, style: .plain)
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}


// MARK: - Private Function
extension TestViewController {
    
    /// 配置UI
    private func setUI() {
        title = "北京天气"
        
        view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    
    private func loadData() {
        
        TestViewModel.requestWeatherData(area: "北京", areaID: "110000") { (model) in
            self.mainTableView.dataList = model.dayList
        }
        
        
    }
}
