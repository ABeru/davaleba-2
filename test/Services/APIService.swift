//
//  APIService.swift
//  test
//
//  Created by Admin on 7/14/20.
//  Copyright © 2020 Sandro Beruashvili. All rights reserved.
//

import Foundation

class APIService {
    
    // NEARBY RESTAURANTS
    static func fetchRest(lat: String, lng: String, completion: @escaping (RestResp) -> ()) {
        guard let url = URL(string: "https://developers.zomato.com/api/v2.1/geocode?lat=\(lat)&lon=\(lng)") else {return}
        let api = "09d7384065aad8a2a082b8224adb5b5b"
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(api, forHTTPHeaderField: "user-key")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, res, err) in
            
            guard let data = data else {return}
            //  print(data)
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(RestResp.self, from: data)
                
                
                completion(response)
            } catch let err {
                debugPrint(err)
            }
        }.resume()
    }
    
    // SEARCH RESTAURANTS
    static func fetchRest1(text: String, completion: @escaping (RESTResp1) -> ()) {
        guard let url = URL(string: "https://developers.zomato.com/api/v2.1/search?q=\(text)") else {return}
        let api = "09d7384065aad8a2a082b8224adb5b5b"
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(api, forHTTPHeaderField: "user-key")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, res, err) in
            
            guard let data = data else {return}
            //  print(data)
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(RESTResp1.self, from: data)
                
                
                completion(response)
            } catch let err {
                debugPrint(err)
            }
        }.resume()
    }
    
    // FAVORITES
    static func fetchRestFav(id: Int32, completion: @escaping (Restaurant) -> ()) {
        guard let url = URL(string: "https://developers.zomato.com/api/v2.1/restaurant?res_id=\(id)"
            ) else {return}
        let api = "09d7384065aad8a2a082b8224adb5b5b"
        
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(api, forHTTPHeaderField: "user-key")
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, res, err) in
            
            guard let data = data else {return}
            //  print(data)
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Restaurant.self, from: data)
                
                
                completion(response)
            } catch let err {
                print(err.localizedDescription)
            }
        }.resume()
    }
    
}
