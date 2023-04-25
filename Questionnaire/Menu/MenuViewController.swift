//
//  MenuViewController.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 10.04.2023.
//

import UIKit

protocol MenuViewInputProtocol: AnyObject {
    func getQuestions(questions: (questions: [FlagsManager],
                                  answerFirst: [FlagsManager],
                                  answerSecond: [FlagsManager],
                                  answerThird: [FlagsManager],
                                  answerFourth: [FlagsManager]))
}

protocol MenuViewOutputProtocol: AnyObject {
    init(view: MenuViewInputProtocol)
    func getQuestions()
}

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
    
    var countQuestions = StorageManager.shared.fetchOptions().0
    var continent = StorageManager.shared.fetchOptions().1
    
    var totalQuestions: (questions: [FlagsManager],
                         answerFirst: [FlagsManager],
                         answerSecond: [FlagsManager],
                         answerThird: [FlagsManager],
                         answerFourth: [FlagsManager])!
    var presenter: MenuViewOutputProtocol!
    
    private let configurator: MenuConfiguratorInputProtocol = MenuConfigurator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        setupNavigationBar()
        setConstraints()
    }
    
    private func setupDesign() {
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
        configurator.configure(with: self, and: countQuestions, and: continent)
        presenter.getQuestions()
        let startGameVC = StartGameViewController()
        startGameVC.countQuestions = totalQuestions
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
// MARK: - MenuViewInputProtocol
extension MenuViewController: MenuViewInputProtocol {
    func getQuestions(questions: (questions: [FlagsManager],
                                  answerFirst: [FlagsManager],
                                  answerSecond: [FlagsManager],
                                  answerThird: [FlagsManager],
                                  answerFourth: [FlagsManager])) {
        totalQuestions = questions
    }
}
