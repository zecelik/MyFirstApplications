//
//  ViewController.swift
//  TravelBook
//
//  Created by Zehra on 25.09.2024.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var nameText: UITextField!

    @IBOutlet weak var commentText: UITextView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var chosenLatitude: Double = 0.0
    var chosenLongitude: Double = 0.0
    
    var selectedTitle: String = ""
    var selectedTitleID: UUID?
    
    var annotationTitle: String = ""
    var annotationSubtitle: String = ""
    var annotationLatitude: Double = 0.0
    var annotationLongitude: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapView()
        fetchLocationData()
    }
    
    private func setupMapView() {
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLocation(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 3
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    private func fetchLocationData() {
        guard !selectedTitle.isEmpty, let id = selectedTitleID else { return }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Places")
        fetchRequest.predicate = NSPredicate(format: "id = %@", id.uuidString)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            if let result = results.first as? NSManagedObject {
                annotationTitle = result.value(forKey: "title") as? String ?? ""
                annotationSubtitle = result.value(forKey: "subtitle") as? String ?? ""
                annotationLatitude = result.value(forKey: "latitude") as? Double ?? 0.0
                annotationLongitude = result.value(forKey: "longitude") as? Double ?? 0.0
                
                let annotation = MKPointAnnotation()
                annotation.title = annotationTitle
                annotation.subtitle = annotationSubtitle
                annotation.coordinate = CLLocationCoordinate2D(latitude: annotationLatitude, longitude: annotationLongitude)
                
                mapView.addAnnotation(annotation)
                nameText.text = annotationTitle
                commentText.text = annotationSubtitle
                
                locationManager.stopUpdatingLocation()
                
                let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
                mapView.setRegion(region, animated: true)
            }
        } catch {
            print("Error fetching location: \(error)")
        }
    }
    
    @objc func chooseLocation(gestureRecognizer: UILongPressGestureRecognizer) {
        guard gestureRecognizer.state == .began else { return }
        
        let touchedPoint = gestureRecognizer.location(in: self.mapView)
        let touchedCoordinates = self.mapView.convert(touchedPoint, toCoordinateFrom: self.mapView)
        
        chosenLatitude = touchedCoordinates.latitude
        chosenLongitude = touchedCoordinates.longitude
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = touchedCoordinates
        annotation.title = nameText.text
        annotation.subtitle = commentText.text
        mapView.addAnnotation(annotation)
        
        print("Chosen Latitude: \(chosenLatitude), Chosen Longitude: \(chosenLongitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard selectedTitle.isEmpty else { return }
        
        let location = locations[0].coordinate
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        let reuseId = "myAnnotation"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKMarkerAnnotationView
        
        if pinView == nil {
            pinView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            pinView?.tintColor = UIColor.black
            
            let button = UIButton(type: .detailDisclosure)
            pinView?.rightCalloutAccessoryView = button
        } else {
            pinView?.annotation = annotation
        }
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard !annotationTitle.isEmpty else { return }
        
        let requestLocation = CLLocation(latitude: annotationLatitude, longitude: annotationLongitude)
        
        CLGeocoder().reverseGeocodeLocation(requestLocation) { (placemarks, error) in
            if let placemarks = placemarks, placemarks.count > 0 {
                let newPlacemark = MKPlacemark(placemark: placemarks[0])
                let item = MKMapItem(placemark: newPlacemark)
                item.name = self.annotationTitle
                let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                item.openInMaps(launchOptions: launchOptions)
            }
        }
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPlace = NSEntityDescription.insertNewObject(forEntityName: "Places", into: context)
        newPlace.setValue(nameText.text, forKey: "title")
        newPlace.setValue(commentText.text, forKey: "subtitle")
        newPlace.setValue(chosenLatitude, forKey: "latitude")
        newPlace.setValue(chosenLongitude, forKey: "longitude")
        newPlace.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
            print("Success")
        } catch {
            print("Error saving context: \(error)")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newPlace"), object: nil)
        navigationController?.popViewController(animated: true)
    }
}
    


