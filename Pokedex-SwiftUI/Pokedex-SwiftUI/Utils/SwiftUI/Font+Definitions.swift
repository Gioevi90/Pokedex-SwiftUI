import SwiftUI

extension Font {
    static func light(size: CGFloat) -> Font? {
        UIFont(name: "Signika-Light", size: size).map(Font.init)
    }
    
    static func semibold(size: CGFloat) -> Font? {
        UIFont(name: "Signika-SemiBold", size: size).map(Font.init)
    }
}
