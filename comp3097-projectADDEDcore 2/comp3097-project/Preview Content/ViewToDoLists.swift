import SwiftUI

struct ViewToDoLists: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Task_Type.title, ascending: true)],
        animation: .default
    ) private var taskTypes: FetchedResults<Task_Type> //get task type from db
    
    @State private var newTaskType: String = ""
    @State private var isAddingNewType = false
    @State private var selectedTask: Task_Type? //selected task for nav

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(taskTypes) { taskType in
                        HStack {
                            Button(action: {
                                selectedTask = taskType
                            }) {
                                ListRowView(title: taskType.title ?? "Untitled Task Type")
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Spacer()
                            
                            //edit button
                            Button(action: {
                                // edit logic can go here
                            }) {
                                Image(systemName: "pencil")
                                    .foregroundColor(.blue)
                                    .padding(10)
                            }
                            
                            // delete button
                            Button(action: {
                                deleteTaskType(taskType)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                                    .padding(10)
                            }
                        }
                        .frame(height: 50)
                    }
                }
                .listStyle(PlainListStyle())

                if isAddingNewType {
                    TextField("Enter New Task Type", text: $newTaskType)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .padding()

                    Button("Add Task Type") {
                        if !newTaskType.isEmpty {
                            addTaskType(title: newTaskType)
                            newTaskType = ""
                            isAddingNewType = false
                        }
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray.opacity(0.5))
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding()
                }
                else {
                    Button("Add Type") {
                        isAddingNewType = true
                    }
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .cornerRadius(10)
                    .foregroundColor(.white)
                    .padding()
                }

                //navigation to create Task
                NavigationLink(
                    destination: CreateTask(taskType: selectedTask?.title ?? ""),
                    isActive: Binding(
                        get: { selectedTask != nil },
                        set: { if !$0 { selectedTask = nil } }
                    )
                ) { EmptyView() }
            }
            .navigationTitle("Task Types")
        }
    }

    private func addTaskType(title: String) {
        let newTaskType = Task_Type(context: viewContext)
        newTaskType.title = title
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving new task type: \(error.localizedDescription)")
        }
    }

    private func deleteTaskType(_ taskType: Task_Type) {
        viewContext.delete(taskType)
        
        do {
            try viewContext.save()
        } catch {
            print("Error deleting task type: \(error.localizedDescription)")
        }
    }
}

struct ListRowView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
    }
}

struct ViewToDoLists_Previews: PreviewProvider {
    static var previews: some View {
        ViewToDoLists()
    }
}
