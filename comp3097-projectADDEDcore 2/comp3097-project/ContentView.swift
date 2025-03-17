import SwiftUI
import CoreData

extension DateFormatter {
    static var shortDateTimeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [
        NSSortDescriptor(keyPath: \Task.createdAt, ascending: false)
    ]) var tasks: FetchedResults<Task>
    
    var body: some View {
        NavigationStack {
            VStack {
                // Navigation to ViewToDoLists
                NavigationLink(destination: ViewToDoLists()) {
                    Text("View All Tasks")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Text("Upcoming Tasks")
                    .font(.system(size: 22))
                    .padding(.top, 10)
                
                List {
                    ForEach(tasks) { task in
                        VStack(alignment: .leading) {
                            Text(task.title ?? "Untitled Task")
                                .font(.headline)
                            
                            Text("Due: \(task.lastCompleted ?? Date(), formatter: DateFormatter.shortDateTimeFormatter)")
                                .font(.subheadline)
                                .foregroundColor(.gray)

                            // here we put the toggle for the completing and incomplete tasks
                            Toggle(isOn: Binding(
                                get: { task.isComplete },
                                set: { newValue in
                                    task.isComplete = newValue
                                    saveContext()
                                }
                            )) {
                                Text(task.isComplete ? "Completed ✅" : "Incomplete ❌")
                                    .font(.subheadline)
                                    .foregroundColor(task.isComplete ? .green : .red)
                            }
                            
                            if let taskType = task.type {
                                Text(taskType.title ?? "No Type")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            } else {
                                Text("No Task Type")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    .onDelete(perform: deleteTasks)
                }
                .navigationTitle("To Do List")
                .navigationBarTitleDisplayMode(.large)
            }
        }
    }
    
    private func deleteTasks(at offsets: IndexSet) {
        for index in offsets {
            let task = tasks[index]
            viewContext.delete(task)
        }
        saveContext()
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Could not save changes: \(error.localizedDescription)")
        }
    }
}
