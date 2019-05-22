//
//  Client.swift
//  Anywhere Fitness
//
//  Created by Michael Flowers on 5/22/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

struct Client: Codable {
    let username: String
    let password: String
    let instructor: Bool
    let passes: [PunchPass]?
}
