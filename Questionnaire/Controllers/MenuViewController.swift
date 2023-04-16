//
//  MenuViewController.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 10.04.2023.
//

import UIKit

class MenuViewController: UIViewController {
    private lazy var labelHeading: UILabel = {
        let label = UILabel()
        label.text = "Questionnaire"
        label.font = UIFont(name: "Copperplate", size: 40)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttonStartGame: UIButton = {
        let button = setButton(
            title: "Start game",
            style: "Copperplate",
            size: 40)
        button.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonOptions: UIButton = {
        let button = setButton(
            title: "Options",
            style: "Copperplate",
            size: 40)
        button.addTarget(self, action: #selector(options), for: .touchUpInside)
        return button
    }()
    
    private var checkmark = Checkmark.fiveQuestions
    private var startGameVC: StartGameViewControllerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        setupNavigationBar()
        setConstraints()
    }
    
    private func setupDesign() {
        startGameVC = StartGameViewController()
        setupSubviews(subviews: labelHeading, buttonStartGame, buttonOptions)
        view.backgroundColor = .systemBlue
    }
    
    private func setupSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setupNavigationBar() {
        let appearence = UINavigationBarAppearance()
        navigationController?.navigationBar.standardAppearance = appearence
        navigationController?.navigationBar.compactAppearance = appearence
    }
    
    @objc private func startGame() {
        let startGameVC = StartGameViewController()
        navigationController?.pushViewController(startGameVC, animated: true)
        startGameVC.countQuestions = getQuestions()
        startGameVC.checkmark = checkmark
    }
    
    @objc private func options() {
        let optionsVC = OptionsViewController()
        let navigationVC = UINavigationController(rootViewController: optionsVC)
        navigationVC.modalPresentationStyle = .fullScreen
        present(navigationVC, animated: true)
    }
    
    private func getRandomQuestions() -> [FlagsManager] {
        FlagsManager.getFlags().shuffled()
    }
    
    private func countQuestions(_ questions: [FlagsManager]) -> [FlagsManager] {
        var countQuestions: [FlagsManager] = []
        let numbers = checkmark.rawValue
        
        for index in 0..<numbers {
            countQuestions.append(questions[index])
        }
        
        return countQuestions
    }
    
    private func getChoosingAnswers(_ countQuestions: [FlagsManager], _ allQuestions: [FlagsManager]) -> [FlagsManager] {
        var choosingAnswers: [FlagsManager] = []
        
        for index in 0..<countQuestions.count {
            var fourAnswers: [FlagsManager] = []
            var answers = allQuestions
            fourAnswers.append(answers[index])
            answers.remove(at: index)
            
            let threeAnswers = wrongAnswers(answers)
            fourAnswers += threeAnswers
            fourAnswers.shuffle()
            choosingAnswers += fourAnswers
        }
        
        return choosingAnswers
    }
    
    private func wrongAnswers(_ answers: [FlagsManager]) -> [FlagsManager] {
        var threeAnswers: [FlagsManager] = []
        var wrongAnswers = answers
        var counter = 0
        
        while(counter < 3) {
            let index = Int.random(in: 0..<wrongAnswers.count)
            let wrongAnswer = wrongAnswers[index]
            threeAnswers.append(wrongAnswer)
            wrongAnswers.remove(at: index)
            counter += 1
        }
        
        return threeAnswers
    }
    
    private func getAnswers(_ answers: [FlagsManager]) -> (answerFirst: [FlagsManager],
                                                           answerSecond: [FlagsManager],
                                                           answerThird: [FlagsManager],
                                                           answerFourth: [FlagsManager]) {
        let countQuestions = checkmark.rawValue
        var first: [FlagsManager] = []
        var second: [FlagsManager] = []
        var third: [FlagsManager] = []
        var fourth: [FlagsManager] = []
        var counter = 0
        
        while(counter < countQuestions * 4) {
            first.append(answers[counter])
            second.append(answers[counter + 1])
            third.append(answers[counter + 2])
            fourth.append(answers[counter + 3])
            counter += 4
        }
        
        return (first, second, third, fourth)
    }
    
    private func getQuestions() -> (questions: [FlagsManager],
                                    answerFirst: [FlagsManager],
                                    answerSecond: [FlagsManager],
                                    answerThird: [FlagsManager],
                                    answerFourth: [FlagsManager]) {
        let randomQuestions = getRandomQuestions()
        
        let countQuestions = countQuestions(randomQuestions)
        
        let choosingAnswers = getChoosingAnswers(countQuestions, randomQuestions)
        
        let answers = getAnswers(choosingAnswers)
        
        return (countQuestions, answers.answerFirst, answers.answerSecond, answers.answerThird, answers.answerFourth)
    }
}

extension MenuViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            labelHeading.topAnchor.constraint(equalTo: view.topAnchor, constant: 130),
            labelHeading.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            buttonStartGame.topAnchor.constraint(equalTo: view.topAnchor, constant: 330),
            buttonStartGame.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStartGame.widthAnchor.constraint(equalToConstant: 300),
            buttonStartGame.heightAnchor.constraint(equalToConstant: 53)
        ])
        
        NSLayoutConstraint.activate([
            buttonOptions.topAnchor.constraint(equalTo: buttonStartGame.bottomAnchor, constant: 8),
            buttonOptions.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonOptions.widthAnchor.constraint(equalToConstant: 300),
            buttonOptions.heightAnchor.constraint(equalToConstant: 53)
        ])
    }
}

extension MenuViewController {
    private func setButton(title: String, style: String, size: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont(name: style, size: size)
        button.backgroundColor = .white
        button.tintColor = .systemBlue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

