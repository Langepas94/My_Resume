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
    
    var isDeleteButtonEnabled: Bool = false {
        didSet {
            refreshLayout()
        }
    }
    
    
    // MARK: - Public methods
    func configure(text: String) {
        titleLabel.text = text
    }
    
    @objc func deleteTapped() {
        deletingClosure?()
    }
    
    func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(deleteButton)
        
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        
        titleLabel.textColor = .black
        
        contentView.backgroundColor = MyResources.Colors.secondary
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8
        
        NSLayoutConstraint.activate([
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            deleteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: deleteButton.leadingAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
        
        deleteButton.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        
    }
    
    @objc func refreshLayout() {
        
        if isDeleteButtonEnabled {
            deleteButton.isEnabled = true
            deleteButton.isHidden = false
            
        } else {
            deleteButton.isEnabled.toggle()
            deleteButton.isHidden.toggle()
            
        }
        
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width,
                                height: layoutAttributes.frame.height)
        let targetAttributes = layoutAttributes.copy() as! UICollectionViewLayoutAttributes
        let textSize = titleLabel.sizeThatFits(targetSize)
        targetAttributes.frame.size = CGSize(width: ceil(textSize.width + 20) ,
                                             height: ceil(textSize.height) )
        return targetAttributes
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
