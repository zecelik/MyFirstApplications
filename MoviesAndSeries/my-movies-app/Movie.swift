//
//  Movie.swift
//  my-movies-app
//
//  Created by Zehra on 17.08.2024.
//


import UIKit

class Movie {
    var title: String
    var description: String
    var image: UIImage!
    
    init(title: String, description: String, image: UIImage) {
        self.title = title
        self.description = description
        self.image = image
    }
    
}
