//
//  Client.swift
//  Anywhere Fitness
//
//  Created by Michael Flowers on 5/22/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

struct Client: Codable {
    //does everything below here have to be on the api documentation for parsing purposes?
    let username: String
    let password: String
    let instructor: Bool
    
    //client may or may not be signed up for workouts
    let workouts: [Workout]?
    let passes: [PunchPass]?
    let id: Int?
}
