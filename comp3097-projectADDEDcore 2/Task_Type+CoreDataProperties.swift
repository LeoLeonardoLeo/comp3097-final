//
//  Task_Type+CoreDataProperties.swift
//  comp3097-project
//
//  Created by Tech on 2025-03-11.
//
//

import Foundation
import CoreData


extension Task_Type {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task_Type> {
        return NSFetchRequest<Task_Type>(entityName: "Task_Type")
    }

    @NSManaged public var title: String?
    @NSManaged public var task: Task?

}

extension Task_Type : Identifiable {

}
