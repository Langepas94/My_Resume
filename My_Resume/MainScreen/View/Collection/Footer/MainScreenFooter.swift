//
//  MainScreenFooter.swift
//  My_Resume
//
//  Created by Артём Тюрморезов on 01.08.2023.
//

import Foundation
import UIKit

class MainScreenFooter: UICollectionReusableView {
    static let reuseIdentifier = "headerView"
    var habits: UILabel = {
        let habits = UILabel()
        habits.translatesAutoresizingMaskIntoConstraints = false
        habits.numberOfLines = 1
        habits.text = "Обо мне"
        habits.font = .systemFont(ofSize: 16)
        return habits
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        addSubview(habits)
        habits.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            habits.leadingAnchor.constraint(equalTo: leadingAnchor),
            habits.trailingAnchor.constraint(equalTo: trailingAnchor),
            habits.topAnchor.constraint(equalTo: topAnchor),
            habits.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
