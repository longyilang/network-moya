//
//  TestTableViewCell.swift
//  greeTest
//
//  Created by mac on 2021/10/16.
//

import UIKit

class TestTableViewCell: UITableViewCell {
    // MARK: - Public Property
    var model: TestTwoModel? {
        didSet {
            titleLabel.text = model?.area
            temperatureLabel.text = (model?.day_air_temperature)! + "度"
            daytimeLabel.text = "日期:" + (model?.daytime)!
        }
    }
    
    // MARK: - Private Property
    // 城市
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    // 温度
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    // 日期
    private lazy var daytimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
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
extension TestTableViewCell {
    // 设置UI
    private func setUI() {
        selectionStyle = .none
        let nextIcon = UIImageView(image: UIImage(named: "setting_next"))
        contentView.addSubview(nextIcon)
        contentView.addSubview(titleLabel)
        contentView.addSubview(temperatureLabel)
        contentView.addSubview(daytimeLabel)
        nextIcon.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 12, height: 12))
            make.right.equalTo(-12)
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.centerY.equalToSuperview()
        }
        temperatureLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp_right).offset(30)
            make.centerY.equalToSuperview()
        }
        daytimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(temperatureLabel.snp_right).offset(30)
            make.centerY.equalToSuperview()
        }
    }
}
