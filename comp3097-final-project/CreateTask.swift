import SwiftUI

struct CreateTask: View {
    @State private var taskName = ""
    @State private var desc = ""
    @State private var tasks: [String] = []
    
    func newTaskInList(){
        tasks.append("")
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("To Do List")
                    .font(.largeTitle)
                    .padding()
                
                TextField("Enter Task Name", text: $taskName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                ForEach(tasks.indices, id: \.self) { index in
                    TextField("Enter Task \(index + 1)", text: $tasks[index])
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Button("Add Task") {
                    newTaskInList()
                }
                
                Text("Task Name: \(taskName)")
                    .padding()
                
                Text("Tasks:")
                ForEach(tasks, id: \.self) { task in
                    Text(task)
                }
            }
            .padding()
        }
    }
}

struct CreateTask_Previews: PreviewProvider {
    static var previews: some View {
        CreateTask()
    }
}
