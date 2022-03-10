//
//  HelpCenterTableViewCell.swift
//  greeTest
//
//  Created by Gree on 2021/10/20.
//

import UIKit
import SnapKit

class HelpCenterTableViewCell: UITableViewCell {

    // MARK: - Public Property
    var model: HelpCenterTwoModel? {
        didSet {
            titleLabel.text = model?.pageTitleOne
        }
    }
    var isHiddenLine: Bool {
        get {
            line.isHidden
        }
        set {
            line.isHidden = newValue
        }
    }
    
    // MARK: - Private Property
    // 单元格label
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    // 分割线
    private lazy var line: UIView = {
        let line = UIView()
        line.backgroundColor = .systemGray5
        return line
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Function
extension HelpCenterTableViewCell {
    // 设置UI
    private func setUI() {
        selectionStyle = .none
        let nextIcon = UIImageView(image: UIImage(named: "setting_next"))
        contentView.addSubview(nextIcon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(line)
        nextIcon.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 12, height: 12))
            make.right.equalTo(-12)
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.centerY.equalToSuperview()
        }
        line.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.bottom.equalToSuperview()
        }
    }
}
