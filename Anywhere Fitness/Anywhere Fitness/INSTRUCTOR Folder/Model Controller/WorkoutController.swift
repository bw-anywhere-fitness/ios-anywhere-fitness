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
    
    
    func createClass(id: Int?, name: String, schedule: String, location: String, image: String?, instructorID: Int?, punchPass: PunchPass?, clients: [Client]?) -> Workout {
        let newWorkout = Workout(id: id, name: name, schedule: schedule, location: location, image: image, instructorID: instructorID, punchPass: punchPass, clients: clients)
        return newWorkout
    }
    
    func postClass(with workout: Workout, completion: @escaping (Error?) -> Void) {
        let url = baseURL
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jE = JSONEncoder()
        
        do {
            let jsonData = try jE.encode(workout)
            request.httpBody = jsonData
        } catch  {
            print("Error trying to Encode classes to server: \(error.localizedDescription)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let response = response as? HTTPURLResponse {
                print("This is the response for posting classes: \(response) and the status: \(response.statusCode)")
                completion(NSError())
                return
            }
            
            if let error = error {
                print("Error with posting classes to server: \(error.localizedDescription)")
                completion(error)
                return
            }
        }
    }
    
    func fetchClasses(completion: @escaping ([Workout]?, Error?) -> Void ){
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
                print("Error with fetching all the classes: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                print("Error with the data fetching all classes")
                completion(nil, NSError())
                return
            }
            
            let jD = JSONDecoder()
            
            do {
                let workouts = try jD.decode([Workout].self, from: data)
                completion(workouts, nil)
                print("This is all the classes: \(workouts)")
            } catch {
                print("Error decoding the data trying to fetch all workouts: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    //fetch workout of instructor
    func fetchClassesBy(instructor: Client, completion: @escaping ([Workout]?, Error?) -> Void ){
        guard let bearer = bearer else {
            print("problem with the bearer")
            completion(nil,NSError())
            return}
        
        let url = baseURL.appendingPathComponent("instructor").appendingPathComponent(":\(String(describing: instructor.id))")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("This is the response from fetching classes by Instructor: \(response) and status: \(response.statusCode)")
                completion(nil, NSError())
                return
            }
            
            if let error = error {
                print("Error fetching classes by instructor's id: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                print("Error with the data fetching all classes by instructor :\(NSError()).")
                completion(nil, NSError())
                return
            }
            
            let jD = JSONDecoder()
            
            do {
                let jsonData = try jD.decode([Workout].self, from: data)
                completion(jsonData, nil)
            } catch {
                print("Error decoding all the classes fetched by instructor's id: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    //add client to class
    func addClientToWorkout(client: Client, workout: Workout, completion: @escaping (Error?) -> Void){
        let url = baseURL.appendingPathComponent("add").appendingPathComponent(":\(client.id)")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jE = JSONEncoder()
        
        do {
            let jsonData = try jE.encode(client)
            request.httpBody = jsonData
        } catch  {
            print("Error encoding adding client to workout by ID: \(error.localizedDescription)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let response = response as? HTTPURLResponse {
                print("This is the response we got back from the network call posting a client to a workout by id: \(response) and status: \(response.statusCode)")
                completion(NSError())
                return
            }
            
            if let error = error {
                print("Error making network call to add client to class by ID: \(error.localizedDescription)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    //DELETE WORKOUT
    func delete(workout: Workout, completion: @escaping (Error?) -> Void){
        guard let workoutToDelete = workouts.firstIndex(of: workout) else { return }
        workouts.remove(at: workoutToDelete)
        
        guard let bearer = bearer else {
            print("problem with the bearer with the delete workout function")
            completion(NSError())
            return}
        
        let url = baseURL.appendingPathComponent("\(workout.id)")
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let response = response as? HTTPURLResponse {
                print("This is the response we got back from trying to delete the workout by id: \(response) and status: \(response.statusCode)")
                completion(NSError())
                return
            }
            
            if let error = error {
                print("Error in the network call deleting workout by id: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            completion(nil)
        }.resume()
    }
 
    //DELETE WORKOUT BY INSTRUCTOR ID
    func delete(workout: Workout, with instructorID: Client, completion: @escaping (Error?) -> Void){
        guard let workoutToDelete = workouts.firstIndex(of: workout) else { return }
        workouts.remove(at: workoutToDelete)
        
        guard let bearer = bearer else {
            print("Problem withthe bearer inside the delete workout by instructor id")
            completion(NSError())
            return
        }
        
        let url = baseURL.appendingPathComponent("instructor").appendingPathComponent("\(instructorID.id)").appendingPathComponent("remove")
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
        
        //send the class you want to delete in the body of the request
        let jE = JSONEncoder()
        
        do {
            let jsonData = try jE.encode(workout)
            request.httpBody = jsonData
        } catch  {
            print("Error trying to delete the workout by instructor's id: \(error.localizedDescription)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let response =  response as? HTTPURLResponse {
                print("The response for trying to delete workout via instructors id: \(response) and status: \(response.statusCode)")
                completion(NSError())
                return
            }
            
            if let error = error {
                print("Error trying to delte the workout via instructors id: \(error.localizedDescription)")
                completion(error)
                return
            }
            completion(nil)
        }.resume()
    }
    
    //DELETE CLIENT FROM CLASS BY WORKOUT ID FOR CLIENTS_ this returns an array of classes the client is signed up for
    //send class id in the url string and the user id in the body of the request
    func delete(client: Client, fromWorkout workout: Workout, completion: @escaping (Error?) -> Void ){
        
    }
}
