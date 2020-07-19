//
//  FavoriteViewModel.swift
//  test
//
//  Created by Admin on 7/14/20.
//  Copyright © 2020 Sandro Beruashvili. All rights reserved.
//

import Foundation

class FavoriteViewModel {
    public var fetch = { (id: Int32, completion: @escaping (Restaurant) -> ()) in
        APIService.fetchRestFav(id: id) { response in
            completion(response)
        }
    }
}
