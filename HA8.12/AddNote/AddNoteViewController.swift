//
//  AddNoteViewController.swift
//  HA8.12
//
//  Created by Maksat Edil on 14/12/23.
//

import Foundation
import UIKit

class AddNoteViewController: UIViewController {
    
    private let noteDataManager = NoteDataManager.shared
    
    var note: Note?
    
    var isNewNote = true
    
    private lazy var titleTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "Введите текст"
        view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 15
        view.addTarget(self, action: #selector(titleTextFieldEditingChanged), for: .editingChanged)
        
        return view
    }()
    
    private lazy var descriptionTextView: UITextView = {
        let view = UITextView()
        view.layer.backgroundColor = UIColor(red: 0.933, green: 0.933, blue: 0.937, alpha: 1).cgColor
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = .red
        view.setTitle("Сохранить", for: .normal)
        view.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        view.setTitleColor(.white, for: .normal)
        view.layer.cornerRadius = 20
        view.backgroundColor = .lightGray
        return view
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        view.backgroundColor = .systemBackground
        
        if let note = note{
            titleTextField.text = note.title
            descriptionTextView.text = note.details
        }
        if isNewNote == true{
            let settingsBarButton = UIBarButtonItem(image:UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(titleTextFieldEditingChanged))
            navigationItem.rightBarButtonItem = settingsBarButton
        } else {
            let settingsBarButton = UIBarButtonItem(image:UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(trashBtn))
            navigationItem.rightBarButtonItem = settingsBarButton
        }
    }
    
    @objc private func trashBtn(){
        let alert = UIAlertController(title: "Удаление", message: "Вы хотите удалить?", preferredStyle: .alert)
        let actionAccept = UIAlertAction(title: "Да", style: .cancel) { action in
            self.noteDataManager.deleteNote(id: self.note?.id ?? "")
        }
        let actionNo = UIAlertAction(title: "Нет", style: .default) { action in
            
        }
        alert.addAction(actionAccept)
        alert.addAction(actionNo)
        present(alert, animated: true)
    }
    
    @objc func titleTextFieldEditingChanged(){
        saveButton.backgroundColor = .red
    }
    
    @objc func saveButtonTapped(){
        let id = UUID().uuidString
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-DD HH:mm:ss"
        let dateString = dateFormatter.string(from: date)
       
        showAlert(id: id, titles: titleTextField.text ?? "", date: dateString )
    }
    
    private func showAlert(id: String, titles: String, date: String ){
        let alert = UIAlertController(title: "Cохранение", message: "Вы хотите сохранить?", preferredStyle: .alert)
        let actionAccept = UIAlertAction(title: "Да", style: .cancel) { action in
            if self.isNewNote == true {
                self.noteDataManager.addNote(id: id, title: titles, date: date, descrition: self.descriptionTextView.text ?? "")
            } else {
                self.noteDataManager.updateNote(id: self.note?.id ?? "", title: titles, descrition: self.descriptionTextView.text ?? "", date: date)
            }
            self.navigationController?.popViewController(animated: true)

        }
        let actionNo = UIAlertAction(title: "Нет", style: .default) { action in
            
        }
        alert.addAction(actionAccept)
        alert.addAction(actionNo)
        present(alert, animated: true)
        
    }
    
    
    private func setupConstraints(){
        view.addSubview(titleTextField)
        titleTextField.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        titleTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        titleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 34).isActive = true
        
        view.addSubview(descriptionTextView)
        descriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 26).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -230).isActive = true
        
        
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.topAnchor.constraint(equalTo: descriptionTextView.bottomAnchor, constant: 105).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
}
