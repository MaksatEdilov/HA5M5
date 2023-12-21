//
//  LanguageCell.swift
//  HA8.12
//
//  Created by Maksat Edil on 21/12/23.
//

import Foundation
import UIKit

class LanguageCell: UITableViewCell {
    
    static var reuseId = "language_cell"
    
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.font = UIFont.systemFont(ofSize: 17)
        return view
        
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemGray6
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(language: Language) {
        iconImageView.image = UIImage(named: language.image)
        titleLabel.text = language.title
    }
    
    private func setupConstraints(){
        contentView.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
