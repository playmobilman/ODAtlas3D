//
//  HTTPClient.swift
//  ODAtlas3D
//
//  Created by Matias Schmid on 19/4/22.
//

import Foundation

class HTTPClient: ObservableObject {
    @Published var users: [User] = []
    
    func getUsers(withURL: String) {
        guard let url = URL(string: "https://1229955b-4fc3-4907-9183-79684c64bc90.mock.pstmn.io/users") else { fatalError("Missing URL for request.") }
        
        let req = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: req) {(data, response, error) in
            
            guard let jsonData = data else { return }
            
            print(String(data: jsonData, encoding: .utf8)!)
            
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                
                DispatchQueue.main.async {
                    do {
                        let dataDecoder = JSONDecoder()
                        dataDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        let decodedUsers = try dataDecoder.decode(Root.self, from: Data(jsonData)).users
                        //let convertedUsers: [User] = [decodedUsers]
                        self.users = decodedUsers
                        print(decodedUsers)
                    } catch let error {
                        print("Error decoding response", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
