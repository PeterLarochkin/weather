//
//  СacheManager.swift
//  weather
//
//  Created by Петр Ларочкин on 05.08.2022.
//

import Foundation
import CoreData

protocol CacheManagerOutput: AnyObject {
    func citiesFromCacheDidLoad(for cities: [CityData])
}
protocol СacheManagerProtocol: AnyObject {
    func loadHistorySearchFromMemory() -> ()
    func addCityToHistory(_ city: City) -> ()
    var output: CacheManagerOutput? { get set }
}

final class CacheManager: СacheManagerProtocol {

    static let shared: СacheManagerProtocol = CacheManager()
    var currentWatchedCities: [CityData]?
    weak var output: CacheManagerOutput?
    let persistentContainer: NSPersistentContainer
    let context: NSManagedObjectContext
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "CityModel")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        context = persistentContainer.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
    }
    
    func loadHistorySearchFromMemory() {
        DispatchQueue.global().async()  {
            let cities: [CityData] = (try? self.context.fetch(CityData.fetchRequest()) as [CityData]) ?? []
            self.output?.citiesFromCacheDidLoad(for: cities)
        }
    }
    
    func addCityToHistory(_ city: City) {
        context.perform {
            do {
                let cityData = CityData(context: self.context)
                cityData.name = city.name
                (cityData.lat, cityData.lon) = city.center
                try self.context.save()
            } catch let error {
                debugPrint(error)
            }
        }
        
    }
}
