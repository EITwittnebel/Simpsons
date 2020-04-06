//
//  CollectionViewController.swift
//  Simpson
//
//  Created by Field Employee on 3/28/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewController: UICollectionViewController {
  
  var charDataArray: CharDataArray?
  
  /*
  required init?(coder: NSCoder) {
    charDataArray = CharDataArray()
    super.init(coder: coder)
  }
  */
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return charDataArray?.data.count ?? 0;
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1;
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
    for item in cell.subviews {
      item.removeFromSuperview()
    }
    
    var myImage = charDataArray?.data[indexPath.row].charImage ?? UIImage(named:"placeholder.png")
    if myImage!.size.width == 1.0 {
      myImage = UIImage(named: "placeholder.png")
    }
    let myImageView = UIImageView(image: myImage)
        
    cell.addSubview(myImageView)
    cell.backgroundColor = .clear
    
    
    return cell;
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
        if let indexPath = collectionView.indexPathsForSelectedItems {
          let charData = charDataArray!.data[indexPath[0].row]
            let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
            controller.detailItem = charData
            controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            controller.navigationItem.leftItemsSupplementBackButton = true
        }
    }
  }
  
}

