//
//  createImageUrl.swift
//  flix
//
//  Created by Christian Lapinig on 2/5/20.
//  Copyright © 2020 Christian Lapinig. All rights reserved.
//

import Foundation

func createImageUrl(path: String, size: String) -> URL {
    let baseUrl = "https://image.tmdb.org/t/p/\(size)"
    let imageUrl = URL(string: baseUrl + path)
    
    return imageUrl!
}
