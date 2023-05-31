//
//  CoreDataService.swift
//  StorySpark
//
//  Created by James Wolfe on 21/05/2023.
//

import Foundation
import CoreData

final class CoreDataService: NSObject {

    // MARK: - Variables

    private static var service: CoreDataService?
    fileprivate let databaseURL: URL = {
        guard let databaseDirectoryURL =
                FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first else {
            fatalError("Cannot access application support area")
        }

        return databaseDirectoryURL.appendingPathComponent("StorySpark.sqlite")
    }()

    static var context: NSManagedObjectContext {
        return CoreDataService.shared.container.viewContext
    }

    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "StorySpark")
        if FileManager.default.fileExists(atPath: databaseURL.path) {
            do {
                let attributed = [FileAttributeKey.protectionKey: FileProtectionType.complete]
                try FileManager.default.setAttributes(attributed, ofItemAtPath: databaseURL.path)
            } catch {
                fatalError("Failed to protect existing database file: \(error) at: \(databaseURL)")
            }
        }

        let description = NSPersistentStoreDescription(url: databaseURL)
        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true
        description.setOption(FileProtectionType.complete as NSObject, forKey: NSPersistentStoreFileProtectionKey)
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Error loading persistent store: \(error), \(error.userInfo)")
            }
        }

        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergePolicy.overwrite
        return container
    }()

    class var shared: CoreDataService {
        service = service == nil ? CoreDataService() : service
        return service!
    }

    // MARK: - Actions

    func fetchEntity<T>(predicate: NSPredicate? = nil) throws -> T? {
        guard Thread.isMainThread else { fatalError(CoreDataError.mustBeMainThread.localizedDescription) }
        let context = container.viewContext

        guard let type = T.self as? NSManagedObject.Type else {
            fatalError(CoreDataError.invalidType.localizedDescription)
        }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: NSStringFromClass(type))
        request.predicate = predicate

        let result = try? context.fetch(request).first as? T
        return result
    }

    func fetchEntities<T>(predicate: NSPredicate? = nil) throws -> [T] {
        guard Thread.isMainThread else { fatalError(CoreDataError.mustBeMainThread.localizedDescription) }
        let context = container.viewContext

        guard let type = T.self as? NSManagedObject.Type else {
            fatalError(CoreDataError.invalidType.localizedDescription)
        }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: NSStringFromClass(type))
        request.predicate = predicate

        let result = (try context.fetch(request) as? [T]) ?? []
        return result
    }

}

enum CoreDataError: Error {
    case invalidType
    case mustBeMainThread
}

extension CoreDataError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidType:
            return "Invalid Type"
        case .mustBeMainThread:
            return "Must be on main thread"
        }
    }
}

extension NSPredicate: @unchecked Sendable { }
