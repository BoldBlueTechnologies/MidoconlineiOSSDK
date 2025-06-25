import UIKit

public enum PMButtonStyleKind { case blue, white }
public enum PMButtonStyle {
    
    case short(kind: PMButtonStyleKind = .blue)
    case circle(kind: PMButtonStyleKind = .blue)
    case medium(kind: PMButtonStyleKind = .blue)
    
    var impl: PMButtonStylable {
        switch self {
        case .short(let kind):
                return kind == .blue ? ShortBlueStyle() : ShortWhiteStyle()
        case .circle(let kind):
                return kind == .blue ? CircleBlueStyle() : CircleWhiteStyle()
        case .medium(let kind):
               return kind == .blue ? MediumBlueStyle() : MediumWhiteStyle()
           
        }
    }
}

protocol PMButtonStylable {
 
    var backgroundImage: UIImage? { get }
      var bgImageSize:   CGSize { get }
    var maxWidth:       CGFloat { get }
    var centerImage:    UIImage? { get }
    var colors:         [UIColor] { get }
    var title:          String   { get }
    var titleColor:     UIColor  { get }
    var leftImage:      UIImage? { get }
    var rightImage:     UIImage? { get }
    var leftExtraImage: UIImage? { get }
    var intrinsicWidth: CGFloat  { get }
    var height:         CGFloat  { get }
    var cornerRadius:   CGFloat  { get }
    var shadow: (color: UIColor, radius: CGFloat, offset: CGSize, opacity: Float) { get }
}


struct ShortBlueStyle: PMButtonStylable {
    let colors: [UIColor] = [
        UIColor(red: 0/255, green: 2/255,  blue: 81/255, alpha: 1),
        UIColor(red: 0/255, green: 102/255, blue: 250/255, alpha: 1)
    ]

    let title      = "Consulta por videollamada"
    let leftImage  = UIImage(named: "logowhite",  in: .module, compatibleWith: nil)
    let rightImage = UIImage(named: "medicosbar", in: .module, compatibleWith: nil)

    let intrinsicWidth: CGFloat = 344
    let height:         CGFloat = 68
    let cornerRadius:   CGFloat = 12


    var shadow: (color: UIColor, radius: CGFloat, offset: CGSize, opacity: Float) {
        (
            color:   UIColor.black.withAlphaComponent(0.27),
            radius:  5,
            offset:  CGSize(width: 0, height: 3),
            opacity: 1
        )
    }
    
    let leftSize   = CGSize(width: 148, height: 15.8)
     let rightSize  = CGSize(width: 106, height: 60)
     let topMargin: CGFloat      = 18
     let leftMargin: CGFloat     = 13
     let bottomMarginText: CGFloat = 12
}


struct ShortWhiteStyle: PMButtonStylable {
    let colors = [UIColor.white,
                     UIColor.white]

    let title      = "Consulta por videollamada"
    let titleColor = UIColor(red: 0/255, green: 2/255, blue: 81/255, alpha: 1)

    let leftImage        = UIImage(named: "logoblue", in: .module, compatibleWith: nil)
    let leftExtraImage   = UIImage(named: "midoconlineIsotipo", in: .module, compatibleWith: nil)
    let rightImage       = UIImage(named: "medicosbar", in: .module, compatibleWith: nil)

    let intrinsicWidth: CGFloat = 344
    let height:         CGFloat = 72
    let cornerRadius:   CGFloat = 12
    var shadow: (color: UIColor, radius: CGFloat, offset: CGSize, opacity: Float) {
        (UIColor.black.withAlphaComponent(0.12), 4, .init(width: 0, height: 2), 1)
    }
    
    let leftSize   = CGSize(width: 148, height: 15.8)
    let rightSize  = CGSize(width: 106, height: 60)
    let topMargin: CGFloat      = 23
    let leftMargin: CGFloat     = 13
    let bottomMarginText: CGFloat = 12
}

struct CircleBlueStyle: PMButtonStylable {

    let centerSize = CGSize(width: 54.8, height: 42.9)
    let colors: [UIColor] = [
        UIColor(red: 0/255,  green:  2/255,  blue: 81/255, alpha: 1),
        UIColor(red:34/255,  green: 46/255,  blue:245/255, alpha: 1)
    ]

    let title = ""
    let centerImage = UIImage(named: "midoconlineIsotipo2", in: .module, compatibleWith: nil)

 
    let leftImage: UIImage?  = nil
    let rightImage: UIImage? = nil
    let intrinsicWidth: CGFloat = 92
    let height:         CGFloat = 92
    let cornerRadius:   CGFloat = 46

    var shadow: (color: UIColor, radius: CGFloat, offset: CGSize, opacity: Float) {
        (UIColor.black.withAlphaComponent(0.25), 6, .init(width: 0, height: 4), 1)
    }
}

struct CircleWhiteStyle: PMButtonStylable {

    let centerSize = CGSize(width: 54.8, height: 42.9)
    let colors = [UIColor.white, UIColor.white]
    let title  = ""
    let centerImage = UIImage(named: "midoconlineIsotipo2", in: .module, compatibleWith: nil)

    let leftImage: UIImage? = nil
    let rightImage: UIImage? = nil

    let intrinsicWidth: CGFloat = 92
    let height:         CGFloat = 92
    let cornerRadius:   CGFloat = 46

    var shadow: (color: UIColor, radius: CGFloat, offset: CGSize, opacity: Float) {
        (UIColor.black.withAlphaComponent(0.15), 6, .init(width: 0, height: 4), 1)
    }
}

struct MediumBlueStyle: PMButtonStylable {
    var rightImage: UIImage?
    let colors = [
        UIColor(red: 34/255, green:46/255, blue:245/255, alpha:1),
        UIColor(red:  0/255, green: 2/255, blue: 81/255, alpha:1)
    ]

    let title      = "Consulta por videollamada"
    let titleColor = UIColor.white
    let leftImage  = UIImage(named: "logowhite", in: .module, compatibleWith: nil)
    let backgroundImage = UIImage(named: "midoconlineFondo", in: .module, compatibleWith: nil)
    let bgImageSize     = CGSize(width: 164.4, height: 91.5)

    let intrinsicWidth: CGFloat = 164.4
    let height:         CGFloat = 100
    let cornerRadius:   CGFloat = 12
    let maxWidth:       CGFloat = 347.3        

    var shadow: (color: UIColor, radius: CGFloat, offset: CGSize, opacity: Float) {
        (UIColor.black.withAlphaComponent(0.25), 6, .init(width: 0, height: 4), 1)
    }
}

struct MediumWhiteStyle: PMButtonStylable {
    var rightImage: UIImage?
    let colors = [UIColor.white, UIColor.white]
    let title      = "Consulta por videollamada"
    let titleColor = UIColor.white
    let leftImage  = UIImage(named: "logowhite", in: .module, compatibleWith: nil)

    let backgroundImage = UIImage(named: "midoconlineFondo", in: .module, compatibleWith: nil)
    let bgImageSize     = CGSize(width: 164.4, height: 91.5)

    let intrinsicWidth: CGFloat = 164.4
    let height:         CGFloat = 100
    let cornerRadius:   CGFloat = 12
    let maxWidth:       CGFloat = 347.3

    var shadow: (color: UIColor, radius: CGFloat, offset: CGSize, opacity: Float) {
        (UIColor.black.withAlphaComponent(0.15), 6, .init(width: 0, height: 4), 1)
    }
}


extension PMButtonStylable {
    var centerImage: UIImage? { nil }
    var titleColor: UIColor     { .white }
    var leftExtraImage: UIImage? { nil }
    var backgroundImage: UIImage? { nil }
    var bgImageSize: CGSize { .zero }
    var maxWidth: CGFloat { .zero }
}
