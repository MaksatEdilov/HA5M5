//
//  NoteCell.swift
//  HA8.12
//
//  Created by Maksat Edil on 13/12/23.
//

import Foundation
import UIKit

class NoteCell: UICollectionViewCell{
    
    static var reuseId = "note_cell"
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(title: String){
        titleLabel.text = title
    }
    
    private func setupConstraints() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
    }
    
    
}
