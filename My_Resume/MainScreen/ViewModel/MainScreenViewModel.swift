//
//  MainScreenViewModel.swift
//  My_Resume
//
//  Created by Артём Тюрморезов on 01.08.2023.
//

import Foundation

final class MainScreenViewModel: MainScreenViewModelProtocol {
    
   var allData: MainScreeModelProtocol? = MainScreenModel(myHabits: ["ios", "async/await", "protocols", "Long text","ios", "async/await", "protocols", "Long text","ios", "async/await", "protocols", "Long text","ios", "async/await", "protocols", "Long text","ios", "async/await", "protocols", "Long text"])
    
    // MARK: - public methods
    func getHabits() -> [String]? {
        return allData?.myHabits
    }
    
    func passHabit(_ habit: String) {
        allData?.myHabits.append(habit)
    }
    
}
