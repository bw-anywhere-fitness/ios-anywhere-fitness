//
//  WorkoutController.swift
//  Anywhere Fitness
//
//  Created by Michael Flowers on 5/22/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

class WorkoutController {
    
    let baseURL = URL(string: "https://anywhere-fitness.herokuapp.com/classes")!
    var workouts: [Workout] = []
    var bearer: Bearer?
    
    func postWorkout(with workout: Workout, completion: @escaping (Error?) -> Void) {
        let url = baseURL
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jE = JSONEncoder()
        
        do {
            let jsonData = try jE.encode(workout)
            request.httpBody = jsonData
        } catch  {
            print("Error trying to Encode workouts to server: \(error.localizedDescription)")
            completion(error)
            return
        }
        
        
        
        
    }
    
    func fetchWorkouts(completion: @escaping ([Workout]?, Error?) -> Void ){
        guard let bearer = bearer else {
            print("problem with the bearer")
            completion(nil,NSError())
            return}
        
        let url = baseURL.appendingPathComponent("classes")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse{
                print("This is the stupid response we got badk: \(response) and the status: \(response.statusCode)")
                return
            }
            
            if let error = error {
                print("Error with fetching all the workouts: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                print("Error with the data fetching all workouts")
                completion(nil, NSError())
                return
            }
            
            let jD = JSONDecoder()
            
            do {
                let workouts = try jD.decode([Workout].self, from: data)
                completion(workouts, nil)
                self.workouts = workouts
                print("This is all the workouts: \(workouts)")
            } catch {
                print("Error decoding the data trying to fetch all workouts: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
        }.resume()
    }
}
