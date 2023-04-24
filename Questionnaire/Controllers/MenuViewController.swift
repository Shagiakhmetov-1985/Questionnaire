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
    
    private lazy var labelMode: UILabel = {
        let label = UILabel()
        label.text = """
        Count questions: \(countQuestions.rawValue)
        Continent: \(continent.rawValue)
        """
        label.font = UIFont(name: "Copperplate", size: 20)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var countQuestions: CountQuestions!
    var continent: Continent!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        setupNavigationBar()
        setConstraints()
    }
    
    private func setupDesign() {
        countQuestions = StorageManager.shared.fetchOptions().0
        continent = StorageManager.shared.fetchOptions().1
        setupSubviews(subviews: labelHeading, buttonStartGame, buttonOptions, labelMode)
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
        startGameVC.countQuestions = getQuestions()
        navigationController?.pushViewController(startGameVC, animated: true)
    }
    
    @objc private func options() {
        let optionsVC = OptionsViewController()
        optionsVC.setOptions(questions: countQuestions, continents: continent)
        optionsVC.delegate = self
        let navigationVC = UINavigationController(rootViewController: optionsVC)
        navigationVC.modalPresentationStyle = .fullScreen
        present(navigationVC, animated: true)
    }
    
    private func getRandomQuestions() -> [FlagsManager] {
        switch continent {
        case .allCountries: return FlagsManager.getAllCountries().shuffled()
        case .americaContinent: return FlagsManager.getAmericanContinent().shuffled()
        case .europeContinent: return FlagsManager.getEuropeanContinent().shuffled()
        case .africaContinent: return FlagsManager.getAfricanContinent().shuffled()
        case .asiaContinent: return FlagsManager.getAsianContinent().shuffled()
        default: return FlagsManager.getOceanContinent().shuffled()
        }
    }
    
    private func countQuestions(_ questions: [FlagsManager]) -> [FlagsManager] {
        var count: [FlagsManager] = []
        let numbers = countQuestions.rawValue
        
        for index in 0..<numbers {
            count.append(questions[index])
        }
        
        return count
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
        let countQuestions = countQuestions.rawValue
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
        
        NSLayoutConstraint.activate([
            labelMode.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            labelMode.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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

extension MenuViewController: OptionsViewControllerDelegate {
    func getOptions(questions: CountQuestions, continents: Continent) {
        countQuestions = questions
        continent = continents

        labelMode.text = """
        Count questions: \(countQuestions.rawValue)
        Continent: \(continent.rawValue)
        """
    }
}
