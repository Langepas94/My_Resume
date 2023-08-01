//
//  MainScreenViewModelProtocol.swift
//  My_Resume
//
//  Created by Артём Тюрморезов on 01.08.2023.
//

import Foundation

protocol MainScreenViewModelProtocol {
    var allData: MainScreeModelProtocol? { get set}
    func getHabits() -> [String]?
    func passHabit(_ habit: String)
}
