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
        tableView.backgroundColor = .systemBlue
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let selectNumber = [
        "5 вопросов", "10 вопросов", "15 вопросов", "20 вопросов"
    ]
    private var checkmark = Checkmark.fiveQuestions
    
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
        cell.accessoryType = checkmark(indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0: checkmark = .fiveQuestions
        case 1: checkmark = .tenQuestions
        case 2: checkmark = .fifteenQuestions
        default: checkmark = .twentyQuestions
        }
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        reloadCells(indexPath.row)
    }
    
    private func reloadCells(_ index: Int) {
        let count = selectNumber.count
        for row in 0..<count {
            if !(row == index) {
                tableMenu.reloadRows(at: [IndexPath(row: row, section: 0)], with: .none)
            }
        }
    }
    
    private func setupSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setupBarButton() {
        let rightBarButton = UIBarButtonItem(
            title: "Готово",
            image: .none,
            target: self,
            action: #selector(done))
        
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func setupDesign() {
        setupSubviews(subviews: tableMenu)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Options"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = .systemBlue
        appearence.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearence.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func checkmark(_ index: Int) -> UITableViewCell.AccessoryType {
        var accessory: UITableViewCell.AccessoryType

        switch checkmark {
        case .fiveQuestions: accessory = index == 0 ? .checkmark : .none
        case .tenQuestions: accessory = index == 1 ? .checkmark : .none
        case .fifteenQuestions: accessory = index == 2 ? .checkmark : .none
        default: accessory = index == 3 ? .checkmark : .none
        }
        
        return accessory
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
