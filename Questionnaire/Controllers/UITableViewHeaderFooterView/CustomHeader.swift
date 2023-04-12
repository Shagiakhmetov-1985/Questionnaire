//
//  CustomHeader.swift
//  Questionnaire
//
//  Created by Marat Shagiakhmetov on 12.04.2023.
//

import UIKit

class CustomHeader: UITableViewHeaderFooterView {
    let title = UILabel()
    let image = UIImageView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        title.font = UIFont.systemFont(ofSize: 22, weight: .light)
        
        addSubviews(subviews: title, image)
        
        setupConstraints()
    }
    
    private func addSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            contentView.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            title.topAnchor.constraint(equalTo: contentView.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 210),
            image.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
}
