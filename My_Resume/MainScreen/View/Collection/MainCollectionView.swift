//
//  MainCollectionView.swift
//  My_Resume
//
//  Created by Артём Тюрморезов on 01.08.2023.
//

import Foundation
import UIKit

class MainCollectionView: UIView {
    
    // MARK: Pulic
    
    lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: createCompose())
        return collection
    }()
    
    var texts: [String] = []
    
    lazy var habits: UILabel = {
        let habits = UILabel()
        habits.translatesAutoresizingMaskIntoConstraints = false
        habits.numberOfLines = 1
        habits.text = "Мои навыки"
        habits.font = .boldSystemFont(ofSize: 16)
        return habits
    }()
    
    var alertTapped: ((Bool) -> Void)?
    
    var deleteTapped: ((Int) -> Void)?
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.black), for: .normal)
        button.setImage(UIImage(systemName: "checkmark.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.black), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var isEditing = false
    
    // MARK: Setup Collection
    
    func setupCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainCollectionCell.self, forCellWithReuseIdentifier: "cell")
        
        collectionView.register(AddCollectionItemCell.self, forCellWithReuseIdentifier: "add")
        
        addSubview(collectionView)
        addSubview(habits)
        addSubview(editButton)
        
        // MARK: - Constraints
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            habits.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            habits.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            collectionView.topAnchor.constraint(equalTo: habits.bottomAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            editButton.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            editButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        collectionView.backgroundColor = .white
        
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Compositional Layout
    
    func createCompose() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout(section: setupCollectionViewCompositionalLayout())
        return layout
    }
    
    func setupCollectionViewCompositionalLayout() -> NSCollectionLayoutSection{
        
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: .estimated(100),
            heightDimension: .absolute(62)
        )
        
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutSize)
        
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 18, leading: 8, bottom: 8, trailing: 8)
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: layoutSize.heightDimension
            ),
            subitems: [layoutItem]
        )
        group.interItemSpacing = .fixed(14)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        return section
        
    }
    
    // MARK : - Data Func
    
    @objc func editButtonTapped(_ sender: UIButton) {
        isEditing.toggle()
        
        sender.isSelected.toggle()
        
        collectionView.reloadData()
    }
    
    // MARK: Init's
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCollectionView()
    }
}

// MARK: Collection Delegates and Data

extension MainCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isEditing ? texts.count + 1 : texts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if isEditing && indexPath.row == texts.count   {
            let addButtonCell = collectionView.dequeueReusableCell(withReuseIdentifier: "add", for: indexPath) as! AddCollectionItemCell
            
            return addButtonCell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainCollectionCell
            
            cell.configure(text: texts[indexPath.row] ?? "")
            if isEditing {
                cell.isDeleteButtonEnabled = true
            } else {
                cell.isDeleteButtonEnabled = false
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditing && indexPath.row == texts.count  {
            
            alertTapped?(true)
        } else if isEditing {
            if let cell = collectionView.cellForItem(at: indexPath) as? MainCollectionCell {
                
                
                cell.deletingClosure = {
                    self.deleteTapped?(indexPath.row)
                    print(indexPath.row)
                }
            }
        }
    }
}

