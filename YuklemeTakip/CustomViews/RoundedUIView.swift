//
//  RoundedUIView.swift
//  YuklemeTakip
//
//  Created by Cevher on 10.04.2021.
//

import Foundation
import UIKit

@IBDesignable
class RoundedUIView: UIView {

    @IBInspectable open var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            setNeedsLayout()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            
            self.layer.borderWidth = borderWidth
            setNeedsLayout()
        }
    }
    
    @IBInspectable var borderColor: UIColor! {
        didSet {
            
            self.layer.borderColor = borderColor.cgColor
            setNeedsLayout()
        }
    }
    
    @IBInspectable var shadow: Bool = false {
        didSet {
            
            if shadow {
                self.dropShadow()
            } else {
                self.layer.shadowOpacity = 0.0
            }
            setNeedsLayout()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
        
    }
    
    internal func configure() {
        //layer.masksToBounds = cornerRadius > 0
        clipsToBounds = true
    }

}
