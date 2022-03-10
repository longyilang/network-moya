//
//  HelpCenterHeadView.swift
//  greeTest
//
//  Created by Gree on 2021/10/20.
//

import UIKit

class HelpCenterHeadView: UITableViewHeaderFooterView {

    var model: HelpCenterModel? {
        didSet {
            titleLabel.text = model?.groupTitle
        }
    }
    
    // 组标题
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.top.equalTo(18)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
