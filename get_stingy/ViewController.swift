//
//  ViewController.swift
//  get_stingy
//
//  Created by Nabila on 05/08/2017.
//  Copyright © 2017 Nabila Herzegovina. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, UITableViewDelegate, CLLocationManagerDelegate {

	@IBOutlet weak var eventTable: UITableView!
	@IBOutlet weak var eventMapView: MKMapView!
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var contentView: UIView!
	
	let regionRadius: CLLocationDistance = 1000
	var locationManager = CLLocationManager()
	
	var eventTitles = ["Free Burgers at KFC",
	                  "Golden Gaytime Giveaway",
	                  "Ben & Jerry's Birthday",
	                  "Free Pizza at Criniti",
	                  "Saussage Sizzle at Bunnings",
	                  "Popsicle at Sweet Tooth"]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		scrollView.setNeedsLayout()
		scrollView.layoutIfNeeded()
		
		self.automaticallyAdjustsScrollViewInsets = false
		self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
		
		eventTable.delegate = self
		eventTable.dataSource = self
		
		eventMapView.isZoomEnabled = true
		eventMapView.isPitchEnabled = true
		eventMapView.isScrollEnabled = true
		
		let initialLocation = CLLocation(latitude: -37.8136, longitude: 144.9631)
		centerMapOnLocation(location: initialLocation)
		displayAnnotations()
		
		
		//Modify Nav Bar
		let nav = self.navigationController?.navigationBar
		
		nav?.barTintColor = UIColor(red:1.00, green:0.30, blue:0.30, alpha:1.0)
		nav?.tintColor = UIColor.white
		nav?.titleTextAttributes = [NSAttributedStringKey.foregroundColor.rawValue: UIColor.white]
		
//		let height = eventTable.contentSize.height + eventMapView.frame.size.height
//		scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: height)
//		scrollView.contentSize = contentView.frame.size.height
		trackUserLocation()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func centerMapOnLocation(location: CLLocation) {
		let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
		                                                          regionRadius, regionRadius)
		eventMapView.setRegion(coordinateRegion, animated: true)
	}
	
	func displayAnnotations() {
		let annotation_1 = EventAnnotation(title: "ABC",
		                                   subtitle: "Some Cafe",
		                                   coordinate: CLLocationCoordinate2D(latitude: -37.8231, longitude: 144.9693))
		let annotation_2 = EventAnnotation(title: "DEF",
		                                   subtitle: "Some Bar",
		                                   coordinate: CLLocationCoordinate2D(latitude: -37.8194, longitude: 144.9348))
		let annotation_3 = EventAnnotation(title: "Free Burgers",
		                                   subtitle: "Mr.Burger",
		                                   coordinate: CLLocationCoordinate2D(latitude: -37.8335, longitude: 144.9621))
		let annotation_4 = EventAnnotation(title: "Free Pepsi",
		                                   subtitle: "Melbourne Central",
		                                   coordinate: CLLocationCoordinate2D(latitude: -37.8362, longitude: 144.9251))
		
		let annotations = [annotation_1,annotation_2,annotation_3,annotation_4]
		
		eventMapView.addAnnotations(annotations)
		
	}
	
	func trackUserLocation() {
		eventMapView.showsUserLocation = true
//		eventMapView.userTrackingMode = MKUserTrackingMode(rawValue: 1)!
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.delegate = self
		
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
		
		self.eventMapView.setRegion(region, animated: true)
	}
	override func performSegue(withIdentifier identifier: String, sender: Any?) {
		if identifier == "eventDetailSegue" {
			
		}
	}
	
}

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return eventTitles.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let nib = UINib(nibName: "EventTableViewCell", bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: "eventCell")
		let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
		cell.cellTitle.text = eventTitles[indexPath.item]
		return cell
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		let cell = tableView.cellForRow(at: indexPath)
		tableView.deselectRow(at: indexPath, animated: true)
		
		let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
		let destination = storyboard.instantiateViewController(withIdentifier: "EventDetailViewController") as! EventDetailViewController
		self.navigationController?.pushViewController(destination, animated: true)
		self.performSegue(withIdentifier: "eventDetailSegue", sender: self)
	}
	
	
}

