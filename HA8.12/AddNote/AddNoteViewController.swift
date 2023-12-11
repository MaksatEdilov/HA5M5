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
    
    private lazy var titleTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "enter title"
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var saveButton: UIButton = {
        let view = UIButton(type: .system)
        view.backgroundColor = .red
        view.setTitle("save", for: .normal)
        view.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return view
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        view.backgroundColor = .systemBackground
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
            self.noteDataManager.addNote(id: id, title: titles, date: date, descrition: "none")
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
        titleTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleTextField.widthAnchor.constraint(equalToConstant: view.frame.width - 20).isActive = true
        titleTextField.heightAnchor.constraint(equalToConstant: 44 ).isActive = true
        
        view.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        saveButton.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
}
