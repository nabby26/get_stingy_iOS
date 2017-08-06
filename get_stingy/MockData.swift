//
//  MockData.swift
//  get_stingy
//
//  Created by Anthony on 6/8/17.
//  Copyright © 2017 Nabila Herzegovina. All rights reserved.
//

import UIKit

class MockData: NSObject {
    public var name:String
    public var desc:String
    public var lat:Double
    public var long:Double
    public var time:String
    public var date:String
    
    // constructor
    init(name:String, desc:String, lat:Double, long:Double, time:String, date:String) {
        self.name = name
        self.desc = desc
        self.lat = lat
        self.long = long
        self.time = time
        self.date = date
    }
}
