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
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var countQuestions: (questions: [FlagsManager],
                         answerFirst: [FlagsManager],
                         answerSecond: [FlagsManager],
                         answerThird: [FlagsManager],
                         answerFourth: [FlagsManager])!
    
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
        view.title.text = "Question \(section + 1)"
        view.image.image = UIImage(named: countQuestions.questions[section].flag)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        switch indexPath.row {
        case 0: cell.title.text = countQuestions.answerFirst[indexPath.section].name
        case 1: cell.title.text = countQuestions.answerSecond[indexPath.section].name
        case 2: cell.title.text = countQuestions.answerThird[indexPath.section].name
        default: cell.title.text = countQuestions.answerFourth[indexPath.section].name
        }
        
        cell.image.image = UIImage(systemName: "circle")
        cell.image.tintColor = .red
        return cell
    }
    
    private func setupDesign() {
        tableQuestions.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableQuestions.sectionHeaderHeight = 185
        tableQuestions.rowHeight = 55
        setupSubviews(subviews: tableQuestions)
    }
    
    private func setupNavigationBar() {
        let appearence = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        navigationController?.navigationBar.scrollEdgeAppearance = appearence
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
        
        navigationItem.title = "Questionnarie"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.leftBarButtonItem = leftBarButton
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func backToMenu() {
        dismiss(animated: true)
    }
    
    @objc private func done() {
        print("done!")
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
