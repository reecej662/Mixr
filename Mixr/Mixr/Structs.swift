//
//  Structs.swift
//  Mixr
//
//  Created by Reece Jackson on 9/5/15.
//  Copyright (c) 2015 RJ. All rights reserved.
//

import Foundation
import UIKit

struct Ingredient {
    var name:String
    var image:UIImage
    
    init(name: String, image: UIImage) {
        self.name = name
        self.image = image
    }
}