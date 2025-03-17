import SwiftUI
import CoreData

struct CreateTask: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @State private var taskName = ""
    @State private var lastCompleted = Date()
    
    var taskType: String
    
    @State private var taskTypeFromDB: Task_Type?
    
    @FetchRequest var tasks: FetchedResults<Task>

    init(taskType: String) {
        self.taskType = taskType
        
        _tasks = FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Task.createdAt, ascending: false)],
            predicate: NSPredicate(format: "type.title == %@", taskType),
            animation: .default
        )
    }
    
    func createTask() {
        fetchTaskType { success in
            if success, let taskTypeFromDB = taskTypeFromDB {
                let newTask = Task(context: viewContext)
                newTask.title = taskName
                newTask.createdAt = Date()
                newTask.isComplete = false
                newTask.lastCompleted = lastCompleted
                newTask.type = taskTypeFromDB

                do {
                    try viewContext.save()
                    print("Task created successfully")
                    taskName = ""
                } catch {
                    print("Failed to create task: \(error.localizedDescription)")
                }
            } else {
                print("No task type found. Unable to create task.")
            }
        }
    }

    func fetchTaskType(completion: @escaping (Bool) -> Void) {
        let fetchRequest: NSFetchRequest<Task_Type> = Task_Type.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title == %@", taskType)
        
        do {
            let result = try viewContext.fetch(fetchRequest)
            if let fetchedTaskType = result.first {
                taskTypeFromDB = fetchedTaskType
                print("Fetched Task Type: \(fetchedTaskType.title ?? "No Type")")
                completion(true)
            } else {
                print("No task type found called: \(taskType)")
                completion(false)
            }
        } catch {
            print("Failed to get task type: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                // Task Creation Form
                Text("Create Task for \(taskType)")
                    .font(.headline)
                
                TextField("Enter Task Name", text: $taskName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Text("Due By")
                    .font(.subheadline)
                
                DatePicker("", selection: $lastCompleted, displayedComponents: [.date, .hourAndMinute])
                    .labelsHidden()
                    .padding(.horizontal)

                Button("Add Task") {
                    createTask()
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 5)

                Text("Existing Tasks for \(taskType)")
                    .font(.headline)
                    .padding(.top, 20)

                List {
                    ForEach(tasks) { task in
                        VStack(alignment: .leading) {
                            Text(task.title ?? "Untitled Task")
                                .font(.headline)
                            
                            Text("Due By: \(task.lastCompleted ?? Date(), formatter: DateFormatter.shortDateTimeFormatter)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            Text(task.isComplete ? "Completed" : "Incomplete")
                                .font(.subheadline)
                                .foregroundColor(task.isComplete ? .green : .red)
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
            .onAppear {
                fetchTaskType { success in
                    if !success {
                        print("Error: Could not fetch task type")
                    }
                }
            }
            .navigationTitle("Create Task")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CreateTask_Previews: PreviewProvider {
    static var previews: some View {
        CreateTask(taskType: "Type 1")
    }
}
