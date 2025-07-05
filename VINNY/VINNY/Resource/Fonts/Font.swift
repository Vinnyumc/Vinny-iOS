import SwiftUI

extension Font {
    static func inter(_ weight: InterFont, size: CGFloat) -> Font {
        .custom(weight.value, size: size)
    }

    enum InterFont: String {
        case extraBold = "Inter-ExtraBold"
        case bold = "Inter-Bold"
        case semibold = "Inter-SemiBold"
        case medium = "Inter-Medium"
        case regular = "Inter-Regular"
        case light = "Inter-Light"
        case extralight = "Inter-ExtraLight"
        case thin = "Inter-Thin"

        var value: String { self.rawValue }
    }

    static func suit(_ weight: SUITFont, size: CGFloat) -> Font {
        .custom(weight.value, size: size)
    }

    enum SUITFont: String {
        case extraBold = "SUIT-ExtraBold"
        case bold = "SUIT-Bold"
        case semibold = "SUIT-SemiBold"
        case medium = "SUIT-Medium"
        case regular = "SUIT-Regular"
        case light = "SUIT-Light"
        case extralight = "SUIT-ExtraLight"
        case thin = "SUIT-Thin"

        var value: String { self.rawValue }
    }
}
/*사용 예시
 Text("Inter Medium")
     .font(.inter(.medium, size: 18))

 Text("SUIT Bold")
     .font(.suit(.bold, size: 24))
 */

