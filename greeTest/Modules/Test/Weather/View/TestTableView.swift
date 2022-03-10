//
//  TestTableView.swift
//  greeTest
//
//  Created by mac on 2021/10/16.
//

import UIKit

class TestTableView: UITableView {

    var dataList: [TestTwoModel] = [] {
        didSet {
            reloadData()
        }
    }
    
    private static let cellIndentifier: String = "WeatherCell"
    
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
        separatorStyle = .none
        delegate = self
        dataSource = self
        register(TestTableViewCell.self, forCellReuseIdentifier: TestTableView.cellIndentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - TableViewDelegate,TableViewDataSource
extension TestTableView: UITableViewDelegate, UITableViewDataSource {


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TestTableViewCell = tableView.dequeueReusableCell(withIdentifier: TestTableView.cellIndentifier) as! TestTableViewCell
        let model: TestTwoModel = self.dataList[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
