//
//  OnBoardingCell.swift
//  HA8.12
//
//  Created by Maksat Edil on 11/12/23.
//

import Foundation
import UIKit

class OnBoardingCell: UICollectionViewCell{
    
    static var reuseId = "onboarding_cell"
    
    private lazy var GreetingImg: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "image1")
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var titleLbl: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 22, weight: .semibold)
        return view
    }()
    
    private lazy var secondLbl: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14, weight: .regular)
        view.textColor = .gray
        view.numberOfLines = 4
        return view
    }()
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(title: String, label: String, imageName: String) {
        titleLbl.text = title
        secondLbl.text = label
        GreetingImg.image = UIImage(named: imageName)
        
        
    }
    
    private func setupConstraints() {
        
        contentView.addSubview(titleLbl)
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 328).isActive = true
        titleLbl.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 76).isActive = true

        
        contentView.addSubview(secondLbl)
        secondLbl.translatesAutoresizingMaskIntoConstraints = false
        secondLbl.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 16).isActive = true
        secondLbl.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        secondLbl.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        contentView.addSubview(GreetingImg)
        GreetingImg.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 136).isActive = true 
        GreetingImg.heightAnchor.constraint(equalToConstant: 140).isActive = true

        
    }
}

