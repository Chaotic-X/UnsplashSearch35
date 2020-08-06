//
//  PhotoTableViewCell.swift
//  UnsplashSearch35
//
//  Created by Alex Lundquist on 8/5/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

  @IBOutlet weak var photoImageView: UIImageView!
  @IBOutlet weak var altDescriptionLabel: UILabel!
  
  var photoSearch: PhotoInfo? {
    didSet {
      updateViewWithResults()
    }
  }
  
  
  //MARK: -Helper methods
  
  func updateViewWithResults() {
    if let photoInfo = photoSearch {
      PhotoController.fetchThumbImage(from: photoInfo) { (results) in
        DispatchQueue.main.async {
          switch results {
            case .success(let thumbnail):
              self.photoImageView.image = thumbnail
            case .failure(let error):
              print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
              self.photoImageView.image = UIImage(named: "noimage")
          } //End of Switch
          self.altDescriptionLabel.text = self.photoSearch?.alt_description ?? "No Description, click cell for more details"
        }
      }
    }
  }
  
} //End of TableViewCell
