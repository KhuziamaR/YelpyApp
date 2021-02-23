//
//  File.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import Foundation


struct API {
    

    
    static func getRestaurants(completion: @escaping ([[String:Any]]?) -> Void) {
        
        // ––––– TODO: Add your own API key!
        let apikey = "W4NcBj0HzZzLfkKq81ZIaWDYw5cULuK7ozfx1b_qXsoX4IN1CKCPHELjAx7jWFaLwWofF8yynr_AFzBOhFu4r66GXu0x8vGbE25NfOD8Elhc-JuhRqGt0eWJXzA1YHYx"
        
        // Coordinates for San Francisco
        let lat = 37.773972
        let long = -122.431297
        
        
        let url = URL(string: "https://api.yelp.com/v3/transactions/delivery/search?latitude=\(lat)&longitude=\(long)")!
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        // Insert API Key to request
        request.setValue("Bearer \(apikey)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                
        

                // ––––– TODO: Get data from API and return it using completion
//                print(data)
                // 1. convert json reponse to dictionary
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                // 2. grab the business data and convert it to an array of dictionaries for each restaurant
                let restaurants = dataDictionary["businesses"] as! [[String: Any]]
                print("START RESTAURANT")
                print(restaurants)
                print("END RESTAURANT")
                // 3. completion is an escaping method which allows the data to be used outside of the closure
                return completion(restaurants)
                
                }
            }
        
            task.resume()
        
        }
    }

    
