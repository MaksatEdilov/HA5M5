//
//  ViewController.swift
//  HA8.12
//
//  Created by Maksat Edil on 10/12/23.
//

import UIKit

class NotesViewController: UIViewController {
    
    private let noteDataManager = NoteDataManager.shared
    
    private var notes: [Note] = []
    
    private var filteredNotes: [Note] = []
    
    private var colors: [UIColor] = [.systemPink, .systemCyan, .systemOrange, .systemPurple]
    
    private lazy var noteSearchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "Поиск"
        view.searchTextField.addTarget(self, action: #selector(searchTextEditingChanged), for: .editingChanged)
        return view
    }()
    
    private lazy var notesLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "Заметки"
        view.textColor = .black
        view.font = .systemFont(ofSize: 16, weight: .regular)
        return view
    }()
    
    private lazy var notesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 8
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.register(NoteCell.self, forCellWithReuseIdentifier: NoteCell.reuseId)
        return view
    }()
    
    private lazy var addButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = .red
        view.setTitle("+", for: .normal)
        view.setTitleColor(.systemBackground, for: .normal)
        view.layer.cornerRadius = 42 / 2
        view.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
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
        
        navigationItem.hidesBackButton = true 
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.backgroundColor = .systemBackground
        
        notes = noteDataManager.fetchNotes()
        filteredNotes = notes
        notesCollectionView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        let settingsBarButton = UIBarButtonItem(image:UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsButtonTapped))
        navigationItem.rightBarButtonItem = settingsBarButton
        setupConstraints()
        
        
    }
    
    @objc private func searchTextEditingChanged(){
        filteredNotes = []
        
        guard noteSearchBar.text != nil else {
            return
        }
        if noteSearchBar.text ?? "" == "" {
            filteredNotes = notes
        } else {
            for note in notes {
                if ((note.title?.uppercased().contains(noteSearchBar.text ?? "".uppercased())) != nil) {
                    filteredNotes.append(note)
                }
            }
        }
        notesCollectionView.reloadData()
    }
    @objc private func settingsButtonTapped() {
        let settingsVC = SettingsViewController()
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    @objc private func addButtonTapped() {
        let addNoteVc = AddNoteViewController()
        navigationController?.pushViewController(addNoteVc, animated: true)
    }
    
    private func setupConstraints(){
        
        view.addSubview(noteSearchBar)
        noteSearchBar.translatesAutoresizingMaskIntoConstraints = false
        noteSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4).isActive = true
        noteSearchBar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        noteSearchBar.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        noteSearchBar.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        view.addSubview(notesLabel)
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        notesLabel.topAnchor.constraint(equalTo: noteSearchBar.bottomAnchor, constant: 32).isActive = true
        notesLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        
        
        view.addSubview(notesCollectionView)
        notesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        notesCollectionView.topAnchor.constraint(equalTo: notesLabel.bottomAnchor, constant: 40).isActive = true
        notesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        notesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        notesCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        view.addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 42).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        
    }

}
extension NotesViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredNotes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCell.reuseId, for: indexPath) as! NoteCell
        let randomColor = colors.randomElement()
        cell.backgroundColor = randomColor
        cell.setup(title: filteredNotes[indexPath.row].title ?? "", details: filteredNotes[indexPath.row].details ?? "")
        return cell
    }
    
    
}
extension NotesViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width - 58) / 2, height: 100)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = AddNoteViewController()
        let item = filteredNotes[indexPath.row]
        detailViewController.note = item
        detailViewController.isNewNote = false
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

