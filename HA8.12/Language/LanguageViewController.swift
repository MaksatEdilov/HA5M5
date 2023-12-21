//
//  LanguageViewController.swift
//  HA8.12
//
//  Created by Maksat Edil on 21/12/23.
//

import Foundation
import UIKit

class LanguageViewController: UIViewController{
    
    private var languages: [Language] = [Language(image:"", title: "Кыргызча"), Language(image: "", title: "Русский"),Language(image:"", title: "English")]
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.text = "Выберите язык"
        view.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return view
    }()
    
    private lazy var languagesTableView: UITableView = {
        let view = UITableView()
        view.dataSource = self
        view.delegate = self
        view.layer.cornerRadius = 15
        view.register(LanguageCell.self, forCellReuseIdentifier: LanguageCell.reuseId)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstraints()
    }
    
    private func setupConstraints(){
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 55).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14).isActive = true
        
        view.addSubview(languagesTableView)
        languagesTableView.translatesAutoresizingMaskIntoConstraints = false
        languagesTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 36).isActive = true
        languagesTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        languagesTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        languagesTableView.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
}
extension LanguageViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LanguageCell.reuseId, for: indexPath) as!
        LanguageCell
        cell.setup(language: languages[indexPath.row])
        return cell
    }
    
    
}
extension LanguageViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
