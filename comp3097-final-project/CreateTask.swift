import SwiftUI

struct CreateTask: View {
    @State private var taskName = ""
    @State private var tasks: [String] = []
    
    //for the date picker
    @State private var dueDate = Date()
    
    let printDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    func newTaskInList() {
        let formattedDate = printDate.string(from: dueDate)
        let taskWithDueDate = "\(taskName), Due: \(formattedDate)"
        tasks.append(taskWithDueDate)
    }
    
    var body: some View {
            NavigationView {
                ScrollView {
                    VStack {
                        
                        Text("Create Task")
                            .font(.system(size: 18))
                            .padding()
                        
                        TextField("Enter Task Name", text: $taskName)
                            .padding()
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Text("Due By")
                            .font(.system(size: 18))
                        
                        DatePicker(
                            "",
                            selection: $dueDate
                        )
                        .labelsHidden() //hides the blank text
                        .padding()
                        .multilineTextAlignment(.center)
                        
                        Button("Add Task") {
                            newTaskInList()
                        }
                        .font(.system(size: 18))
                        .padding()
                        
                        Text("Your Tasks:")
                        ForEach(tasks, id: \.self) { task in
                            Text(task)
                                .padding()
                        }
                    }
                    .padding(.bottom, 400)
                }
                
            }
            
        }
    }

struct CreateTask_Previews: PreviewProvider {
    static var previews: some View {
        CreateTask()
    }
}
