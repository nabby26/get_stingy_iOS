//
//  EventDetailViewController.swift
//  get_stingy
//
//  Created by Nabila on 05/08/2017.
//  Copyright © 2017 Nabila Herzegovina. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController, UICollectionViewDelegate {
	@IBOutlet weak var eventMediaCollectionView: UICollectionView!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
			
			eventMediaCollectionView.delegate = self
			eventMediaCollectionView.dataSource = self
			
			//Modify Nav Bar
			let nav = self.navigationController?.navigationBar
			
			nav?.barTintColor = UIColor(red:1.00, green:0.30, blue:0.30, alpha:1.0)
			nav?.tintColor = UIColor.white
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
