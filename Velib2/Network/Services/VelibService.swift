//
//  VelibService.swift
//  Velib2
//
//  Created by Pierre on 19/06/2022.
//

import Foundation

class VelibService: ApiService {
    
    func fetchData(long: String,lat: String , completion: @escaping (Velib?) -> (Void) ) {
        let urlPathStr = Path.BaseUrl.path.rawValue + Path.params.dataSet.rawValue + "=" + Path.params.dataSetValue.rawValue + "&" + Path.params.location.rawValue + "=" + "\(long),\(lat)"
        
        if let url = URL(string: urlPathStr) {
            let requestURL = self.configureRequest(url: url, requestType: .get)
            let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
                
                if let httpResponse = response as? HTTPURLResponse {
                    let decoder = JSONDecoder()
                    guard let data = data, httpResponse.statusCode == 200, let response = try? decoder.decode(Velib.self, from: data) else {
                        // Failed
                        completion(nil)
                        return
                    }
                    // success
                    completion(response)
                }
            }
            task.resume()
        }
    }
}
