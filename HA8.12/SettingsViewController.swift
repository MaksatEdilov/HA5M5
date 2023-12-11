//
//  SettingsViewController.swift
//  HA8.12
//
//  Created by Maksat Edil on 10/12/23.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController{
    
    private var settings: [Setting] = [Setting(title: "Темная тема", type: .configure), Setting(title: "Выбрать язык", type: .none)]
    
    
    private lazy var settingsTableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.register(SettingCell.self, forCellReuseIdentifier: SettingCell.reuseId)
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let isDarkTheme = UserDefaults.standard.bool(forKey: "theme")
        if isDarkTheme == true {
            overrideUserInterfaceStyle = .dark
            navigationController?.overrideUserInterfaceStyle = .dark
        }else{
            navigationController?.overrideUserInterfaceStyle = .light
            overrideUserInterfaceStyle = .light
        }
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Настройки"
        setupConstraints()

    }
    
    private func setupConstraints() {
        view.addSubview(settingsTableView)
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        settingsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        settingsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        settingsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        settingsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension SettingsViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseId, for: indexPath)
        as! SettingCell
        let settingItem = settings[indexPath.row]
        cell.setup(title: settingItem.title, type: settingItem.type)
        cell.delegate = self
        return cell
    }
    
    
}
extension SettingsViewController: SettingCellDelegate{
    func didSwitchOn(isOn: Bool) {
        UserDefaults.standard.setValue(isOn, forKey: "theme")
        if isOn == true {
            navigationController?.overrideUserInterfaceStyle = .dark
            overrideUserInterfaceStyle = .dark
        }else{
            navigationController?.overrideUserInterfaceStyle = .light
            overrideUserInterfaceStyle = .light
        }
    }
    
    
}
