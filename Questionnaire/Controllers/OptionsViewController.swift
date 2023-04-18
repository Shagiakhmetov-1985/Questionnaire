//
//  OptionsViewController.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 10.04.2023.
//

import UIKit

protocol OptionsViewControllerProtocol {
    var getCountQuestions: CountQuestions { get }
    var getContinents: Continent { get }
}

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
    
    private let countQuestions = CountQuestions.allCases
    private var checkmarkQuestions: CountQuestions!
    
    private let continents = Continent.allCases
    private var checkmarkContinents: Continent!
    
    private let titleHeader = Options.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButton()
        setupDesign()
        setupNavigationBar()
        setConstraints()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return countQuestions.count
        } else {
            return continents.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        titleHeader.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = titleHeader[section].rawValue.uppercased()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        switch indexPath.section {
        case 0:
            let title = countQuestions[indexPath.row].rawValue
            content.text = "\(title) вопросов"
            cell.accessoryType = checkmarkQuestions(indexPath.row)
        default:
            let title = continents[indexPath.row].rawValue
            content.text = "\(title)"
            cell.accessoryType = checkmarkContinents(indexPath.row)
        }
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: checkmarkQuestions = .fiveQuestions
            case 1: checkmarkQuestions = .tenQuestions
            case 2: checkmarkQuestions = .fifteenQuestions
            default: checkmarkQuestions = .twentyQuestions
            }
        default:
            switch indexPath.row {
            case 0: checkmarkContinents = .allCountries
            case 1: checkmarkContinents = .americaContinent
            case 2: checkmarkContinents = .europeContinent
            case 3: checkmarkContinents = .africaContinent
            case 4: checkmarkContinents = .asiaCOntinent
            default: checkmarkContinents = .oceaniaContinent
            }
        }
        
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        reloadCells(indexPath.row, indexPath.section)
    }
    
    private func reloadCells(_ index: Int,_ section: Int) {
        switch section {
        case 0:
            let count = countQuestions.count
            for row in 0..<count {
                if !(row == index) {
                    tableMenu.reloadRows(at: [IndexPath(row: row, section: section)], with: .none)
                }
            }
        default:
            let count = continents.count
            for row in 0..<count {
                if !(row == index) {
                    tableMenu.reloadRows(at: [IndexPath(row: row, section: section)], with: .none)
                }
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
        tableMenu.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
        tableMenu.sectionHeaderHeight = 35
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
    
    private func checkmarkQuestions(_ index: Int) -> UITableViewCell.AccessoryType {
        var accessory: UITableViewCell.AccessoryType

        switch checkmarkQuestions {
        case .fiveQuestions: accessory = index == 0 ? .checkmark : .none
        case .tenQuestions: accessory = index == 1 ? .checkmark : .none
        case .fifteenQuestions: accessory = index == 2 ? .checkmark : .none
        default: accessory = index == 3 ? .checkmark : .none
        }
        
        return accessory
    }
    
    private func checkmarkContinents(_ index: Int) -> UITableViewCell.AccessoryType {
        var accessory: UITableViewCell.AccessoryType

        switch checkmarkContinents {
        case .allCountries: accessory = index == 0 ? .checkmark : .none
        case .americaContinent: accessory = index == 1 ? .checkmark : .none
        case .europeContinent: accessory = index == 2 ? .checkmark : .none
        case .africaContinent: accessory = index == 3 ? .checkmark : .none
        case .asiaCOntinent: accessory = index == 4 ? .checkmark : .none
        default: accessory = index == 5 ? .checkmark : .none
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

extension OptionsViewController: OptionsViewControllerProtocol {
    var getCountQuestions: CountQuestions {
        checkmarkQuestions
    }
    var getContinents: Continent {
        checkmarkContinents
    }
}
