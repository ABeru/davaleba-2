//
//  NearByViewModel.swift
//  test
//
//  Created by Admin on 7/14/20.
//  Copyright © 2020 Sandro Beruashvili. All rights reserved.
//

import Foundation

class NearByViewModel {
    public var fetch = { (lat: Double, lng: Double, completion: @escaping (RestResp) -> ()) in
        
        let lt = String(lat)
        let ln = String(lng)
        
        APIService.fetchRest(lat: lt, lng: ln) { response in
            completion(response)
        }
    }
}
