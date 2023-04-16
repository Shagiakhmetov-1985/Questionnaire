//
//  StartGameViewController.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 12.04.2023.
//

import UIKit

protocol StartGameViewControllerProtocol {
    var questions: (questions: [FlagsManager],
                    answerFirst: [FlagsManager],
                    answerSecond: [FlagsManager],
                    answerThird: [FlagsManager],
                    answerFourth: [FlagsManager]) { get }
}

class StartGameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private lazy var tableQuestions: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .systemBlue
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var countQuestions: (questions: [FlagsManager],
                         answerFirst: [FlagsManager],
                         answerSecond: [FlagsManager],
                         answerThird: [FlagsManager],
                         answerFourth: [FlagsManager])!
    var checkmark: Checkmark!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        setupNavigationBar()
        setupBarButton()
        setupConstraints()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        countQuestions.questions.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as! CustomHeader
        view.title.text = "Вопрос \(section + 1)"
        view.image.image = UIImage(named: countQuestions.questions[section].flag)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        switch indexPath.row {
        case 0:
            cell.title.text = countQuestions.answerFirst[indexPath.section].name
            cell.image.image = checkImage(countQuestions.answerFirst[indexPath.section].select)
            cell.image.tintColor = checkColor(countQuestions.answerFirst[indexPath.section].select)
        case 1:
            cell.title.text = countQuestions.answerSecond[indexPath.section].name
            cell.image.image = checkImage(countQuestions.answerSecond[indexPath.section].select)
            cell.image.tintColor = checkColor(countQuestions.answerSecond[indexPath.section].select)
        case 2:
            cell.title.text = countQuestions.answerThird[indexPath.section].name
            cell.image.image = checkImage(countQuestions.answerThird[indexPath.section].select)
            cell.image.tintColor = checkColor(countQuestions.answerThird[indexPath.section].select)
        default:
            cell.title.text = countQuestions.answerFourth[indexPath.section].name
            cell.image.image = checkImage(countQuestions.answerFourth[indexPath.section].select)
            cell.image.tintColor = checkColor(countQuestions.answerFourth[indexPath.section].select)
        }
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomCell
        
    }
    
    private func setupDesign() {
        tableQuestions.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableQuestions.sectionHeaderHeight = 185
        tableQuestions.rowHeight = 55
        tableQuestions.tintColor = .systemBlue
        setupSubviews(subviews: tableQuestions)
    }
    
    private func setupNavigationBar() {
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setupBarButton() {
        let leftBarButton = UIBarButtonItem(
            title: "Главное меню",
            image: .none,
            target: self,
            action: #selector(backToMenu))
        
        let rightBarButton = UIBarButtonItem(
            title: "Завершить",
            image: .none,
            target: self,
            action: #selector(done))
        
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func backToMenu() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func done() {
        let resultsVC = ResultsViewController()
        navigationController?.pushViewController(resultsVC, animated: true)
    }
    
    private func checkImage(_ data: Bool) -> UIImage? {
        if data {
            return UIImage(systemName: "checkmark.circle")
        } else {
            return UIImage(systemName: "circle")
        }
    }
    
    private func checkColor(_ data: Bool) -> UIColor {
        if data {
            return UIColor.systemGreen
        } else {
            return UIColor.systemRed
        }
    }
}

extension StartGameViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableQuestions.topAnchor.constraint(equalTo: view.topAnchor),
            tableQuestions.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableQuestions.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableQuestions.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension StartGameViewController: StartGameViewControllerProtocol {
    var questions: (questions: [FlagsManager],
                    answerFirst: [FlagsManager],
                    answerSecond: [FlagsManager],
                    answerThird: [FlagsManager],
                    answerFourth: [FlagsManager]) {
        countQuestions
    }
}
