//
//  MenuOption.swift
//  GrabAndDine
//
//  Created by Rachel Chen on 5/6/19.
//  Copyright © 2019 rachelchen0418. All rights reserved.
//

import UIKit

enum MenuOption: Int, CustomStringConvertible {
    case Profile
    case Chats
    case Restaurants
    
    var description: String {
        switch self {
            case .Profile: return "Profile"
            case .Chats: return "Chats"
            case .Restaurants: return "Restaurants"
        }
    }
    
    var image: UIImage {
        switch self {
            case .Profile: return UIImage(named: "user") ?? UIImage()
            case .Chats: return UIImage(named: "chat") ?? UIImage()
            case .Restaurants: return UIImage(named: "restaurant") ?? UIImage()
        }
    }
}

