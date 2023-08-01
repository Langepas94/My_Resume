//
//  MainScreenModel.swift
//  My_Resume
//
//  Created by Артём Тюрморезов on 01.08.2023.
//

import Foundation

struct MainScreenModel: MainScreeModelProtocol {

    var profileImage: String = "cosmoportrait"
    
    var nameData: String = "Artem Tyurmorezov"
    
    var location: String = "Volgograd"
    
    var detailData: String = "iOS разработчик, который хочет работать в Surf."
    
    var myHabits: [String] = []
    
    var aboutMe: String = "Дополнить"
    
    
}

