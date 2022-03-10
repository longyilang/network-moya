//
//  ViewController.swift
//  greeTest
//
//  Created by mac on 2021/10/16.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    private lazy var helpCenterBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle("帮助测试", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.layer.cornerRadius = 25
        btn.backgroundColor = .green
        btn.addTarget(self, action: #selector(helpCenterClick), for: .touchUpInside)
        return btn
    }()

    private lazy var weatherBtn: UIButton = {
        var btn = UIButton()
        btn.setTitle("天气测试", for: .normal)
        btn.layer.cornerRadius = 25
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .green
        btn.addTarget(self, action: #selector(weatherClick), for: .touchUpInside)
        return btn
    }()
    

}

// MARK: - UI
extension ViewController {
    
    func setUI() {
        view.addSubview(weatherBtn)
        view.addSubview(helpCenterBtn)
        helpCenterBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 50))
        }
        weatherBtn.snp.makeConstraints { make in
            make.top.equalTo(helpCenterBtn.snp_bottom).offset(30)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 50))
        }
        
        
    }
}

// MARK: - 事件
extension ViewController {
    
    //帮助测试
    @objc func helpCenterClick() {
        self.navigationController?.pushViewController(HelpCenterViewController(), animated: true)
    }
    
    //天气测试
    @objc func weatherClick() {
        self.navigationController?.pushViewController(TestViewController(), animated: true)
    }
}

