//
//  APICaller.swift
//  DI
//
//  Created by Kanokchai Amaphut on 10/5/2567 BE.
//

import Foundation

public class APICaller {
    public static let shared = APICaller()
    
    private init() {}
    
    public func fetchCourseName(completion: @escaping ([String]) -> Void) {
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else {
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            // Decode
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: String]] else {
                    completion([])
                    return
                }
                let name = json.compactMap({ $0["name"] })
                print(json)
                completion(name)
            } catch {
                completion([])
            }
        }
        task.resume()
    }
}
