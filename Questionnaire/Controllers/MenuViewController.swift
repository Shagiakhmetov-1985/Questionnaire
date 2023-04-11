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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        setConstraints()
    }
    
    private func setupDesign() {
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
        print("start game")
    }
    
    @objc private func options() {
        let viewController = OptionsViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true)
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

