//
//  OnBoardingViewController.swift
//  HA8.12
//
//  Created by Maksat Edil on 11/12/23.
//

import Foundation
import UIKit

class OnBoardingViewController: UIViewController {
    
    private let titles: [String] = ["Welcome to The Note", "Set Up Your Profile", "Dive into The Note"]
    private let labels: [String] = [
        "Welcome to The Note  – your new companion \nfor tasks, goals, health – all in one place. \nLet's get started!",
        "Now that you're with us, let's get to know each other better. Fill out your profile, share your interests, and set your goals.",
        "You're fully equipped to dive into the world \nof The Note. Remember, we're here to assist \nyou every step of the way. Ready to start? \nLet's go!"]
        private let images: [String] = ["image1","image2","image3"]
    
    
    private lazy var onBoardingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(OnBoardingCell.self, forCellWithReuseIdentifier: OnBoardingCell.reuseId)
        view.dataSource = self
        view.delegate = self
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        return view 
    }()
    
    private lazy var skipButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Skip", for: .normal)
        view.setTitleColor(UIColor(red: 1, green: 0.237, blue: 0.237, alpha: 1), for: .normal)
        view.backgroundColor = .clear
        view.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        return view
    }()
    
    
    private lazy var nextButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Next", for: .normal)
        view.setTitleColor(.white, for: .normal)
        view.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
        view.backgroundColor = .red
        view.layer.cornerRadius = 20
        return view
    }()
    
    
    private lazy var pageControl: UIPageControl = {
        let view = UIPageControl()
        view.numberOfPages = 3
        view.currentPage = 0
        view.currentPageIndicatorTintColor = .systemGray
        view.pageIndicatorTintColor = .gray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        
        let settingsBarButton = UIBarButtonItem(title: "Skip", style: .plain, target: self, action: #selector(skipButtonTapped))
        navigationItem.rightBarButtonItem = settingsBarButton
    }
    
    @objc private func leftButtonTapped(){
        let notesViewController = NotesViewController()
        navigationController?.pushViewController(notesViewController, animated: true)
        
    }
    
    @objc private func rightButtonTapped(){
        let currentPage = pageControl.currentPage
        let nextPage = currentPage + 1
        
        onBoardingCollectionView.isPagingEnabled = false
        
        if nextPage != 3 {
            onBoardingCollectionView.scrollToItem(at: [0, nextPage], at: .right, animated: true)
            
        }else {
            let notesViewController = NotesViewController()
            navigationController?.pushViewController(notesViewController, animated: true)
        }
            
        onBoardingCollectionView.isPagingEnabled = true

    }
    
    @objc private func skipButtonTapped(){
    let notesViewController = NotesViewController()
        navigationController?.pushViewController(notesViewController, animated: true)
    }
    
    private func setupConstraints(){
        view.addSubview(onBoardingCollectionView)
        onBoardingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        onBoardingCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        onBoardingCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        onBoardingCollectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        onBoardingCollectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -290).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(skipButton)
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: -10).isActive = true
        skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -130).isActive = true
        skipButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        skipButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: 10).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -130).isActive = true
        nextButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        nextButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    
}

extension OnBoardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCell.reuseId, for: indexPath)
        as! OnBoardingCell
        cell.setup(title: titles[indexPath.row], label: labels[indexPath.row], imageName: images[indexPath.row])
        return cell
    }
    
    
}
extension OnBoardingViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        if pageWidth > 0 {
            let page: CGFloat = scrollView.contentOffset.x / pageWidth
            let roundedPage = round(Double(page))
            pageControl.currentPage = Int(roundedPage)
            
            if roundedPage == 2 {
                UserDefaults.standard.setValue(true, forKey: "isOnBoardShown")
            }
        }else{
            print("Disable")
        }
        
    }
}
