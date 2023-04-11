//
//  OptionsViewController.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 10.04.2023.
//

import UIKit

class OptionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private lazy var tableMenu: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var imageCheckmark: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let selectNumber = [
        "5 вопросов", "10 вопросов", "15 вопросов", "20 вопросов"
    ]
    private var check = Checkmark.fiveQuestions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButton()
        setupDesign()
        setupNavigationBar()
        setConstraints()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        selectNumber.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let title = selectNumber[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = title
        cell.contentConfiguration = content
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
    
    private func setupSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setupBarButton() {
        let leftBarButton = UIBarButtonItem(
            title: "Отмена",
            image: .none,
            target: self,
            action: #selector(cancel))
        let rightBarButton = UIBarButtonItem(
            title: "Готово",
            image: .none,
            target: self,
            action: #selector(done))
        
        navigationItem.title = "Options"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func setupDesign() {
        setupSubviews(subviews: tableMenu)
    }
    
    private func setupNavigationBar() {
        let appearence = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
    }
    /*
    private func checkmark(_ index: Int) -> UITableViewCell.AccessoryType {
        var accessory: UITableViewCell.AccessoryType

        switch index {
        case 0:
        case 1:
        case 2:
        default:
        }
    }
    */
    @objc private func cancel() {
        dismiss(animated: true)
    }
    
    @objc private func done() {
        dismiss(animated: true)
    }
}

extension OptionsViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableMenu.topAnchor.constraint(equalTo: view.topAnchor),
            tableMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableMenu.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
