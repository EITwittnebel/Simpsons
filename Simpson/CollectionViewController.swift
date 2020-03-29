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
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 12;
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1;
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
    
    let myImage = UIImage(named: "test.jpg")
    let myImageView = UIImageView(image: myImage)
    //let testImage = UIImage(named: "test.jpg")
    //let mytestView = UIImageView(image: testImage)
    //print(cell.center.x)
    //print(cell.center.y)
    //if (indexPath.row == 3) {
    //  myImageView.frame = CGRect(x: cell.center.x-25.0, y: cell.center.y-25.0, width: 50, height: 50)
    //  myImageView.image = myImage
    //}
    cell.addSubview(myImageView)
    cell.backgroundColor = .cyan
    
    return cell;
  }
  
}

