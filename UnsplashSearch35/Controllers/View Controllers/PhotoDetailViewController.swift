//
//  PhotoDetailViewController.swift
//  UnsplashSearch35
//
//  Created by Alex Lundquist on 8/5/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController {
  
  @IBOutlet weak var largePhotoView: UIImageView!
  @IBOutlet weak var descriptionTextView: UITextView!
  
  var receivedPhotos: PhotoInfo?
  
    override func viewDidLoad() {
        super.viewDidLoad()

      updateView()
    }

  func updateView() {
    guard let receivedPhotos = receivedPhotos else { return }
    PhotoController.fetchRegularImage(from: receivedPhotos) { (result) in
      DispatchQueue.main.async {
        switch result {
          case .success(let regualar):
            print(receivedPhotos.urls.regular)
            self.largePhotoView.image = regualar
          case .failure(let error):
          print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        } //End of Switch
        self.descriptionTextView.text = self.receivedPhotos?.description ?? "I Suck and have no Detailed Description"
      }
    }
  }
}
