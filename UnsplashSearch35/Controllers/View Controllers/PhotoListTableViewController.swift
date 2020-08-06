//
//  PhotoListTableViewController.swift
//  UnsplashSearch35
//
//  Created by Alex Lundquist on 8/5/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import UIKit

class PhotoListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? PhotoTableViewCell else { return UITableViewCell()}
      cell.photoImageView.image = UIImage(named: "noimage")
      cell.altDescriptionLabel.text = "reflection of a castle surrounded with fogs"
      
        // Configure the cell...

        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   //Setting Custom Back Button Text
   navigationItem.backBarButtonItem = UIBarButtonItem(
   title: "Back", style: .plain, target: nil, action: nil)
   if segue.indentifier == "toDevailVC"
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
