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
	
	let regionRadius: CLLocationDistance = 1000
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		eventTable.delegate = self
		eventTable.dataSource = self
		
		let initialLocation = CLLocation(latitude: -37.8136, longitude: 144.9631)
		centerMapOnLocation(location: initialLocation)
		
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
	
}

extension ViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 7;
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let nib = UINib(nibName: "EventTableViewCell", bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: "eventCell")
		let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
		cell.cellTitle.text = "Cell " + String(indexPath.item)
		return cell
	}
	
	
}

