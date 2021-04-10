//
//  CustomNavBar.swift
//  YuklemeTakip
//
//  Created by Cevher on 10.04.2021.
//

import Foundation
import UIKit

@IBDesignable
class CustomNavBar: UIView{
    
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblTown: UILabel!
    
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
    @IBAction func btnBackTapped(_ sender: Any) {
    }
    @IBAction func btnSupportTapped(_ sender: Any) {
    }
}
