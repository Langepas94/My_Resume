//
//  ViewController.swift
//  My_Resume
//
//  Created by Артём Тюрморезов on 01.08.2023.
//

import UIKit

final class MainScreenViewController: UIViewController {
    
    // MARK: ViewModel
    
    var vm: MainScreenViewModelProtocol = MainScreenViewModel()
    
    // MARK: Private properties
    private lazy var profileImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: vm.allData?.profileImage ?? "")
        image.layer.masksToBounds = true
        
        return image
    }()
    
    let scrollView: UIScrollView = {
        let v = UIScrollView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .cyan
        return v
    }()
    
    private lazy var profileName: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = vm.allData?.nameData ?? ""
        text.font = .boldSystemFont(ofSize: 24)
        text.textAlignment = .center
        text.numberOfLines = 2
        return text
    }()
    
    private lazy var detailData: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .systemFont(ofSize: 14)
        text.text = vm.allData?.detailData ?? ""
        text.textColor = MyResources.Colors.secondaryText
        text.textAlignment = .center
        text.numberOfLines = 2
        return text
    }()
    
    private lazy var location: UILabel = {
        let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = .systemFont(ofSize: 14)
        text.textColor = MyResources.Colors.secondaryText
        text.text = vm.allData?.location ?? ""
        text.textAlignment = .center
        text.numberOfLines = 1
        return text
    }()
    
    private lazy var collectionView: MainCollectionView = {
        let view = MainCollectionView()
        view.texts = self.vm.getHabits() ?? [""]
        view.backgroundColor = MyResources.Colors.background
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var footer: MainScreenFooter = {
        let view = MainScreenFooter()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = MyResources.Colors.background
        return view
    }()
    
    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        closureAppearing()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        
    }
    
    // MARK: Alert Settings
    
    @objc func presentAlert() {
        let alertController = UIAlertController(title: "Добавление навыка", message: "Введите название навыка которым владеете", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Отмена", style: .cancel) { action in
            self.dismiss(animated: true)
        }
        let addAction = UIAlertAction(title: "Добавить", style: .default) { action in
            if let textField = alertController.textFields?.first, let text = textField.text {
                
                self.vm.passHabit(text)
                self.collectionView.texts = self.vm.getHabits() ?? [""]
                self.collectionView.collectionView.reloadData()
                
            }
        }
        alertController.addTextField { textfield in
            textfield.placeholder = "Введите название"
            
        }
        alertController.addAction(addAction)
        alertController.addAction(cancel)
        
        present(alertController, animated: true)
    }
}



// MARK: Setup UI

extension MainScreenViewController {
    func setupUI() {
        view.addSubview(profileImage)
        view.addSubview(profileName)
        view.addSubview(detailData)
        view.addSubview(location)
        view.addSubview(collectionView)
        view.addSubview(footer)
        view.addSubview(scrollView)
        
        
        
        // MARK: - Constraints
        
        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(MyResources.Constraints.top)),
            profileImage.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.3),
            profileImage.heightAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.3),
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            profileName.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: CGFloat(MyResources.Constraints.top)),
            profileName.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: CGFloat(MyResources.Constraints.leading)),
            profileName.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: CGFloat(MyResources.Constraints.trailing)),
            profileName.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor),
            
            detailData.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: CGFloat(MyResources.Constraints.betweenElements)),
            detailData.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: CGFloat(MyResources.Constraints.leading)),
            detailData.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: CGFloat(MyResources.Constraints.trailing)),
            detailData.centerXAnchor.constraint(equalTo: profileName.centerXAnchor),
            
            location.topAnchor.constraint(equalTo: detailData.bottomAnchor, constant: CGFloat(MyResources.Constraints.betweenElements)),
            location.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: CGFloat(MyResources.Constraints.leading)),
            location.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: CGFloat(MyResources.Constraints.trailing)),
            location.centerXAnchor.constraint(equalTo: detailData.centerXAnchor),
            
            footer.heightAnchor.constraint(equalToConstant: 150),
            footer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: location.bottomAnchor, constant: CGFloat(MyResources.Constraints.top)),
            collectionView.bottomAnchor.constraint(equalTo: footer.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
        
        view.backgroundColor = MyResources.Colors.secondary
    }
    
    func closureAppearing() {
        collectionView.alertTapped = { _ in
            self.presentAlert()
        }
        
        collectionView.deleteTapped = { str in
            self.vm.allData?.myHabits.remove(at: str)
            self.collectionView.texts = self.vm.getHabits() ?? [""]
            self.collectionView.collectionView.reloadData()
        }
    }
}
