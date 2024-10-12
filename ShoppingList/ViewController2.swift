//
//  ViewController2.swift
//  alisverislistesi
//
//  Created by Zehra on 17.07.2024.
//

import UIKit
import CoreData

class ViewController2: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var productname: UITextField!
    @IBOutlet weak var productbody: UITextField!
    
    @IBOutlet weak var productprice: UITextField!
    var chosen2name = ""
    var chosen2id : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if  chosen2name != ""
        {
            if let uuidString = chosen2id?.uuidString
            {
                let app = UIApplication.shared.delegate as! AppDelegate
                let context = app.persistentContainer.viewContext
                
                let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Shopping")
                fetch.predicate = NSPredicate(format: "id =%@", uuidString)
                fetch.returnsObjectsAsFaults = false
                do
                {
                    
                    let results = try context.fetch(fetch)
                    if results.count > 0
                    {
                        for res in results as! [NSManagedObject]
                        {
                            if let name = res.value(forKey: "name") as? String
                            {
                                productname.text = name
                            }
                            if let price = res.value(forKey: "price") as? Int
                            {
                                productprice.text = String(price)
                            }
                            if let body = res.value(forKey: "body") as? String
                            {
                                productbody.text = body
                            }
                            if let Dataimage = res.value(forKey: "image") as? Data
                            {
                                let image = UIImage(data: Dataimage)
                                imageView.image = image
                            }
                        }
                    }
                }
                catch
                {
                    print("Error")
                }
                    
            }
        }
        else
        {
            productname.text = ""
            productbody.text = ""
            productprice.text = ""
        }
        
        
        
        let gest = UITapGestureRecognizer(target: self, action: #selector(close))
        view.addGestureRecognizer(gest)
        imageView?.isUserInteractionEnabled = true
        let gestimage = UITapGestureRecognizer(target: self, action: #selector(clickimage))
        imageView?.addGestureRecognizer(gestimage)
    }
    @objc func clickimage()
    {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as?  UIImage
        self.dismiss(animated: true, completion: nil)
    }
    @objc func close()
    {
        view.endEditing(true)
    }
    @IBAction func button(_ sender: Any) {
        let app = UIApplication.shared.delegate as? AppDelegate
        let context = (app?.persistentContainer.viewContext)!
        let shopping = NSEntityDescription.insertNewObject(forEntityName: "Shopping", into: context)
        
        shopping.setValue(productname.text!, forKey: "name")
        shopping.setValue(productbody.text!, forKey: "body")
        
        if let price = Int(productprice.text!) {
            shopping.setValue(price, forKey: "price")
        }
        
        shopping.setValue(UUID(), forKey: "id")
        
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        shopping.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("saved!")
            
       
            NotificationCenter.default.post(name: NSNotification.Name("dataEntered"), object: nil)
            
         
            self.navigationController?.popViewController(animated: true)
        } catch {
            print("Error saving context: \(error.localizedDescription)")
        }
    }

   

}
