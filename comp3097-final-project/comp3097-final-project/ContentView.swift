//
//  ContentView.swift
//  comp3097-final-project
//
//  Created by Tech on 2025-02-11.
//

import SwiftUI

struct ContentView: View {
    func makeTask(){}
    
    
    
    var body: some View {
            NavigationStack{
                VStack{
                    
                    
                    NavigationLink(destination: CreateTask()){
                        Text("Create Task")
                            .font(.title2)
    
                    }

                    NavigationLink(destination: ViewToDoLists()){
                        Text("View")
                            .font(.title2)
                            .padding()
                        
                    }
                }
                .navigationBarTitle("To Do List", displayMode: .inline)

            }
            
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
