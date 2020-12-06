//
//  View+Hide.swift
//  Pokedex-SwiftUI
//
//  Created by Giovanni Catania on 06/12/20.
//

import SwiftUI

extension View {
    func hide(if condition: Bool) -> some View {
        condition ? self.hidden() as? Self ?? self : self
    }
}
