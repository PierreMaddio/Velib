//
//  ApiService.swift
//  Velib2
//
//  Created by Pierre on 19/06/2022.
//

import Foundation

open class ApiService {
    
    enum Constants {
        static let headerContentType = "Content-Type"
        static let contentTypeJson = "application/json"
    }
    
    enum RequestType {
        case get
        case post
    }
    
    enum ContentType {
        case json
    }
    
    enum Path{
        
        enum BaseUrl: String {
            case path = "https://opendata.paris.fr/api/records/1.0/search/?"
        }
        
        enum params: String {
            case dataSet = "dataset"
            case dataSetValue = "velib-disponibilite-en-temps-reel"
            case location = "location"
        }
    }
}

// MARK: - Private method
extension ApiService {
    func configureRequest(url: URL, requestType: RequestType) -> URLRequest {
        var request = URLRequest(url: url)
        
        switch requestType {
        case .get:
            request.httpMethod = "GET"
        case .post:
            request.httpMethod = "POST"
        }
        
        // clé API dans le header
        request.setValue(Constants.contentTypeJson, forHTTPHeaderField: Constants.headerContentType)
        
        return request
    }
}
