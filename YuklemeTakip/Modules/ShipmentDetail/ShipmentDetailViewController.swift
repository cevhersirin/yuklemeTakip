//
//  ShipmentDetailViewController.swift
//  YuklemeTakip
//
//  Created by Cevher on 10.04.2021.
//

import UIKit
import GoogleMaps

class ShipmentDetailViewController: UIViewController {

    @IBOutlet weak var infoDetail1: InfoDetailView!
    @IBOutlet weak var infoDetail2: InfoDetailView!
    @IBOutlet weak var infoDetail3: InfoDetailView!
    @IBOutlet weak var infoDetail4: InfoDetailView!
    @IBOutlet weak var infoDetail5: InfoDetailView!
    @IBOutlet weak var infoDetail6: InfoDetailView!
    @IBOutlet weak var infoDetail7: InfoDetailView!
    
    @IBOutlet weak var documentView: UIView!
    @IBOutlet weak var imgDocument: UIImageView!
    @IBOutlet weak var viewMap: UIView!
    var mapView: GMSMapView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStyle()
        self.setDetailsData()
        self.setMapView()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imgDocument.addGestureRecognizer(tapGestureRecognizer)
        
        
        
    }
    
    func setStyle(){
        self.documentView.dropShadow()
    }
    
    func setMapView(){
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 15.0)
        self.mapView = GMSMapView.map(withFrame: self.viewMap.frame, camera: camera)
        self.viewMap.addSubview(mapView)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()

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
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let imgDocument = tapGestureRecognizer.view as! UIImageView
        let newImageView = UIImageView(image: imgDocument.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage(sender:)))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
    }
//
//    @IBAction func imageTapped(sender: UITapGestureRecognizer) {
//        let imgDocument = sender.view as! UIImageView
//        let newImageView = UIImageView(image: imgDocument.image)
//        newImageView.frame = UIScreen.main.bounds
//        newImageView.backgroundColor = .black
//        newImageView.contentMode = .scaleAspectFit
//        newImageView.isUserInteractionEnabled = true
//        let tap = UITapGestureRecognizer(target: self, action: Selector(("dismissFullscreenImage:")))
//        newImageView.addGestureRecognizer(tap)
//        self.view.addSubview(newImageView)
//        self.navigationController?.isNavigationBarHidden = true
//        self.tabBarController?.tabBar.isHidden = true
//    }

    @objc func dismissFullscreenImage(sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
   

}

extension ShipmentDetailViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // 3
        guard status == .authorizedWhenInUse else {
            return
        }
        // 4
        locationManager.startUpdatingLocation()

        //5
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        // 7
        mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15.0, bearing: 0, viewingAngle: 0)
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        marker.snippet = "polarxp kıraç"
        marker.map = mapView
        // 8
        locationManager.stopUpdatingLocation()
    }
}
