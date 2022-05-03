//
//  EditorialModel.swift
//  One-Lab-Final
//
//  Created by Бексултан Нурпейс on 02.05.2022.
//

import Foundation
import UIKit

struct EditorialModel: Hashable{
    let imageName: String
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(imageName)
        hasher.combine(title)
    }
}

