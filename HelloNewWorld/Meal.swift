//
//  Meal.swift
//  HelloNewWorld
//
//  Created by Andrew Allen on 28/07/2020.
//  Copyright © 2020 Andrew Allen. All rights reserved.
//

import UIKit

class Meal {
    
    // MARK: Properties
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Initialisation
    init?(name: String, photo: UIImage?, rating: Int) {
        
        // name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // rating must be between 0 and 5 inclusive
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        // initialise the stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
        
    }
}
