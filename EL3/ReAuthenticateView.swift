//
//  ReAuthenticateView.swift
//  EL3
//
//  Created by LARRY COMBS on 3/11/23.
//

// This is the import from another file that is connected to Google File
/*
import SwiftUI
import ActivityIndicatorView
import KeyboardObserving
import Firebase

struct ReAuthenticateView: View {
    @State var password: String = ""
    @State var loading = false
    @State var error = false
    @State private var showPassword = false
    @EnvironmentObject var session: SessionStore
    private var isDeletion = false
    
    init(isDeletion: Bool){
        UIScrollView.appearance().bounces = false
        self.isDeletion = isDeletion
    }
    
    func reAutenticate () {
        let credential = EmailAuthProvider.credential(withEmail: self.session.session!.email!, password: password)
        
        loading = true
        error = false
        session.reAuthenticateUser(credential: credential, isDeletion: isDeletion, isPasswordChange: false, password: nil)
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                    ZStack {
                        Color.backgroundColor
                        VStack(spacing: 30) {
                            Spacer()
                            Spacer()
                            Image("ic_bot").cornerRadius(.infinity)
                            
                            VStack {
                                HStack(spacing: 20) {
                                    if showPassword {
                                        TextField("Password", text: $password).font(Font.system(size: 21))
                                    } else {
                                        SecureField("Password", text: $password).font(Font.system(size: 21))
                                    }
                                    Button(action: {
                                        self.showPassword.toggle()
                                    }) {
                                        Image("ic_eye").resizable().frame(width: 35, height: 35, alignment: .center).colorMultiply(.black)
                                    }
                                }
                                Divider().background(Color.accent)
                            }.padding(.leading, 30).padding(.trailing, 30)
                            
                            if (error) {
                                InlineAlert(
                                    title: "Hmm... That didn't work.",
                                    subtitle: "Please check your email and password and try again"
                                    ).padding([.horizontal, .top])
                            }
                            
                            Button(action: {
                                reAutenticate()
                            }) {
                                Text("SIGN IN").padding(.horizontal)
                            }
                            .padding()
                            .foregroundColor(Color.white)
                            .background(Color.colorPrimary)
                            .cornerRadius(50)
                            
                            Spacer()
                        }
                        ZStack{
                            Color.backgroundColor
                            VStack {
                                Spacer()
                                ActivityIndicatorView(isVisible: $loading, type: .rotatingDots)
                                    .frame(width: 75, height: 75)
                                    .foregroundColor(Color.colorPrimary)
                                Text("Signing in").padding(.horizontal)
                            }
                        }
                        .edgesIgnoringSafeArea(.all).background(Color.backgroundColor)
                        .isHidden(loading)
                    }
                }.background(Color.backgroundColor).keyboardObserving()
        }.edgesIgnoringSafeArea(.all)
    }
}
*/
