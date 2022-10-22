//
//  NetworkService.swift
//  AvitoTechTask
//
//  Created by Pavel on 22.10.22.
//

import Foundation

protocol NetworkService {
    func fetchData(completion: @escaping (CompanyModel) -> ())
    var companyModel: CompanyModel? { get set }
    var errorMessage: (_ message: String) -> ()  { get set }
}

class NetworkManager: NetworkService {
    var errorMessage = {(message : String) -> () in }
    var companyModel: CompanyModel?
    
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
    
    func fetchData(completion: @escaping (CompanyModel) -> ()) {
        guard let url = URL(string: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c") else { return }
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        
        // MARK: - If the request was more than an hour ago, then clear the cache
        if NSDate().timeIntervalSince1970 - (dateOfRequest ?? 0) > 3600 {
            URLSession.shared.configuration.urlCache?.removeAllCachedResponses()
        }
        
        if let cacheResponse = URLSession.shared.configuration.urlCache?.cachedResponse(for: request) {
            do {
                self.companyModel = try JSONDecoder().decode(CompanyModel.self, from: cacheResponse.data)
                print("Fetched data from cache")
                return
            } catch {
                print(error)
                return
            }
        } else {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard error == nil else {
                    self?.errorMessage(error.debugDescription)
                    return
                }
                guard let data = data else { return }
                do {
                    self?.companyModel = try JSONDecoder().decode(CompanyModel.self, from: data)
                    DispatchQueue.main.async {
                        completion((self?.companyModel)!)
                    }
                    self?.dateOfRequest = NSDate().timeIntervalSince1970
                    print("Fetched data from server")
                } catch {
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
}
