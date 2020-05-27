//
//  Run.swift
//  RunApp
//
//  Created by Dumitru Catalin Vunvulea on 27/05/2020.
//  Copyright © 2020 Dumitru Catalin Vunvulea. All rights reserved.
//

import Foundation
import RealmSwift

class Run: Object {
    
    @objc dynamic public private(set) var id = ""
    @objc dynamic public private(set) var date = NSDate()
    @objc dynamic public private(set) var pace = 0
    @objc dynamic public private(set) var distance = 0.0
    @objc dynamic public private(set) var duration = 0
    
    override class func primaryKey() -> String { //specify the name of the property to be used as the primary key
        return "id"
    }
    
    override class func indexedProperties() -> [String] { //return an array of properties that should be indexed
        return ["pace", "date", "duration"]
    }
    
    convenience init(pace: Int, distance: Double, duration: Int) {
        self.init()
        self.id = UUID().uuidString.lowercased() //get a unique generic id
        self.date = NSDate()  //set the current date when the object is created
        self.pace = pace
        self.distance = distance
        self.duration = duration
    }
    
    static func addRunToRealm(pace: Int, distance: Double, duration: Int) { //it is static because we only whant one instance of it; so we can call the funciton anywhere by simply writing Run.addRunToRealm (not like when we create DataService.instance.addRunToRealm)
        REALM_QUEUE.sync {
            let run = Run(pace: pace, distance: distance, duration: duration)
            do {
                let realm = try Realm()
                try realm.write {
                    realm.add(run)
                    try realm.commitWrite() //not 100% you need this but is safer to have it
                }
            } catch {
                debugPrint("Error adding run to Realm")
            }
        }
    }
    
    static func getAllRuns() -> Results<Run>? {
        do {
            let realm = try Realm()
            var runs = realm.objects(Run.self)
            runs = runs.sorted(byKeyPath: "date", ascending: false) //last run will show first
            
            return runs
        } catch {
            return nil
        }
    }
    
}
