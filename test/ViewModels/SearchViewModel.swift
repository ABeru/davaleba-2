//
//  SearchViewModel.swift
//  test
//
//  Created by Admin on 7/14/20.
//  Copyright © 2020 Sandro Beruashvili. All rights reserved.
//

import Foundation

class SearchViewModel {
    public var fetch = { (query: String, completion: @escaping (RESTResp1) -> ()) in
        APIService.fetchRest1(text: query) { (response) in
            completion(response)
        }
    }
}
