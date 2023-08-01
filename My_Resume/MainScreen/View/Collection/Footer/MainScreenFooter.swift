//
//  MainScreenFooter.swift
//  My_Resume
//
//  Created by Артём Тюрморезов on 01.08.2023.
//

import Foundation
import UIKit

class MainScreenFooter: UIView {
//    static let reuseIdentifier = "headerView"
    var aboutMe: UILabel = {
        let habits = UILabel()
        habits.translatesAutoresizingMaskIntoConstraints = false
        habits.numberOfLines = 1
        habits.textAlignment = .left
        habits.text = "О себе"
        habits.font = .boldSystemFont(ofSize: 16)
        return habits
    }()
    var about: UILabel = {
        let habits = UILabel()
        habits.translatesAutoresizingMaskIntoConstraints = false
        habits.numberOfLines = 2
        habits.textAlignment = .left
        habits.text = "Experienced software engineer skilled in developing scalable and maintainable systems"
        habits.font = .systemFont(ofSize: 14)
        return habits
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(aboutMe)
        addSubview(about)
        aboutMe.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            aboutMe.topAnchor.constraint(equalTo: topAnchor, constant: CGFloat(MyResources.Constraints.top)),
            aboutMe.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(MyResources.Constraints.leading)),
            about.topAnchor.constraint(equalTo: aboutMe.bottomAnchor, constant: CGFloat(MyResources.Constraints.betweenElementsSmall)),
            about.leadingAnchor.constraint(equalTo: leadingAnchor, constant: CGFloat(MyResources.Constraints.leading)),
            about.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat(MyResources.Constraints.trailing)),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
