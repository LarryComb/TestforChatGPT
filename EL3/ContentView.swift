import SwiftUI
import OpenAISwift

struct ContentView: View {
    @State private var inputMessage = ""
    @State private var messages = [Message]()
    
    var body: some View {
        VStack(alignment: .leading) {
            List(messages) { message in
                Text(message.text)
                    .padding()
                    .background(message.isUser ? Color.green : Color.blue)
                    .cornerRadius(10)
                    .foregroundColor(.white)
            }
            
            HStack {
                TextField("Type here...", text: $inputMessage)
                Button("Send") {
                    self.sendMessage()
                }
            }
            .padding()
        }
    }
    
    private func sendMessage() {
        guard !inputMessage.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        messages.append(Message(text: inputMessage, isUser: true))
        let client = OpenAISwift(authToken: "")
        client.sendCompletion(with: inputMessage, maxTokens: 500) { result in
            switch result {
            case .success(let model):
                let response = model.choices.first?.text ?? ""
                self.messages.append(Message(text: response, isUser: false))
            case .failure(let error):
                self.messages.append(Message(text: error.localizedDescription, isUser: false))
            }
        }
        
        inputMessage = ""
    }
}

struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isUser: Bool
}

