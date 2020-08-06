//
//  PhotoController.swift
//  UnsplashSearch35
//
//  Created by Alex Lundquist on 8/5/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import Foundation
import class UIKit.UIImage

class PhotoController {
  
  static let baseURL = "https://api.unsplash.com/search/photos"
  static let clientID = "ZqGLzwM5ForhU4hk76q-_55PDwEZuwsJ5Uq_QDOeIKo"
  
  static func fetchSearchResults(for searchTerm: String, completion: @escaping (Result<[PhotoInfo], FetchError>) -> Void) {
    // 1 - Prepare URL
    guard let url = URL(string: baseURL),
      var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return completion(.failure(.invalidURL))}
    let clientIDQuery = URLQueryItem(name: "client_id", value: clientID)
    let photoCountQuery = URLQueryItem(name: "count", value: "10")
    let photoSearchQuery = URLQueryItem(name: "query", value: searchTerm)
    urlComponents.queryItems = [clientIDQuery, photoCountQuery, photoSearchQuery]
    guard let finalURL = urlComponents.url else { return completion(.failure(.invalidURL))}
    print("\(finalURL.absoluteString)\n\n")
    // 2 - Contact server
    URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
      // 3 - Handle errors from the server
      if let error = error {
        return completion(.failure(.thrownError(error)))
      }
      // 4 - Check for image data
      guard let data = data else { return completion(.failure(.noData))}
      // 5 - Initialize an image from the data
      do {
        let photoInfoArray = try JSONDecoder().decode(UnSplashPhotos.self, from: data)
        //        guard let info = photoInfoArray.results.description else { return completion(.failure(.noData))}
        let info = photoInfoArray.results
        return completion(.success(info))
      } catch {
        return completion(.failure(.thrownError(error)))
      }
      //6 - RESUME!!!
    }.resume() //end of URLSession
  } //End of FetchFunc
  
  static func fetchRegularImage(from searchResults: PhotoInfo, completion: @escaping (Result<UIImage, FetchError>) -> Void) {
    guard let urlRegular = URL(string: searchResults.urls.regular) else {return completion(.failure(.invalidURL))}
    URLSession.shared.dataTask(with: urlRegular) { (data, _, error) in
      if let error = error {
        return completion(.failure(.thrownError(error)))
      }
      guard let data = data else { return completion(.failure(.noData))}
      guard let regularImage = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
      return completion(.success(regularImage))
    }.resume()
  } //End of FetchRegularImage
  
  static func fetchThumbImage(from searchResults: PhotoInfo, completion: @escaping (Result<UIImage, FetchError>) -> Void) {
    guard let urlRegular = URL(string: searchResults.urls.regular) else {return completion(.failure(.invalidURL))}
    URLSession.shared.dataTask(with: urlRegular) { (data, _, error) in
      if let error = error {
        return completion(.failure(.thrownError(error)))
      }
      guard let data = data else { return completion(.failure(.noData))}
      guard let thumbImage = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
      return completion(.success(thumbImage))
    }.resume()
  } //End of FetchRegularImage
} //End of Class

