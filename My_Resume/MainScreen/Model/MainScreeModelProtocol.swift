//
//  MainScreeModelProtocol.swift
//  My_Resume
//
//  Created by Артём Тюрморезов on 01.08.2023.
//

import Foundation

protocol MainScreeModelProtocol {
    var profileImage: String { get set }
    var nameData: String { get set }
    var detailData: String { get set }
    var location: String { get set }
    var myHabits: [String] { get set}
    var aboutMe: String { get set }
}


