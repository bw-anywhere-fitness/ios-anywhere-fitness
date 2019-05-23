//
//  ClientController.swift
//  Anywhere Fitness
//
//  Created by Michael Flowers on 5/22/19.
//  Copyright © 2019 Michael Flowers. All rights reserved.
//

import Foundation

class ClientController {
    
    var clients: [Client] = []
    var bearer: Bearer?
    //get the base url
    private let baseURL = URL(string: "https://anywhere-fitness.herokuapp.com/")!
    
    func signUp(client: Client, completion: @escaping (Error?) -> Void){
        //endpoints are /auth/register
        let endPointUrl = baseURL.appendingPathComponent("auth").appendingPathComponent("register")
        
        //post the information to the api
        var request = URLRequest(url: endPointUrl)
        request.httpMethod = "POST"
        //do i need to set value for the the http header?
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let je = JSONEncoder()
        
        do {
            let jsonData = try je.encode(client)
            request.httpBody = jsonData
        } catch  {
            print("Encoding httpBody: \(error.localizedDescription)")
            completion(error)
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("error with network call to post client: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("problem with data: \(NSError())")
                completion(NSError())
                return }
            
            //the data we are getting back per the api should be the token
            let jD = JSONDecoder()
            
            do {
                self.bearer = try jD.decode(Bearer.self, from: data)
                print("this is the bearer: \(self.bearer?.token)")
            } catch {
                print("Error decoding the data: \(error.localizedDescription)")
                completion(error)
                return
            }
            completion(nil)
            }.resume()
    }
    
    
    func signIn(with client: Client, completion: @escaping (Error?) -> Void ){
        //get the base url
        let url = baseURL.appendingPathComponent("auth").appendingPathComponent("login")
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jE = JSONEncoder()
        
        do {
            let jsonData = try jE.encode(client)
            request.httpBody = jsonData
        } catch  {
            print("Error decoding the client while signing in: \(error.localizedDescription)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("error with network call to post client: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("problem with data: \(NSError())")
                completion(NSError())
                return }
            
            //the data we are getting back per the api should be the token
            let jD = JSONDecoder()
            
            do {
                self.bearer = try jD.decode(Bearer.self, from: data)
                print("this is the bearer: \(self.bearer?.token)")
            } catch {
                print("Error decoding the data: \(error.localizedDescription)")
                completion(error)
                return
            }
            completion(nil)
            }.resume()
    }
    
    //GET CLIENTS BY WORKOUT ID
    func fetch(clients: Client, by workoutID: Workout, completion: @escaping ([Client]?, Error?) -> Void ){
        guard let bearer = bearer else {
            print("problem with the bearer")
            completion(nil,NSError())
            return}
        
        let url = baseURL.appendingPathComponent("\(workoutID.id)").appendingPathComponent("list")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print("The response from fetching clients by workoutID: \(response) and status: \(response.statusCode)")
                completion(nil, NSError())
                return
            }
            
            if let error = error {
                print("Error inside the data task session for fetching clients by workoutID: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                print("Error with the data inside the fetch clients via workoutID function")
                completion(nil, NSError())
                return
            }
            
            let jD = JSONDecoder()
            
            do {
                let clients = try jD.decode([Client].self, from: data)
                completion(clients, nil)
            } catch {
                print("Error decoding the clients we got back from fetching clients function via workoutID: \(error.localizedDescription)")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
   
    //this might need to go in the client controller
    //DELETE CLIENT FROM CLASS BY WORKOUT ID FOR CLIENTS_ this returns an array of classes the client is signed up for
    //send class id in the url string and the user id in the body of the request
    func delete(client: Client, fromWorkout workout: Workout, completion: @escaping (Error?) -> Void ){
        guard let clientToDelete = clients.firstIndex(of: client) else { return }
        clients.remove(at: clientToDelete)
        
        guard let bearer = bearer else {
            print("Problem withthe bearer inside the delete workout by instructor id")
            completion(NSError())
            return
        }
        
        let url = baseURL.appendingPathComponent("remove").appendingPathComponent("\(workout.id)").appendingPathComponent("client")
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
        
        let jE = JSONEncoder()
        
        do {
            let jsonData =  try jE.encode(client.id)
            request.httpBody = jsonData
        } catch  {
            print("error encoding the client to delete using its workoutID: \(error.localizedDescription)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let response = response as? HTTPURLResponse {
                print("Response from trying to delete client by workoutID is: \(response) and status: \(response.statusCode)")
                completion(NSError())
                return
            }
            
            if let error = error {
                print("Error making network call trying to delete client via workoutID: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            completion(nil)
            }.resume()
    }
    
    //DELETE CLIENT FROM WORKOUT BY WORKOUT ID FOR INSTRUCTORS
    //SEND WORKOUT ID IN THE URL STRING AND THE USER ID IN THE BODY OF THE REQUEST
    
    func deleteClientFromClass(client: Client, fromClass theClass: Workout, completion: @escaping (Error?) -> Void ){
        guard let clientToDelete = clients.firstIndex(of: client) else { return }
        clients.remove(at: clientToDelete)
        
        guard let bearer = bearer else {
            print("Problem withthe bearer inside the delete workout by instructor id")
            completion(NSError())
            return
        }
        
        let url = baseURL.appendingPathComponent("remove").appendingPathComponent("\(theClass.id)").appendingPathComponent("instructor")
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("\(bearer.token)", forHTTPHeaderField: "Authorization")
        
        let jE = JSONEncoder()
        
        do {
            let jsonData =  try jE.encode(client.id)
            request.httpBody = jsonData
        } catch  {
            print("error encoding the client to delete using its theClassID: \(error.localizedDescription)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, response, error) in
            if let response = response as? HTTPURLResponse {
                print("Response from trying to delete client by theClassID is: \(response) and status: \(response.statusCode)")
                completion(NSError())
                return
            }
            
            if let error = error {
                print("Error making network call trying to delete client via theClassID: \(error.localizedDescription)")
                completion(error)
                return
            }
            
            completion(nil)
            }.resume()
    }
}
