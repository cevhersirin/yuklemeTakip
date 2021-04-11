//
//  PhotoAddViewController.swift
//  YuklemeTakip
//
//  Created by Cevher on 11.04.2021.
//

import UIKit
import CoreData

class PhotoAddViewController: UIViewController {
    
    enum ImageSource {
        case photoLibrary
        case camera
    }
    
    @IBOutlet weak var photoCollectionView: UICollectionView!
    var imagePicker: UIImagePickerController!
    var imgDatas: [Data] = []
    var isFirstPhoto = true
    var isTakeAgaing = false
    @IBOutlet weak var imgTakePhoto: UIImageView!
    @IBOutlet weak var lblTakePhoto: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        imgDatas.removeAll()
        self.photoCollectionView.delegate = self
        self.photoCollectionView.dataSource = self
        fetchImages()
        self.setStyle()
    }
    
    func setStyle(){
        if imgDatas.count == 0{
            self.imgTakePhoto.image = UIImage(systemName: "camera")
            self.lblTakePhoto.text = "Fotoğraf Çek"
            self.imgTakePhoto.tintColor = .black
        } else {
            self.imgTakePhoto.image = UIImage(systemName: "arrow.counterclockwise")
            self.lblTakePhoto.text = "Yeniden Çek"
            self.imgTakePhoto.tintColor = .black
        }
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnRetakeTapped(_ sender: Any) {
        self.isTakeAgaing = true
        self.openLoadOptions()
    }
    @IBAction func btnSendTapped(_ sender: Any) {
        if imgDatas.count != 0 {
            sendImages()
        } else {
            let alert = UIAlertController(title: "Hata", message: "Göndermek için fotoğraf seçmelisiniz", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Tamam", style: .default, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        
        }
        
    }
    @IBAction func btnAddTapped(_ sender: Any) {
        self.isTakeAgaing = false
        self.openLoadOptions()
    }
    
    private func openLoadOptions(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.view.tintColor = UIColor.black
        
        alert.addAction(UIAlertAction(title: "Kamera Aç", style: .default, handler: { (_) in
            self.selectImageFrom(.camera)
        }))
        
        alert.addAction(UIAlertAction(title: "Galeri'den Seç", style: .default, handler: { (_) in
            self.selectImageFrom(.photoLibrary)
        }))
        
        alert.addAction(UIAlertAction(title: "İptal", style: .cancel, handler: { (_) in
        }))
        
        self.present(alert, animated: true, completion: {
        })
    }
    
    private func selectImageFrom(_ source: ImageSource){
        self.imagePicker = UIImagePickerController()
        self.imagePicker.mediaTypes = ["public.image"]
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
        switch source {
        case .camera:
            self.imagePicker.sourceType = .camera
        case .photoLibrary:
            self.imagePicker.sourceType = .photoLibrary
        }
        present(self.imagePicker, animated: true, completion: nil)
    }
    
    func sendImages(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let photos = NSEntityDescription.insertNewObject(forEntityName: "Photos", into: context)
        
        photos.setValue(imgDatas, forKey: "photoData")
        
        do {
            try context.save()
            let alert = UIAlertController(title: "Başarılı", message: "Fotoğraflar başarıyla kaydedildi.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Tamam", style: .default) { (UIAlertAction) in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        } catch {
            print("error")
        }
    }
    
    func fetchImages(){
        self.imgDatas.removeAll()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Photos")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                if let datas = result.value(forKey: "photoData") as? [Data]{
                    self.imgDatas = datas
                }
            }
        } catch {
            print("error")
        }
        self.photoCollectionView.reloadData()
    }
    
}

extension PhotoAddViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.imgDatas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCollectionCell", for: indexPath) as! PhotoCollectionCell
        
        if let image = UIImage(data: imgDatas[indexPath.row]) {
            cell.imgPhoto.image = image
        }
        cell.deleteButtonAction = {
            self.imgDatas.remove(at: indexPath.row)
            self.photoCollectionView.reloadData()
        }
        
        return cell
    }
    
    
}

extension PhotoAddViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[.originalImage] as? UIImage
        
        let imgData = image!.jpegData(compressionQuality: 1)
        
        if imgData != nil {
            if self.isTakeAgaing {
                self.imgDatas.removeAll()
                self.imgDatas.append(imgData!)
            } else {
                self.imgDatas.append(imgData!)
            }
            
        } else {
            print("hata")
        }
        
        self.imgTakePhoto.image = UIImage(systemName: "arrow.counterclockwise")
        self.lblTakePhoto.text = "Yeniden Çek"
        self.photoCollectionView.reloadData()
        
        
        
    }
    
}

class PhotoCollectionCell: UICollectionViewCell{
    
    var deleteButtonAction:(()->Void)?
    
    @IBOutlet weak var imgPhoto: UIImageView!
    @IBOutlet weak var deleteView: RoundedUIView!
    @IBAction func deleteButtonTapped(_ sender: Any) {
        if deleteButtonAction != nil {
            self.deleteButtonAction!()
        }
    }
}
