//
//  ViewController.swift
//  get_stingy
//
//  Created by Nabila on 05/08/2017.
//  Copyright © 2017 Nabila Herzegovina. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, UITableViewDelegate {

	@IBOutlet weak var eventTable: UITableView!
	@IBOutlet weak var eventMapView: MKMapView!
	@IBOutlet weak var scrollView: UIScrollView!
	
	let regionRadius: CLLocationDistance = 1000
	
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
		
		resizeScrollView()
	}
	
	func resizeScrollView() {
		let width = scrollView.subviews.last?.frame.origin.y
		let height = scrollView.subviews.last?.frame.size.height
		let sizeContent = width! + height!
		
		scrollView.contentSize = CGSize(width:scrollView.frame.size.width, height: sizeContent)
		
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
		
		let annotations = [annotation_1,annotation_2]
		
		eventMapView.addAnnotations(annotations)
		
	}
	
	override func performSegue(withIdentifier identifier: String, sender: Any?) {
		if identifier == "eventDetailSegue" {
			
		}
	}
	
}

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 20;
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let nib = UINib(nibName: "EventTableViewCell", bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: "eventCell")
		let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
		cell.cellTitle.text = "Cell " + String(indexPath.item)
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

