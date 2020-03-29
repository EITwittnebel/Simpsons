//
//  DetailViewController.swift
//  Simpson
//
//  Created by Field Employee on 3/26/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController {

  @IBOutlet weak var detailDescriptionLabel: UILabel!
  @IBOutlet weak var charImage: UIImageView!
  
  //var imageToDisplay: UIImage?
  
  func configureView() {
    // Update the user interface for the detail item.
    if let detail = detailItem {
      if let label = detailDescriptionLabel {
        label.text = detail.charDescription
        charImage.image = detail.charImage
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    configureView()
  }

  var detailItem: CharData? {
    didSet {
        // Update the view.
        configureView()
    }
  }


}

