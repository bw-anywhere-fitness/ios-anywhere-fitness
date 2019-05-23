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
    var passes: [PunchPass]?
    let id: Int?
    let usesRemaining: Int? //coding keys uses_remaining in api doc
    
}

extension Client: Equatable {
    static func == (lhs: Client, rhs: Client) -> Bool {
        return lhs.username == rhs.username && lhs.id == rhs.id && lhs.workouts == rhs.workouts
    }
    
    
}
