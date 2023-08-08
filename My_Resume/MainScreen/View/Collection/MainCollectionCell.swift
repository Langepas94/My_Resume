//
//  MainCollectionCell.swift
//  My_Resume
//
//  Created by Артём Тюрморезов on 01.08.2023.
//

import Foundation
import UIKit

class MainCollectionCell: UICollectionViewCell {
    
    
    // MARK: Public properties
    var titleLabel = UILabel()
    
    var deletingClosure: (() -> Void)?
    
    var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        button.setTitleColor(.cyan, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private var textLeading: NSLayoutConstraint?
    private var textTop: NSLayoutConstraint?
    private var textBottom: NSLayoutConstraint?
    private var textTrailingWithButton: NSLayoutConstraint?
    private var textTrailing: NSLayoutConstraint?
    
    private var buttonTrailing: NSLayoutConstraint?
    private var buttonCenterY: NSLayoutConstraint?
    
    // MARK: - Public methods
    func configure(text: String, isEditing: Bool) {
      
        contentView.layoutIfNeeded()
        titleLabel.text = text
        titleLabel.invalidateIntrinsicContentSize()
        
        
        deleteButton.isHidden = !isEditing
        textTrailingWithButton?.isActive = isEditing
        textTrailing?.isActive = !isEditing
        buttonTrailing?.isActive = isEditing
        buttonCenterY?.isActive = isEditing
        contentView.layoutIfNeeded()
     
    }
    
    private func configureConstraints(isEditing: Bool) {
        deleteButton.isHidden = !isEditing
    }
    
    @objc func deleteTapped() {
        print("tap")
        deletingClosure?()
    }
//    override func layoutSubviews() {
//        super.layoutSubviews()
////        layoutIfNeeded()
////        layoutSubviews()
////        contentView.layoutIfNeeded()
////        contentView.layoutSubviews()
//    }
    func setupUI() {
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(deleteButton)
        
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        textLeading = titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12)
        textLeading?.isActive = true
        textTop = titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12)
        textTop?.isActive = true
        textBottom = titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        textBottom?.isActive = true
        textTrailingWithButton = titleLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -12)
        textTrailing = titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        textTrailing?.isActive = true
        
        
        buttonCenterY = deleteButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor)
        buttonTrailing = deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        
        titleLabel.textColor = .black
        
        contentView.backgroundColor = MyResources.Colors.secondary
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8

        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        
    }
    
    // MARK: - Animation
    
    func shakeAnimation() {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        shakeAnimation.duration = 0.3
        shakeAnimation.values = [-10, 10, -10, 10, -5, 5, -2, 2, 0]
        layer.add(shakeAnimation, forKey: "shakeAnimation")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
    }
    
    // MARK: Init's
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
