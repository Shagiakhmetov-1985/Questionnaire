//
//  MenuViewController.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 10.04.2023.
//

import UIKit

class MenuViewController: UIViewController {
    private lazy var imageWallpaper: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Questions")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        setConstraints()
    }
    
    private func setupDesign() {
        startGameVC = StartGameViewController()
        setupSubviews(subviews: imageWallpaper,
                      buttonStartGame,
                      buttonOptions)
    }
    
    private func setupSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    @objc private func startGame() {
        let startGameVC = StartGameViewController()
        let navigationVC = UINavigationController(rootViewController: startGameVC)
        navigationVC.modalPresentationStyle = .fullScreen
        startGameVC.countQuestions = getQuestions()
        present(navigationVC, animated: true)
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
            imageWallpaper.topAnchor.constraint(equalTo: view.topAnchor),
            imageWallpaper.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageWallpaper.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageWallpaper.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            buttonStartGame.topAnchor.constraint(equalTo: view.topAnchor, constant: 265),
            buttonStartGame.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            buttonOptions.topAnchor.constraint(equalTo: view.topAnchor, constant: 320),
            buttonOptions.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

extension MenuViewController {
    private func setButton(title: String, style: String, size: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont(name: style, size: size)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

