//
//  HTTPClient.swift
//  ODAtlas3D
//
//  Created by Matias Schmid on 19/4/22.
//

import Foundation

class HTTPClient: ObservableObject {
    @Published private(set) var providers: [Provider] = []
    
    func getAppServiceProviders(withURL: String) {
        guard let url = URL(string: withURL) else {
            fatalError("Missing URL for getting providers information.")
        }
        
        let req = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: req) {(data, response, error) in

            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let jsonProvidersResponse = response as? HTTPURLResponse else {return}
            
            if jsonProvidersResponse.statusCode == 200 {
                guard let data = data else {return}
                DispatchQueue.main.async {
                    do {
                        let decodedProviders = try JSONDecoder().decode([Provider].self, from: data)
                        self.providers = decodedProviders
                        print(decodedProviders)
                    } catch let error {
                        print("Error decoding response", error)
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    /*func getUsers(withURL: String) {
        guard let url = URL(string: withURL) else {
            fatalError("Missing URL for request.")
        }
        
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
                        let decodedUsers = try dataDecoder.decode(Root.self, from: Data(jsonData)).providers
                        self.providers = decodedUsers
                        print(decodedUsers)
                    } catch let error {
                        print("Error decoding response", error)
                    }
                }
            }
        }
        dataTask.resume()
    }*/
}
