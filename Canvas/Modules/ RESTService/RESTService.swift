//
//  RESTService.swift
//  REST-Service
//
//  Created by Danilo Henrique on 15/04/24.
//

import Foundation
import UIKit.UIImage

class RESTService<T: RESTRequest> {
    
    //MARK: - Public Functions
    
    func request<U: Decodable>(_ request: T, completion: @escaping (Result<U, Error>) -> Void) {
        let urlRequest: URLRequest
        do {
            urlRequest = try createURLRequest(with: request)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    do {
                        let object = try JSONDecoder().decode(U.self, from: data)
                        completion(.success(object))
                    } catch {
                        print(response)
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(error ?? NSError()))
                }
            }
        }.resume()
    }
    
    func requestImage(urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(RESTError.failedToCreateURL))
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    completion(.success(image))
                } else {
                    completion(.failure(RESTError.failedToCreateImage))
                }
            }
        }.resume()
    }

    //MARK: - Private Functions
    
    private func createURLRequest(with request: T) throws -> URLRequest {
        let url: URL
        do {
            url = try createURL(with: request)
        } catch {
            throw error
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        return urlRequest
    }
    
    private func createURL(with request: T) throws -> URL {
        var urlComponents = URLComponents(string: request.baseURL)
        urlComponents?.path = request.path
        urlComponents?.queryItems = request.queryItems

        if let url = urlComponents?.url {
            return url
        } else {
            throw RESTError.failedToCreateURL
        }
    }
}
