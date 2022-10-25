//
//  NetworkService.swift
//  AvitoTechTask
//
//  Created by Pavel on 22.10.22.
//

import Foundation

protocol NetworkOutput {
    func fetchData(completion: @escaping (CompanyModel) -> ())
}

class NetworkManager: NetworkOutput {
    // MARK: - Save date of request
    var dateOfRequest: Double? {
        get {
            UserDefaults.standard.double(forKey: "dateOfRequest")
        }
        set {
            if let new = newValue {
                UserDefaults.standard.set(new, forKey: "dateOfRequest")
            } else {
                UserDefaults.standard.removeObject(forKey: "dateOfRequest")
            }
        }
    }
    
    func fetchData( completion: @escaping (CompanyModel) -> ()) {
        guard let url = URL(string: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c") else { return }
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        
        // MARK: - If the request was more than an hour ago, then clear the cache
        if NSDate().timeIntervalSince1970 - (dateOfRequest ?? 0) > 3600 {
            URLSession.shared.configuration.urlCache?.removeAllCachedResponses()
        }
        
        if let cacheResponse = URLSession.shared.configuration.urlCache?.cachedResponse(for: request) {
            guard let result = try? JSONDecoder().decode(CompanyModel.self, from: cacheResponse.data) else { return }
            DispatchQueue.main.async {
                completion(result)
            }
        } else {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard error == nil else { return }
                guard let data = data else { return }
                do {
                    let result = try JSONDecoder().decode(CompanyModel.self, from: data)
                    DispatchQueue.main.async {
                        completion(result)
                    }
                    self?.dateOfRequest = NSDate().timeIntervalSince1970
                } catch {
                    return
                }
            }.resume()
        }
    }
}
