import UIKit

@available(iOS 15.0, *)
public final class PMButton: UIControl {
    
  
    private let extraLeftIcon = UIImageView()
    private weak var presenter: UIViewController?
    private let centerIcon = UIImageView()
    private let bgImageView = UIImageView()
    private let stack = UIStackView()
    private var mediumWH: (w: NSLayoutConstraint, h: NSLayoutConstraint)?
    private var isMedium: Bool {
        currentStyle is MediumBlueStyle || currentStyle is MediumWhiteStyle
    }
    
    public convenience init(style: PMButtonStyle,
                            presenter: UIViewController? = nil) {
        self.init(frame: .zero)
        self.presenter = presenter
        configure(with: style.impl)
        addTarget(self, action: #selector(tapped), for: .touchUpInside)
        
    }
    

    
    private let leftIcon  = UIImageView()
    private let titleLbl  = UILabel()
    private let rightIcon = UIImageView()
    
    private var currentStyle: PMButtonStylable? {
        didSet { invalidateIntrinsicContentSize() }
    }
    
 
    private let gradient = CAGradientLayer()
    public override var intrinsicContentSize: CGSize {
        guard let s = currentStyle else { return .zero }
        return .init(width: s.intrinsicWidth, height: s.height)
    }
    
    private func layoutMedium(_ s: PMButtonStylable) {

        addSubview(bgImageView)
        bgImageView.translatesAutoresizingMaskIntoConstraints = false
        bgImageView.image        = s.backgroundImage
        bgImageView.contentMode  = .scaleAspectFill

        let wRatio = s.bgImageSize.width  / s.intrinsicWidth
        let hRatio = s.bgImageSize.height / s.height

        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 4
        if stack.superview == nil {
            stack.addArrangedSubview(leftIcon)
            stack.addArrangedSubview(titleLbl)
            addSubview(stack)
            stack.translatesAutoresizingMaskIntoConstraints = false
        }

        titleLbl.font = UIFont(name: "Montserrat-Regular", size: 11)
        titleLbl.numberOfLines = 1
        titleLbl.adjustsFontSizeToFitWidth = true
        titleLbl.minimumScaleFactor = 0.9
        titleLbl.textColor = s.titleColor

        NSLayoutConstraint.activate([
        
            bgImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bgImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: hRatio),

            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),

            leftIcon.widthAnchor.constraint(equalToConstant: 148),
            leftIcon.heightAnchor.constraint(equalToConstant: 15.8)
        ])
    }

    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.frame = bounds
        gradient.cornerRadius = currentStyle?.cornerRadius ?? 0
        
    
        layer.cornerRadius = currentStyle?.cornerRadius ?? 0
        layer.masksToBounds = false
        
    
        if let radius = currentStyle?.cornerRadius {
            layer.shadowPath = UIBezierPath(roundedRect: bounds,
                                            cornerRadius: radius).cgPath
        }
    }
    
    private var mediumSize: (w: NSLayoutConstraint, h: NSLayoutConstraint)?

    private func applyMediumFixedSize() {
        guard isMedium else { return }

        let wScreen = (window ?? UIApplication.shared.windows.first)?.bounds.width
                      ?? UIScreen.main.bounds.width

        let isPad   = wScreen >= 768
        let targetW: CGFloat = isPad ? 347.3 : 164.4
        let targetH: CGFloat = isPad ? 211.3 : 100

        if let pair = mediumSize {
            pair.w.constant = targetW
            pair.h.constant = targetH
            return
        }

        let w = widthAnchor .constraint(equalToConstant: targetW)
        let h = heightAnchor.constraint(equalToConstant: targetH)
        w.priority = .required
        h.priority = .required
        NSLayoutConstraint.activate([w,h])
        mediumSize = (w,h)
    }


    private func configure(with style: PMButtonStylable) {
        
        
        currentStyle = style
        translatesAutoresizingMaskIntoConstraints = false
 
        gradient.colors = style.colors.map(\.cgColor)
        gradient.startPoint = .init(x: 0, y: 0.5)
        gradient.endPoint   = .init(x: 1, y: 0.5)
        layer.insertSublayer(gradient, at: 0)
        
        layer.shadowColor   = style.shadow.color.cgColor
        layer.shadowRadius  = style.shadow.radius
        layer.shadowOffset  = style.shadow.offset
        layer.shadowOpacity = style.shadow.opacity
       
        extraLeftIcon.image = style.leftExtraImage
        extraLeftIcon.isHidden = style.leftExtraImage == nil
        
        centerIcon.image   = style.centerImage
        centerIcon.isHidden = style.centerImage == nil
        
        leftIcon.image  = style.leftImage
        rightIcon.image = style.rightImage
        
        FontRegistrar.register()
        titleLbl.text      = style.title
        titleLbl.textColor = (style as? ShortWhiteStyle)?.titleColor ?? .white
        titleLbl.font      = UIFont(name: "Montserrat-Regular", size: 12)
        titleLbl.numberOfLines     = 1
        titleLbl.adjustsFontSizeToFitWidth = true
        titleLbl.minimumScaleFactor = 0.9
     
        
        [centerIcon, leftIcon, titleLbl, rightIcon].forEach {
            if $0.superview == nil { addSubview($0); $0.translatesAutoresizingMaskIntoConstraints = false }
        }
        
        if style.rightImage != nil && rightIcon.superview == nil {
            addSubview(rightIcon)
            rightIcon.translatesAutoresizingMaskIntoConstraints = false
        }
        setConstraints(style: style)
        applyMediumFixedSize()  
    }
    
    private func setConstraints(style: PMButtonStylable) {
        
        if let s = style as? ShortWhiteStyle {
            
            extraLeftIcon.translatesAutoresizingMaskIntoConstraints = false
            addSubview(extraLeftIcon)
            
            NSLayoutConstraint.activate([
                
              
                extraLeftIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                extraLeftIcon.topAnchor.constraint(equalTo: topAnchor, constant: s.topMargin),
                extraLeftIcon.widthAnchor.constraint(equalToConstant: 20),
                extraLeftIcon.heightAnchor.constraint(equalToConstant: 15),
                
            
                leftIcon.leadingAnchor.constraint(equalTo: extraLeftIcon.trailingAnchor, constant: 6),
                leftIcon.centerYAnchor.constraint(equalTo: extraLeftIcon.centerYAnchor),
                leftIcon.widthAnchor.constraint(equalToConstant: s.leftSize.width),
                leftIcon.heightAnchor.constraint(equalToConstant: s.leftSize.height),
                
         
                titleLbl.leadingAnchor.constraint(equalTo: extraLeftIcon.leadingAnchor),
                titleLbl.topAnchor.constraint(equalTo: leftIcon.bottomAnchor, constant: 8),
                titleLbl.trailingAnchor.constraint(lessThanOrEqualTo: rightIcon.leadingAnchor, constant: -8),
                titleLbl.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -s.bottomMarginText),
                
            
                rightIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                rightIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
                rightIcon.widthAnchor.constraint(equalToConstant: s.rightSize.width),
                rightIcon.heightAnchor.constraint(equalToConstant: s.rightSize.height)
            ])
            
         
        } else if let s = style as? ShortBlueStyle {
            
            NSLayoutConstraint.activate([
                // Logo
                leftIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: s.leftMargin),
                leftIcon.topAnchor.constraint(equalTo: topAnchor, constant: s.topMargin),
                leftIcon.widthAnchor.constraint(equalToConstant: s.leftSize.width),
                leftIcon.heightAnchor.constraint(equalToConstant: s.leftSize.height),
                
                // Texto
                titleLbl.leadingAnchor.constraint(equalTo: leftIcon.leadingAnchor),
                titleLbl.topAnchor.constraint(equalTo: leftIcon.bottomAnchor, constant: 8),
                titleLbl.trailingAnchor.constraint(lessThanOrEqualTo: rightIcon.leadingAnchor, constant: -8),
                titleLbl.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -s.bottomMarginText),
                
                // Imagen derecha
                rightIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                rightIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
                rightIcon.widthAnchor.constraint(equalToConstant: s.rightSize.width),
                rightIcon.heightAnchor.constraint(equalToConstant: s.rightSize.height)
            ])
            
            
        } else if style is CircleBlueStyle || style is CircleWhiteStyle {
            
            let size = (style as? CircleBlueStyle)?.centerSize ??
            (style as? CircleWhiteStyle)?.centerSize ?? CGSize(width: 40, height: 40)
            
            NSLayoutConstraint.activate([
                centerIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
                centerIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
                centerIcon.widthAnchor.constraint(equalToConstant: size.width),
                centerIcon.heightAnchor.constraint(equalToConstant: size.height)
            ])
        } else if style is MediumBlueStyle || style is MediumWhiteStyle {
            layoutMedium(style)
            return
        } else {
            NSLayoutConstraint.activate([
                leftIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
                leftIcon.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                leftIcon.widthAnchor.constraint(equalTo: leftIcon.heightAnchor),
                leftIcon.heightAnchor.constraint(equalToConstant: style.height - 32),
                
                titleLbl.leadingAnchor.constraint(equalTo: leftIcon.leadingAnchor),
                titleLbl.topAnchor.constraint(equalTo: leftIcon.bottomAnchor, constant: 4),
                titleLbl.trailingAnchor.constraint(lessThanOrEqualTo: rightIcon.leadingAnchor, constant: -8),
                
                rightIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
                rightIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
                rightIcon.widthAnchor.constraint(equalTo: rightIcon.heightAnchor),
                rightIcon.heightAnchor.constraint(equalTo: leftIcon.heightAnchor)
            ])
        }
    }

    @objc private func tapped() {
        guard let host = presenter ?? UIApplication.topMost else { return }
        let webVC = PMWebViewController()
        webVC.modalPresentationStyle = .fullScreen
        host.present(webVC, animated: true)
    }
}
