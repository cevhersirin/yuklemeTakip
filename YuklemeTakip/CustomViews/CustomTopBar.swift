//
//  CustomTopBar.swift
//  YuklemeTakip
//
//  Created by Cevher on 10.04.2021.
//

import Foundation
import UIKit

@IBDesignable
class CustomTopBar: UIView{
    
    @IBOutlet var superView: UIView!
    @IBOutlet var topBarButtons: [UIButton]!
    @IBOutlet var topBarSectionViews: [UIView]!
    @IBOutlet var topBarSectionIcons: [UIImageView]!
    override init(frame: CGRect) {
        super.init(frame: frame)
        ownFirstNib()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        ownFirstNib()
        configure()
    }
    
    func configure(){
        superView.dropShadow()
    }
    
    @IBAction func topBarButtonsTapped(_ sender: UIButton) {
        for view in topBarSectionViews{
            if sender.tag == view.tag {
                view.backgroundColor = UIColor(named: "selectedSectionColor")
            } else {
                view.backgroundColor = UIColor.systemBackground
            }
        }
        for icon in topBarSectionIcons {
            if sender.tag == icon.tag {
                icon.tintColor = UIColor.blue
            } else {
                icon.tintColor = UIColor.lightGray
            }
        }
    }
    
    
}
