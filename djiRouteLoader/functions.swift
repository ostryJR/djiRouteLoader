//
//  functions.swift
//  djiRouteLoader
//
//  Created by Mikolaj Ostrowski on 5/3/25.
//

import Foundation
import SQLite

class Map{
    var missionId: String
    var filePaths: String
    var name: String
    var author: String
    var createdTime: Double
    var modifiedTime: Double
    var coverImagePath: String
    var waypointImageNames: String
    var poiImageNames: String
    var waypointCount: Int
    var mileage: Double
    var waylineLatitude: Double
    var waylineLongitude: Double
    var locationDes: String
    
    init(){
        self.missionId = UUID().uuidString
        self.filePaths = "/var/mobile/Containers/Data/Application/"+missionId+"/Documents/wayline_mission/"+missionId+"/"+missionId+".kmz"
        self.name = "-"
        self.author = "-"
        self.createdTime = 0
        self.modifiedTime = 0
        self.coverImagePath = ""
        self.waypointImageNames = ""
        self.poiImageNames = ""
        self.waypointCount = 0
        self.mileage = 0
        self.waylineLatitude = 0
        self.waylineLongitude = 0
        self.locationDes = ""
    }
    init(missionId: String, filePaths: String, name: String, author: String, createdTime: Double, modifiedTime: Double, coverImagePath: String, waypointImageNames: String, poiImageNames: String, waypointCount: Int, mileage: Double, waylineLatitude: Double, waylineLongitude: Double, locationDes: String){
        self.missionId = missionId
        self.filePaths = filePaths
        self.name = name
        self.author = author
        self.createdTime = createdTime
        self.modifiedTime = modifiedTime
        self.coverImagePath = coverImagePath
        self.waypointImageNames = waypointImageNames
        self.poiImageNames = poiImageNames
        self.waypointCount = waypointCount
        self.mileage = mileage
        self.waylineLatitude = waylineLatitude
        self.waylineLongitude = waylineLongitude
        self.locationDes = locationDes
    }
    //init just for testing with changed path
    init(name: String, author: String){
        self.missionId = UUID().uuidString
        self.filePaths = "/Users/miki/Desktop/Development/djiWaypointRouteLoader/djiRouteLoader/djiRouteLoader/wayline_mission/"+missionId+"/"+missionId+".kmz"
        self.name = name
        self.author = author
        self.createdTime = 0
        self.modifiedTime = 0
        self.coverImagePath = ""
        self.waypointImageNames = ""
        self.poiImageNames = ""
        self.waypointCount = 0
        self.mileage = 0
        self.waylineLatitude = 0
        self.waylineLongitude = 0
        self.locationDes = ""
    }
    func genSQL() -> String{
        return "INSERT INTO 'kmzTable' VALUES ('\(missionId)', '\(filePaths)', '\(name)', '\(author)', '\(createdTime)', '\(modifiedTime)', '\(coverImagePath)', '\(waypointImageNames)', '\(poiImageNames)', '\(waypointCount)', '\(mileage)', '\(waylineLatitude)', '\(waylineLongitude)', '\(locationDes)');"
    }
}

func printPath(){
    
    let fileManager = FileManager.default
    let currentPath = fileManager.currentDirectoryPath

    if let resourcePath = Bundle.main.resourcePath {
        do {
            let items = try FileManager.default.contentsOfDirectory(atPath: resourcePath)
            print("Files and folders in app bundle:")
            print(currentPath)
            for item in items {
                print(item)
            }
        } catch {
            print("Error: \(error)")
        }
    }
}

func connectToDatabase() -> [Map]{
    //printPath()
    do {
        let db = try Connection("/Users/miki/Desktop/Development/djiWaypointRouteLoader/djiRouteLoader/djiRouteLoader/wayline_mission/mission_db/wpmz.sqlite3")
// SQL command:
//        INSERT INTO 'kmzTable' VALUES ('A4F24663-7677-458A-BA6C-0992DAC0367C', '/var/mobile/Containers/Data/Application/277FDE7D-6245-49DE-B9DE-DEC9E1BA6C94/Documents/wayline_mission/A4F24663-7677-458A-BA6C-0992DAC0367C/A4F24663-7677-458A-BA6C-0992DAC0367C.kmz', 'artificially added', 'mikpos', '17411978.26098', '17411978.26180', 'cover2.jpg', '0,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,', '', '37', '4498.531086534701', '50.277011544017', '18.6436508510853', '44-122');
        
        var dbRecords:[Map] = []
        let newRecord = Map(name: "mapTest001", author: "miki")
        
        
        //let kmzTable = Table("kmzTable")
        
        let stmt = try db.prepare("SELECT * FROM 'kmzTable';")
        for rowDB in stmt {
            var rowMap:Map
            rowMap = Map(missionId: rowDB[0] as! String, filePaths: rowDB[1] as! String, name: rowDB[2] as! String, author: rowDB[3] as! String, createdTime: rowDB[4] as! Double, modifiedTime: rowDB[5] as! Double, coverImagePath: rowDB[6] as! String, waypointImageNames: rowDB[7] as! String, poiImageNames: rowDB[8] as! String, waypointCount: Int(truncatingIfNeeded: rowDB[9] as! Int64) , mileage: rowDB[10] as! Double, waylineLatitude: rowDB[11] as! Double, waylineLongitude: rowDB[12] as! Double, locationDes: rowDB[13] as! String)
            dbRecords.append(rowMap)
        }
        return dbRecords
        
    } catch {
        print (error)
    }
    return []
}
