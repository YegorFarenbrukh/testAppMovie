//
//  ContentView.swift
//  testAppMovie
//
//  Created by apple on 2/4/21.
//

import SwiftUI
import Combine


// MARK: - Main Struct
struct LoginView: View {
    
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack {
            Text("Welcome to the Movie App!")
                .frame(height: 0, alignment: .center)
            EmailAndPasswordTextField(viewModel: viewModel)
            LoginButton(viewModel: viewModel)
            Spacer()
        }.padding(.top, 160)
        .keyboardAdaptive()
    }
}

// MARK: - Login Button
private struct LoginButton: View {
    
    //var moviesViewModel: Mov
    
    @State private var showingAlert = false
    @ObservedObject var viewModel: LoginViewModel
    @State private var isPresented = false
    
    var body: some View {
        Button(action: {
            print("button pressed")
            
            
            
            //print(viewModel.loginModel.success)
            print("showing alert is \(showingAlert)")
            UIApplication.shared.endEditing()
            viewModel.signIn() { success in
                print("complition block is started")
                if success {
                    self.isPresented.toggle()
                    print("please!!!")
                    
                    showingAlert = false
                } else {
                    showingAlert = true
                }
            }
        }) {
            Text("Login")
                .font(.title)
                .frame(minWidth: 0, maxWidth: .infinity)
                .contentShape(Rectangle())
                .padding()
                .background(Color.black)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .fullScreenCover(isPresented: $isPresented, content: MoviesListView.init)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Something went wrong!"), message: Text("Please, check Your login credits and try again"), dismissButton: .cancel(Text("Got it!")))
        }
        .padding(EdgeInsets(top: 50, leading: 30, bottom: 0, trailing: 30))
    }
}



// MARK: - Email & Password Text Fields
private struct EmailAndPasswordTextField: View {
    
    var limitText = 20
    @ObservedObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("User name", text: $viewModel.userName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onReceive(Just(viewModel.userName), perform: { _ in  viewModel.limitText(limitText)})
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onReceive(Just(viewModel.password), perform: { _ in viewModel.limitText(limitText)})
        }.padding(EdgeInsets(top: 100, leading: 30, bottom: 0, trailing: 30))
        
    }
    
}



// MARK: - Canvas Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}


