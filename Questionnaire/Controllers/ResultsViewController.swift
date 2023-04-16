//
//  ResultsViewController.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 13.04.2023.
//

import UIKit

class ResultsViewController: UIViewController {
    private lazy var buttonBackToMenu: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Назад в меню", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonBack), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        setupNavigationBar()
        setupContraints()
    }
    
    private func setupDesign() {
        view.backgroundColor = .white
        navigationItem.title = "Results"
        navigationItem.hidesBackButton = true
        setupSubviews(subviews: buttonBackToMenu)
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
    
    @objc private func buttonBack(_ segue: UIStoryboardSegue) {
        navigationController?.popToRootViewController(animated: true)
    }
}

extension ResultsViewController {
    private func setupContraints() {
        NSLayoutConstraint.activate([
            buttonBackToMenu.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonBackToMenu.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
