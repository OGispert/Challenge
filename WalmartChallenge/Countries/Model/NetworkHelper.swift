//
//  NetworkHelper.swift
//  WalmartChallenge
//
//  Created by ogisq on 8/25/22.
//

import Foundation

struct NetworkHelper {
    static func getCountries(completion: @escaping (Countries?, Error?) -> Void) {
        guard let url = URL(string: Constants.countriesURL) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            if error == nil {
                if let object = try? JSONDecoder().decode(Countries.self, from: data) {
                    completion(object, nil)
                }
            } else {
                completion(nil, error)
            }
        }.resume()
    }
}
