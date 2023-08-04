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
    
    
    private var textTrailing: NSLayoutConstraint?
    private var textClosedButtonTrailing: NSLayoutConstraint?
    private var cellWidth: NSLayoutConstraint?
    
    
    // MARK: - Public methods
    func configure(text: String, isEditing: Bool, maxWidth: CGFloat) {
        contentView.layoutIfNeeded()
        titleLabel.text = text
        titleLabel.invalidateIntrinsicContentSize()
        
        deleteButton.isHidden = !isEditing
        textTrailing?.isActive = !isEditing
        textClosedButtonTrailing?.isActive = isEditing
        
        cellWidth?.constant = maxWidth
    }
    
    @objc func deleteTapped() {
        print("tap")
        deletingClosure?()
    }
    
    func setupUI() {
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(deleteButton)
        
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        textTrailing = titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
        textTrailing?.isActive = true
        
        textClosedButtonTrailing = titleLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: -10)
        deleteButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        cellWidth = contentView.widthAnchor.constraint(lessThanOrEqualToConstant: 200)
        cellWidth?.isActive = true
        
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        
        titleLabel.textColor = .black
        
        contentView.backgroundColor = MyResources.Colors.secondary
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8
        
        
        // MARK: - Constraints
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            
            deleteButton.widthAnchor.constraint(equalToConstant: 26),
            deleteButton.heightAnchor.constraint(equalToConstant: 26),
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14)
        ])
        
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
    
    //    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    //        let targetSize = CGSize(width: layoutAttributes.frame.width + 20,
    //                                height: layoutAttributes.frame.height)
    //        let targetAttributes = layoutAttributes.copy() as! UICollectionViewLayoutAttributes
    //        let textSize = titleLabel.sizeThatFits(targetSize)
    //        targetAttributes.frame.size = CGSize(width: ceil(textSize.width + 20) ,
    //                                             height: ceil(textSize.height) )
    //        return targetAttributes
    //    }
    
    // MARK: Init's
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
