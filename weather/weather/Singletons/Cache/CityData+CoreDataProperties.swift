//
//  CityData+CoreDataProperties.swift
//  weather
//
//  Created by Петр Ларочкин on 14.03.2023.
//
//

import Foundation
import CoreData


extension CityData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityData> {
        return NSFetchRequest<CityData>(entityName: "CityData")
    }

    @NSManaged public var lat: Double
    @NSManaged public var lon: Double
    @NSManaged public var name: String?

}

extension CityData : Identifiable {

}
