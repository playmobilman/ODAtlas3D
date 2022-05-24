//
//  User.swift
//  ODAtlas3D
//
//  Created by Matias Schmid on 19/4/22.
//

import Foundation

struct Root: Codable {
    let users: [User]
}

struct User: Codable {
    let username: String
    let email: String
    let portalid: String
    let customerid: String
    let apikey: String
    
    enum CodingKeys: String, CodingKey {
        case username = "username"
        case email = "email"
        case portalid = "portalid"
        case customerid = "customerid"
        case apikey = "apikey"
    }
}

/*struct User: Identifiable, Decodable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var address: Address
    var phone: String
    var website: String
    var company: Company
}*/

// Address
/*struct Address:Decodable {
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo: Geo
}*/

// Geolocalization
/*struct Geo:Decodable {
    var lat: String
    var lng: String
}*/

// Company
/*struct Company: Decodable {
    var name: String
    var catchPhrase: String
    var bs: String
}*/


