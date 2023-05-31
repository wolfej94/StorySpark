//
//  Persistable.swift
//  StorySpark
//
//  Created by James Wolfe on 21/05/2023.
//

import Foundation
import CoreData

protocol Persistable {
    
    var id: UUID { get }
    var dictionary: [String: Any] { get }
    func persist() throws
    
}

extension Persistable {
    
    fileprivate var entityName: String {
        let string = String(describing: self)
        return "Persistent\(string)"
    }
    
    fileprivate func entityDescription() -> NSEntityDescription {
        return NSEntityDescription.entity(forEntityName: entityName, in: CoreDataService.shared.container.viewContext)!
    }
    
    func persist() throws {
        let object = NSManagedObject(entity: entityDescription(), insertInto: CoreDataService.shared.container.viewContext)
        object.setValuesForKeys(dictionary)
        try CoreDataService.shared.container.viewContext.save()
    }
    
    func delete() throws {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetch.predicate = .init(format: "id = %@", self.id.uuidString)
        let delete = NSBatchDeleteRequest(fetchRequest: fetch)
        try CoreDataService.shared.container.viewContext.execute(delete)
    }
    
}
