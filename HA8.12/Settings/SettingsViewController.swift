//
//  SettingsViewController.swift
//  HA8.12
//
//  Created by Maksat Edil on 10/12/23.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController{
    
    let noteDataManager  = NoteDataManager.shared
    
    private var settings: [Setting] = [Setting(title: "Темная тема", type: .configure), Setting(title: "Выбрать язык", type: .none), Setting(title: "Очистить данные", type: .none)]
    
    
    private lazy var settingsTableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
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
extension SettingsViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch  indexPath.row {
        case 0:
            ()
        case 1:
            let languageViewController = LanguageViewController()
            if let bottomSheet = languageViewController.sheetPresentationController{
                bottomSheet.detents = [.medium()]
            }
            present(languageViewController, animated: true)
            ()
        case 2:
            let alert = UIAlertController(title: "Удаление", message: "Вы уверены, что хотите удалить?", preferredStyle: .alert)
            let actionAccept = UIAlertAction(title: "Да", style: .cancel) { action in
                self.noteDataManager.deleteNotes()
            }
            let actionNo = UIAlertAction(title: "Нет", style: .default) { action in
                
            }
            alert.addAction(actionAccept)
            alert.addAction(actionNo)
            present(alert, animated: true)
            ()
        default:
            ()
            
        }

       
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
