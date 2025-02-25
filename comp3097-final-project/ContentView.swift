import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            
            VStack {
                
                NavigationLink(destination: CreateTask()) {
                    Text("Create Task")
                        .customButtonStyle()
                        .padding()
                }
                
                NavigationLink(destination: ViewToDoLists()) {
                    Text("View All Tasks")
                        .customButtonStyle()
                        .padding() 
                }
                
                Text("Upcoming Tasks")
                    .font(.system(size: 22))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.bottom, 400)
            .background(Color.black.opacity(0.2))
            .navigationTitle("To Do List")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct CustomButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .foregroundColor(.white)
            .padding()
            .background(Color.teal)
            .cornerRadius(10)
    }
}

extension View {
    func customButtonStyle() -> some View {
        self.modifier(CustomButtonModifier())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
