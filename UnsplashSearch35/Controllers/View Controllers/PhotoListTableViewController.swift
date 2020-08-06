//
//  PhotoListTableViewController.swift
//  UnsplashSearch35
//
//  Created by Alex Lundquist on 8/5/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import UIKit

class PhotoListTableViewController: UITableViewController {
  
  @IBOutlet weak var photoSearchBar: UISearchBar!
  
  var photos: [PhotoInfo] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    photoSearchBar.delegate = self
  }
  
  // MARK: - Table view data source
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return photos.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoTableViewCell else { return UITableViewCell()}
    let photos = self.photos[indexPath.row]
    cell.photoSearch = photos
    return cell
  }
  
  
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //Setting Custom Back Button Text
    navigationItem.backBarButtonItem = UIBarButtonItem(
      title: "Back", style: .plain, target: nil, action: nil)
    if segue.identifier == "toDetailVC" {
      guard let indexPath = tableView.indexPathForSelectedRow,
        let destinationVC = segue.destination as? PhotoDetailViewController else { return }
      let photoToSend = photos[indexPath.row]
      print(photoToSend)
      destinationVC.receivedPhotos = photoToSend
    }
  } //End of Segue
  
  
}

//MARK: -Extensions
extension PhotoListTableViewController: UISearchBarDelegate {
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    guard let searchTerm = photoSearchBar.text, !searchTerm.isEmpty else { return }
    PhotoController.fetchSearchResults(for: searchTerm) { (results) in
      DispatchQueue.main.async {
        switch results {
          case .success(let photos):
            self.photos = photos
            self.tableView.reloadData()
          case .failure(let error):
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
      }
    }
  }
}
