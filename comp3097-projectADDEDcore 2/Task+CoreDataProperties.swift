//
//  Task+CoreDataProperties.swift
//  comp3097-project
//
//  Created by Tech on 2025-03-11.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var isComplete: Bool
    @NSManaged public var createdAt: Date?
    @NSManaged public var lastCompleted: Date?
    @NSManaged public var title: String?
    @NSManaged public var type: Task_Type?

}

extension Task : Identifiable {

}
