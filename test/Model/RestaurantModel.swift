//
//  RestaurantModel.swift
//  test
//
//  Created by Sandro Beruashvili on 7/5/20.
//  Copyright © 2020 Sandro Beruashvili. All rights reserved.
//



// MARK: - RESTResp

import Foundation
class Locations {
    static let sharedInstance = Locations()
    var array = [(Double,Double,String,String)]()
    
}
struct RestResp: Codable {
    let location: RESTRespLocation
    let popularity: Popularity
    let link: String
    let nearbyRestaurants: [NearbyRestaurant]
    
    enum CodingKeys: String, CodingKey {
        case location, popularity, link
        case nearbyRestaurants = "nearby_restaurants"
       
    }
}

// MARK: - Popularity
struct Popularity: Codable {
    let popularity, nightlifeIndex: String
    let topCuisines: [String]

    enum CodingKeys: String, CodingKey {
        case popularity
        case nightlifeIndex = "nightlife_index"
        case topCuisines = "top_cuisines"
    }
}


// MARK: - RESTRespLocation
struct RESTRespLocation: Codable {
    let entityType: String
    let entityID: Int
    let title, latitude, longitude: String
    let cityID: Int
    let cityName: String
    let countryID: Int
    let countryName: String

    enum CodingKeys: String, CodingKey {
        case entityType = "entity_type"
        case entityID = "entity_id"
        case title, latitude, longitude
        case cityID = "city_id"
        case cityName = "city_name"
        case countryID = "country_id"
        case countryName = "country_name"
    }
}

// MARK: - NearbyRestaurant
struct NearbyRestaurant: Codable {
    let restaurant: Restaurant
}

// MARK: - Restaurant
struct Restaurant: Codable {
    let r: R
    let apikey, id, name: String
    let url: String
    let location: RestaurantLocation
    let switchToOrderMenu: Int
    let cuisines: String
    let averageCostForTwo, priceRange: Int
    let currency: String
   
    let opentableSupport, isZomatoBookRes: Int
    let mezzoProvider: String
    let isBookFormWebView: Int
    let bookFormWebViewURL, bookAgainURL: String
    let thumb: String
    let userRating: UserRating
    let photosURL, menuURL: String
    let featuredImage: String
    let hasOnlineDelivery, isDeliveringNow: Int
    let storeType: String
    let includeBogoOffers: Bool
    let deeplink: String
    let isTableReservationSupported, hasTableBooking: Int
    let eventsURL: String

    enum CodingKeys: String, CodingKey {
        case r = "R"
        case apikey, id, name, url, location
        case switchToOrderMenu = "switch_to_order_menu"
        case cuisines
        case averageCostForTwo = "average_cost_for_two"
        case priceRange = "price_range"
        case currency
        case opentableSupport = "opentable_support"
        case isZomatoBookRes = "is_zomato_book_res"
        case mezzoProvider = "mezzo_provider"
        case isBookFormWebView = "is_book_form_web_view"
        case bookFormWebViewURL = "book_form_web_view_url"
        case bookAgainURL = "book_again_url"
        case thumb
        case userRating = "user_rating"
        case photosURL = "photos_url"
        case menuURL = "menu_url"
        case featuredImage = "featured_image"
        case hasOnlineDelivery = "has_online_delivery"
        case isDeliveringNow = "is_delivering_now"
        case storeType = "store_type"
        case includeBogoOffers = "include_bogo_offers"
        case deeplink
        case isTableReservationSupported = "is_table_reservation_supported"
        case hasTableBooking = "has_table_booking"
        case eventsURL = "events_url"
    }
}
    
// MARK: - R
struct R: Codable {
    let hasMenuStatus: HasMenuStatus
   
    let resID: Int
    enum CodingKeys: String, CodingKey {
        case hasMenuStatus = "has_menu_status"
        
        case resID = "res_id"
    }
}

// MARK: - HasMenuStatus
struct HasMenuStatus: Codable {
    let delivery: Int
    let takeaway: Int
}

// MARK: - UserRating
struct UserRating: Codable {
    let aggregateRating: String
    let ratingColor: String
    let ratingObj: RatingObject
    let ratingText: String
    let votes: Int
    
    enum CodingKeys: String, CodingKey {
        case aggregateRating = "aggregate_rating"
        case ratingColor = "rating_color"
        case ratingObj = "rating_obj"
        case ratingText = "rating_text"
        case votes
    }
}

// MARK: - RatingObject
struct RatingObject: Codable {
    let bgColor: BGColor
    
    enum CodingKeys: String, CodingKey {
        case bgColor = "bg_color"
    }
}

// MARK: - BGColor
struct BGColor: Codable {
    let tint: String
    let type: String
}

// MARK: - RestaurantLocation
struct RestaurantLocation: Codable {
    let address: String
    let city: String
    let city_id: Int
    let country_id: Int
    let latitude: String
    let locality: String
    let locality_verbose: String
    let longitude: String
    let zipcode: String
}

struct RESTResp1: Codable {
    let resultsFound, resultsStart, resultsShown: Int
    let restaurants: [RestaurantElement]

    enum CodingKeys: String, CodingKey {
        case resultsFound = "results_found"
        case resultsStart = "results_start"
        case resultsShown = "results_shown"
        case restaurants
    }
}

// MARK: - RestaurantElement
struct RestaurantElement: Codable {
    let restaurant: Restaurant1
}

// MARK: - RestaurantRestaurant
struct Restaurant1: Codable {
    let r: R1
    let apikey, id, name: String
    let url: String
    let location: Location
    let switchToOrderMenu: Int
    let cuisines, timings: String
    let averageCostForTwo, priceRange: Int
    let currency: String
    let highlights: [String]
    let opentableSupport, isZomatoBookRes: Int
    let mezzoProvider: String
    let isBookFormWebView: Int
    let bookFormWebViewURL, bookAgainURL: String
    let thumb: String
    let userRating: UserRating1
    let allReviewsCount: Int
    let photosURL: String
    let photoCount: Int
    let menuURL: String
    let featuredImage: String
    let hasOnlineDelivery, isDeliveringNow: Int
    let storeType: String
    let includeBogoOffers: Bool
    let deeplink: String
    let isTableReservationSupported, hasTableBooking: Int
    let eventsURL: String
    let phoneNumbers: String
    let establishment: [String]
    let orderURL: String?
    let orderDeeplink: String?

    enum CodingKeys: String, CodingKey {
        case r = "R"
        case apikey, id, name, url, location
        case switchToOrderMenu = "switch_to_order_menu"
        case cuisines, timings
        case averageCostForTwo = "average_cost_for_two"
        case priceRange = "price_range"
        case currency, highlights
        case opentableSupport = "opentable_support"
        case isZomatoBookRes = "is_zomato_book_res"
        case mezzoProvider = "mezzo_provider"
        case isBookFormWebView = "is_book_form_web_view"
        case bookFormWebViewURL = "book_form_web_view_url"
        case bookAgainURL = "book_again_url"
        case thumb
        case userRating = "user_rating"
        case allReviewsCount = "all_reviews_count"
        case photosURL = "photos_url"
        case photoCount = "photo_count"
        case menuURL = "menu_url"
        case featuredImage = "featured_image"
        case hasOnlineDelivery = "has_online_delivery"
        case isDeliveringNow = "is_delivering_now"
        case storeType = "store_type"
        case includeBogoOffers = "include_bogo_offers"
        case deeplink
        case isTableReservationSupported = "is_table_reservation_supported"
        case hasTableBooking = "has_table_booking"
        case eventsURL = "events_url"
        case phoneNumbers = "phone_numbers"
        case establishment
        case orderURL = "order_url"
        case orderDeeplink = "order_deeplink"
    }
}



// MARK: - Location
struct Location: Codable {
    let address, locality, city: String
    let cityID: Int
    let latitude, longitude, zipcode: String
    let countryID: Int
    let localityVerbose: String

    enum CodingKeys: String, CodingKey {
        case address, locality, city
        case cityID = "city_id"
        case latitude, longitude, zipcode
        case countryID = "country_id"
        case localityVerbose = "locality_verbose"
    }
}

// MARK: - R
struct R1: Codable {
    let hasMenuStatus: HasMenuStatus1
    let resID: Int
    let isGroceryStore: Bool

    enum CodingKeys: String, CodingKey {
        case hasMenuStatus = "has_menu_status"
        case resID = "res_id"
        case isGroceryStore = "is_grocery_store"
    }
}

// MARK: - HasMenuStatus
struct HasMenuStatus1: Codable {
    let delivery, takeaway: Int
}

// MARK: - UserRating
struct UserRating1: Codable {
    
    let ratingText, ratingColor: String
    let ratingObj: RatingObj
    let votes: Int

    enum CodingKeys: String, CodingKey {
       
        case ratingText = "rating_text"
        case ratingColor = "rating_color"
        case ratingObj = "rating_obj"
        case votes
    }
}


// MARK: - RatingObj
struct RatingObj: Codable {
    let title: Title
    let bgColor: BgColor

    enum CodingKeys: String, CodingKey {
        case title
        case bgColor = "bg_color"
    }
}

// MARK: - BgColor
struct BgColor: Codable {
    let type, tint: String
}

// MARK: - Title
struct Title: Codable {
    let text: String
}
