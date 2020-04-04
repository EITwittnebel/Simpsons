//
//  MasterViewController.swift
//  Simpson
//
//  Created by Field Employee on 3/26/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import UIKit
import SwiftyJSON

class MasterViewController: UITableViewController {

  var detailViewController: DetailViewController? = nil
  var objects = [Any]()
  var charDataArray : CharDataArray

  required init?(coder: NSCoder) {
    charDataArray = CharDataArray()
    super.init(coder: coder)
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let NUMCHARS: Int = 56
    let url = URL(string: "https://api.duckduckgo.com/?q=simpsons+characters&format=json")
    
    
    //Do an API call, get the JSON
    let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
      let json: JSON = JSON(data)
      //print(json["RelatedTopics"][0])
      //Parse the JSON into charData so that we dont need multiple API calls
      self.charDataArray.parseData(json, numChars: NUMCHARS)
      
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    })
    task.resume()
    
    // Do any additional setup after loading the view.
    //navigationItem.leftBarButtonItem = editButtonItem

    let addButton = UIBarButtonItem()
    addButton.action = #selector(insertNewObject(_:))
    addButton.title = "Faces"
    addButton.target = self
    //let addButton = UIBarButtonItem(barButtonSystemItem: ,target: self, action: #selector(insertNewObject(_:)))
    navigationItem.rightBarButtonItem = addButton
    if let split = splitViewController {
        let controllers = split.viewControllers
        detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
    }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
    super.viewWillAppear(animated)
  }

  @objc
  func insertNewObject(_ sender: Any) {
    //objects.insert(NSDate(), at: 0)
    //let indexPath = IndexPath(row: charDataArray.data.count, section: 0)
    //tableView.insertRows(at: [indexPath], with: .automatic)
    
    let vc = storyboard?.instantiateViewController(identifier: "collection") as! CollectionViewController
    
    var charsWithFaces: CharDataArray = CharDataArray()
    for item in charDataArray.data {
      if item.charImage != UIImage(named: "placeholder.png") {
        charsWithFaces.data.append(item)
      }
    }
    
    vc.charDataArray = charsWithFaces
    navigationController?.pushViewController(vc, animated: true)
  }

  // MARK: - Segues

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let charData = charDataArray.data[indexPath.row]
        let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
        controller.detailItem = charData
        controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        controller.navigationItem.leftItemsSupplementBackButton = true
        detailViewController = controller
      }
    }
  }

  // MARK: - Table View

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return charDataArray.data.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    //let object = objects[indexPath.row] as! NSDate
    //cell.textLabel!.text = object.description
    
    cell.textLabel!.text = charDataArray.data[indexPath.row].charName
    return cell
  }

  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }
/*
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        objects.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
  }
*/

}

