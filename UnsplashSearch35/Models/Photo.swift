//
//  Photo.swift
//  UnsplashSearch35
//
//  Created by Alex Lundquist on 8/5/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import Foundation

struct UnSplashPhotos: Decodable {
  let results: [PhotoInfo]
}

struct PhotoInfo: Decodable {
  let urls: ImageURLs
  let user: Users
  let description: String?
  let alt_description: String?
}

struct ImageURLs: Decodable {
  let thumb: String
  let regular: String
}

struct Users: Decodable {
  let first_name: String?
  let last_name: String?
}
