//
//  SettingCell.swift
//  HA8.12
//
//  Created by Maksat Edil on 10/12/23.
//

import Foundation
import UIKit

protocol SettingCellDelegate: AnyObject{
    func didSwitchOn(isOn:Bool)
}

class SettingCell: UITableViewCell{
    
    static let reuseId  = "setting_cell"
    
    var delegate: SettingCellDelegate?
    
    private lazy var settingTitle: UILabel = {
        let view = UILabel()
        return view
    }()
    
    private lazy var settingSwitch: UISwitch = {
        let view = UISwitch()
        view.isHidden = true
        view.addTarget(self, action: #selector(switchOnOff), for: .valueChanged)
        view.isOn = UserDefaults.standard.bool(forKey: "theme")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(title: String, type: SettingType){
        settingTitle.text = title
        if type == .configure{
            settingSwitch.isHidden = false
        } else {
            settingSwitch.isHidden = true
        }
        if UserDefaults.standard.bool(forKey: "theme") == true {
            settingSwitch.isOn = true
        }else{
            settingSwitch.isOn = false 
        }
        
    }
    
    @objc private func switchOnOff(){
        delegate?.didSwitchOn(isOn: settingSwitch.isOn)
    }
    
    private func setupConstraints(){
        contentView.addSubview(settingTitle)
        settingTitle.translatesAutoresizingMaskIntoConstraints = false
        settingTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        settingTitle.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        
        
        contentView.addSubview(settingSwitch)
        settingSwitch.translatesAutoresizingMaskIntoConstraints = false
        settingSwitch.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        settingSwitch.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
    }
    
    
}
