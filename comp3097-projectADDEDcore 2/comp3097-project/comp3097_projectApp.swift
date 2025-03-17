//
//  comp3097_projectApp.swift
//  comp3097-project
//
//  Created by Tech on 2025-02-25.
//

import SwiftUI

@main
struct comp3097_projectApp: App {
    @StateObject private var dataController = DataController()
     
     var body: some Scene {
         WindowGroup {
             ContentView()
                 .environment(\.managedObjectContext, dataController.container.viewContext)
         }
     }
}
