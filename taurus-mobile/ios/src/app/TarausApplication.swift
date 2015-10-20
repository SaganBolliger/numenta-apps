// Numenta Platform for Intelligent Computing (NuPIC)
// Copyright (C) 2015, Numenta, Inc.  Unless you have purchased from
// Numenta, Inc. a separate commercial license for this software code, the
// following terms and conditions apply:
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero Public License version 3 as
// published by the Free Software Foundation.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
// See the GNU Affero Public License for more details.
//
// You should have received a copy of the GNU Affero Public License
// along with this program.  If not, see http://www.gnu.org/licenses.
//
// http://numenta.org/licenses/

import Foundation

/*
 class holds references to a bunch of statics factories and data
*/
class TaurusApplication : GrokApplication{
    
    static var dataFactory : TaurusDataFactory!
    static var marketCalendar : MarketCalendar = MarketCalendar()
    static var client : TaurusClient?
   
    
    static func getTaurusDatabase()->TaurusDatabase{
        return GrokApplication.database as! TaurusDatabase
    }
    
    static func getYellowBarFloor()->Double{
        return 0.4
    }
    
    static func setup(){
        dataFactory = TaurusDataFactory()
        database = TaurusDatabase( dataFactory : dataFactory)
    }
    
    static func getAggregation()->AggregationType{
        return AggregationType.Day
   }
    
    static func getTotalBarsOnChart()->Int{
        return 24
    }
    
    static func getNumberofDaysToSync()->Int{
        return 7
    }
    
    static func connectToTaurus()->TaurusClient?{
        return client
    }
    
    /** favorites are stored as a dictionary
    
    
    */
    /**
    * Checks whether the given instance was marked as a favorite by the user
    *
    * -parameter instance: The instance ID to check
    * - returns: if it is a favorite,
    */
    static func isInstanceFavorite(instance:String)->Bool {
    
        let favorites = NSUserDefaults.standardUserDefaults().objectForKey("favorites")
        if (favorites == nil ){
            return false
        }
        let dict : [String:Int] = favorites! as! [String : Int]
        return dict[instance] != nil
    }
    
    /**
    * Return a collection with all instances marked as favorite by the user
    */
    static func getFavoriteInstances()->[String] {
        let favorites = NSUserDefaults.standardUserDefaults().objectForKey("favorites")
        if (favorites == nil ){
            return []
        }
        let dict : [String:Int] = favorites! as! [String : Int]
        return Array(dict.keys)
    }
    
    /**
    * Add the given instance to the user's preference list.
 
    *
    * @- parameter instance: The instance ID to add
    */
    static func addInstanceToFavorites(instance: String) {
        var favorites = NSUserDefaults.standardUserDefaults().objectForKey("favorites")
        
        if (favorites == nil){
            favorites = [String : Int]()
        }
        var dict : [String:Int] = favorites! as! [String : Int]
        dict[instance] = 0
        NSUserDefaults.standardUserDefaults().setObject(dict, forKey: "favorites")
        
     }
    
    /**
    * Remove the given instance to the user's preference list.
    *     x
    * @- parameter instance: The instance ID to add
    */
    static func removeInstanceToFavorites(instance: String) {
        let favorites = NSUserDefaults.standardUserDefaults().objectForKey("favorites")
        var dict : [String:Int] = favorites! as! [String : Int]
        dict.removeValueForKey(instance)
        NSUserDefaults.standardUserDefaults().setObject(dict, forKey: "favorites")
        
    }
    
}