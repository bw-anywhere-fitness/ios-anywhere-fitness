//
//  Bearer.swift
//  Anywhere Fitness
//
//  Created by Michael Flowers on 5/22/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

struct Bearer: Codable {
    var token: String
    var id: Int
    var instructor: Bool
    
}
