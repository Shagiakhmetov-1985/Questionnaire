//
//  ResultsViewController.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 13.04.2023.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private lazy var tableResults: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        setupNavigationBar()
        setupBarButton()
        setupContraints()
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
        
        switch indexPath.row % 4 {
        case 0:
            cell.title.text = countQuestions.answerFirst[indexPath.section].name
            cell.image.image = checkImage(countQuestions.answerFirst[indexPath.section].select)
            cell.image.tintColor = checkColor(countQuestions.answerFirst[indexPath.section].select)
            cell.backgroundColor = checkAnswers(
                countQuestions.questions[indexPath.section], countQuestions.answerFirst[indexPath.section])
        case 1:
            cell.title.text = countQuestions.answerSecond[indexPath.section].name
            cell.image.image = checkImage(countQuestions.answerSecond[indexPath.section].select)
            cell.image.tintColor = checkColor(countQuestions.answerSecond[indexPath.section].select)
            cell.backgroundColor = checkAnswers(
                countQuestions.questions[indexPath.section], countQuestions.answerSecond[indexPath.section])
        case 2:
            cell.title.text = countQuestions.answerThird[indexPath.section].name
            cell.image.image = checkImage(countQuestions.answerThird[indexPath.section].select)
            cell.image.tintColor = checkColor(countQuestions.answerThird[indexPath.section].select)
            cell.backgroundColor = checkAnswers(
                countQuestions.questions[indexPath.section], countQuestions.answerThird[indexPath.section])
        default:
            cell.title.text = countQuestions.answerFourth[indexPath.section].name
            cell.image.image = checkImage(countQuestions.answerFourth[indexPath.section].select)
            cell.image.tintColor = checkColor(countQuestions.answerFourth[indexPath.section].select)
            cell.backgroundColor = checkAnswers(
                countQuestions.questions[indexPath.section], countQuestions.answerFourth[indexPath.section])
        }
        
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        cell.selectionStyle = .none
        return cell
    }
    
    private func setupDesign() {
        tableResults.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableResults.sectionHeaderHeight = 185
        tableResults.rowHeight = 55
        setupSubviews(subviews: tableResults)
    }
    
    private func setupSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Results"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.hidesBackButton = true
        
        let appearence = UINavigationBarAppearance()
        appearence.backgroundColor = .systemBlue
        appearence.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func setupBarButton() {
        let rightBarButton = UIBarButtonItem(
            title: "Finish",
            image: .none,
            target: self,
            action: #selector(buttonFinish))
        
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc private func buttonFinish() {
        navigationController?.popToRootViewController(animated: true)
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
    
    private func checkSelect(_ answer: [FlagsManager],_ indexPath: IndexPath) {
        countQuestions.answerFirst[indexPath.section].select = answer == countQuestions.answerFirst ? true : false
        countQuestions.answerSecond[indexPath.section].select = answer == countQuestions.answerSecond ? true : false
        countQuestions.answerThird[indexPath.section].select = answer == countQuestions.answerThird ? true : false
        countQuestions.answerFourth[indexPath.section].select = answer == countQuestions.answerFourth ? true : false
    }
    
    private func checkAnswers(_ question: FlagsManager,_ answer: FlagsManager) -> UIColor {
        var color = UIColor()
        let lightGreen = UIColor(red: 183/255, green: 255/255, blue: 183/255, alpha: 1)
        let lightRed = UIColor(red: 255/255, green: 204/255, blue: 204/255, alpha: 1)
        switch true {
        case question.flag == answer.flag:
            color = answer.select ? lightGreen : lightGreen
        case !(question.flag == answer.flag):
            color = answer.select ? lightRed : UIColor.white
        default: break
        }
        return color
    }
}

extension ResultsViewController {
    private func setupContraints() {
        NSLayoutConstraint.activate([
            tableResults.topAnchor.constraint(equalTo: view.topAnchor),
            tableResults.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableResults.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableResults.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
