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
    //dataForCharacter.charImage =
    
    data.append(dataForCharacter)
  }
  
  //Right now we only get the first 20 chars, hopefully that is enough
  func parseData(_ apiCallResults: JSON) {
    let characters = apiCallResults["RelatedTopics"]
    for index in 0..<20 {
      parseSingleCharacter(characters[index])
    }
  }
}
