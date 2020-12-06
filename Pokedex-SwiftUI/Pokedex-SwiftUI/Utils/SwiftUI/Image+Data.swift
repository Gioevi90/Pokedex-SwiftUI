//
//  Image+Data.swift
//  Pokedex-SwiftUI
//
//  Created by Giovanni Catania on 06/12/20.
//

import SwiftUI

extension Image {
    static func initialize(data: Data) -> Image {
        UIImage(data: data).map(Image.init) ?? Image("Placeholder")
    }
}
