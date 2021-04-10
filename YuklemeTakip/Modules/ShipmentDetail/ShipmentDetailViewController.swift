//
//  ShipmentDetailViewController.swift
//  YuklemeTakip
//
//  Created by Cevher on 10.04.2021.
//

import UIKit

class ShipmentDetailViewController: UIViewController {

    @IBOutlet weak var infoDetail1: InfoDetailView!
    @IBOutlet weak var infoDetail2: InfoDetailView!
    @IBOutlet weak var infoDetail3: InfoDetailView!
    @IBOutlet weak var infoDetail4: InfoDetailView!
    @IBOutlet weak var infoDetail5: InfoDetailView!
    @IBOutlet weak var infoDetail6: InfoDetailView!
    @IBOutlet weak var infoDetail7: InfoDetailView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setDetailsData()
    }
    
    func setDetailsData(){
        infoDetail1.setDatas("Yük Tipi", "Genel Kargo")
        infoDetail2.setDatas("Yükleme Tipi", "Paketli")
        infoDetail3.setDatas("Yükleme Adedi", "243")
        infoDetail4.setDatas("Yüklerin Kilosu", "24 Ton")
        infoDetail5.setDatas("Yükleme Saati", "14:30")
        infoDetail6.setDatas("Hacim", "67 m3")
        infoDetail7.setDatas("Çıkış Gümrük", "Kapıkule")
    }
   

}
