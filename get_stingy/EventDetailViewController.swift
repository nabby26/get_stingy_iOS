//
//  EventDetailViewController.swift
//  get_stingy
//
//  Created by Nabila on 05/08/2017.
//  Copyright © 2017 Nabila Herzegovina. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class EventDetailViewController: UIViewController, UICollectionViewDelegate, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, CLLocationManagerDelegate {
	@IBOutlet weak var eventMediaCollectionView: UICollectionView!
	@IBOutlet weak var eventMediaCameraButton: UIBarButtonItem!
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var eventDetailMapView: MKMapView!
	
	var locationManager = CLLocationManager()
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
			
			self.automaticallyAdjustsScrollViewInsets = false
			self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
			
			eventMediaCollectionView.delegate = self
			eventMediaCollectionView.dataSource = self
			
			//Modify Nav Bar
			let nav = self.navigationController?.navigationBar
			
			nav?.barTintColor = UIColor(red:1.00, green:0.30, blue:0.30, alpha:1.0)
			nav?.tintColor = UIColor.white
			
			let initialLocation = CLLocation(latitude: -37.8136, longitude: 144.9631)
			centerMapOnLocation(location: initialLocation)
			trackUserLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func eventMediaCapture(_ sender: Any) {
		if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
			let imagePicker = UIImagePickerController()
			imagePicker.delegate = self
			imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
			imagePicker.allowsEditing = true
			self.present(imagePicker, animated: true, completion: nil)
		}
	}
	
	func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
		self.dismiss(animated: true, completion: nil);
	}
	
	func centerMapOnLocation(location: CLLocation) {
		let regionRadius: CLLocationDistance = 1000
		let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
		                                                          regionRadius, regionRadius)
		eventDetailMapView.setRegion(coordinateRegion, animated: true)
	}
	
	func trackUserLocation() {
		eventDetailMapView.showsUserLocation = true
		eventDetailMapView.userTrackingMode = MKUserTrackingMode(rawValue: 1)!
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.delegate = self as? CLLocationManagerDelegate
		
		locationManager.requestWhenInUseAuthorization()
		if CLLocationManager.locationServicesEnabled() {
			locationManager.startUpdatingLocation()
			locationManager.startUpdatingHeading()
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let location = locations.last as! CLLocation
		
		let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
		let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
		
		self.eventDetailMapView.setRegion(region, animated: true)
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EventDetailViewController: UICollectionViewDataSource {
	@available(iOS 6.0, *)
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 9;
	}
	
	@available(iOS 6.0, *)
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventMediaCell", for: indexPath) as! EventMediaCollectionViewCell
		
		return cell;
	}
	
	
}
