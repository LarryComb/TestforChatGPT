import OpenAISwift
import SwiftUI
import UIKit

final class ViewModel: ObservableObject {
    init() {}
    
    var scrollView = UIScrollView()
    let leadingConstraint:NSLayoutConstraint!
    let trailingConstraint:NSLayoutConstraint!
    let topConstraint:NSLayoutConstraint!
    let bottomConstraint:NSLayoutConstraint!
    
    private var client: OpenAISwift?
    
    func setup(view: UIView) {
        client = OpenAISwift(authToken: "")
    
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let leadingConstraint = scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingConstraint = scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let topConstraint = scrollView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomConstraint = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
        
    }
    
    func send(text:String,
              completion: @escaping (String) -> Void) {
        client?.sendCompletion(with: text,
                               maxTokens: 500,
                               completionHandler: {result in
            switch result {
            case .success(let model):
                let output = model.choices.first?.text ?? ""
                completion(output)
            case .failure:
                break
                
            }
        })
        
    }
}


struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    @State var text = ""
    @State var models = [String]()
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(models, id: \.self){ string in
                Text(string)
            }
            
            Spacer()
            
            HStack{
                TextField("Type Here...", text: $text)
                Button("Send"){
                    send()
                }
            }
            
        }
        //The view is not in scope because "setup" in not being referenced
        // Adding another note to be deleted this is to see if commit push works
        .onAppear{
            viewModel.setup()
        }
        .padding()
    }
    func send(){
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
        
        models.append("Me: \(text)")
        viewModel.send(text: text) {response in
            DispatchQueue.main.async {
                self.models.append("ChatGPT: "+response)
                self.text = ""
            }
        }
    }
}
