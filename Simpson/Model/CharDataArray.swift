//
//  CharDataArray.swift
//  Simpson
//
//  Created by Field Employee on 3/28/20.
//  Copyright © 2020 Field Employee. All rights reserved.
//

import Foundation
import SwiftyJSON

class CharDataArray {
  var data: [CharData]
  
  init() {
    data = []
  }
  
  func parseSingleCharacter(_ charJSON: JSON) {
    let dataForCharacter: CharData = CharData()
    
    let description: String = charJSON["Text"].stringValue
    var nameLength: Int = 0
    
    for char in description {
      if char == "-" {
        break
      } else {
        nameLength += 1
      }
    }
    
    dataForCharacter.charDescription = description
    dataForCharacter.charName = String(description[description.startIndex..<description.index(description.startIndex, offsetBy: nameLength)])
    
    if (charJSON["Icon"]["URL"].stringValue == "") {
      dataForCharacter.charImage = UIImage(named: "placeholder.png")
      data.append(dataForCharacter)
    } else {
      let picURL = URL(string: charJSON["Icon"]["URL"].stringValue)
    
      if (picURL == nil) {
        dataForCharacter.charImage = UIImage(named: "placeholder.png")
      } else {
        let session = URLSession(configuration: .default)
        let downloadPicTask = session.dataTask(with: picURL!) { (data, response, error) in
          // The download has finished.
          if let e = error {
            print("Error downloading picture: \(e)")
          } else {
            // No errors found.
            // It would be weird if we didn't have a response, so check for that too.
            if let res = response as? HTTPURLResponse {
              print("Downloaded picture with response code \(res.statusCode)")
              if let imageData = data {
                let image = UIImage(data: imageData)
                if (image!.size.width == 1.0) {
                  dataForCharacter.charImage = UIImage(named: "placeholder.png")
                } else {
                  dataForCharacter.charImage = image
                }
              } else {
                print("Couldn't get image: Image is nil")
              }
            } else {
              print("Couldn't get response code for some reason")
            }
          }
        }
        downloadPicTask.resume()
        data.append(dataForCharacter)
      }
    }
  }
  
  func parseData(_ apiCallResults: JSON, numChars: Int) {
    let characters = apiCallResults["RelatedTopics"]
    for index in 0..<numChars {
      parseSingleCharacter(characters[index])
    }
  }
}
