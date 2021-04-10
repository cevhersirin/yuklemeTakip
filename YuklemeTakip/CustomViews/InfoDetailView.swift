//
//  InfoDetailView.swift
//  YuklemeTakip
//
//  Created by Cevher on 10.04.2021.
//

import Foundation
import UIKit

@IBDesignable
class InfoDetailView: UIView {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    
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
        
    }
    func setDatas(_ title: String? , _ desc: String?){
        self.lblTitle.text = title ?? ""
        self.lblDesc.text = desc ?? ""
    }
    
}
