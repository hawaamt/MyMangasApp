//
//  AccessView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 27/8/24.
//

import SwiftUI

struct AccessView: View {
    
    @Environment(AccessViewModel.self) private var viewModel
    
    var body: some View {
        @Bindable var viewModel = viewModel
        
        NavigationStack {
            ScrollView {
                VStack {
                    Picker("", selection: $viewModel.segmentSelected) {
                        ForEach(AccessType.allCases, id: \.self) { item in
                            Text(item.title)
                                .tag(item.rawValue)
                        }
                    }
                    .padding(.vertical, 40)
                    .pickerStyle(.segmented)
                    
                    switch viewModel.accessTypeSelected {
                    case .login:
                        emailView
                        passwordView
                        loginButton
                    case .register:
                        emailView
                        passwordView
                        confirmPassword
                        registerButton
                    }
                    Spacer()
                }
                .padding()
            }
            .toast(toastView: ToastView(text: viewModel.accessError, type: .error, position: .bottom, show: $viewModel.showAccessError),
                   show: $viewModel.showAccessError)
        }
    }
}

extension AccessView {
    
    @ViewBuilder
    var emailView: some View {
        @Bindable var viewModel = viewModel
        InputView(title: "access_email_title",
                  placeholder: "access_email_placeholder",
                  text: $viewModel.email,
                  textContentType: .emailAddress,
                  keyboardType: .emailAddress,
                  error: viewModel.errorEmail)
        .padding(.bottom)
    }
    
    @ViewBuilder
    var passwordView: some View {
        @Bindable var viewModel = viewModel
        InputView(title: "access_password_title",
                  placeholder: "access_password_placeholder",
                  text: $viewModel.password,
                  isSecure: true,
                  error: viewModel.errorPassword)
        .padding(.bottom)
    }
    
    @ViewBuilder
    var confirmPassword: some View {
        @Bindable var viewModel = viewModel
        InputView(title: "access_confirm_password_title",
                  placeholder: "access_confirm_password_placeholder",
                  text: $viewModel.confirmPassword,
                  isSecure: true,
                  error: viewModel.errorConfirmPassword)
        .padding(.bottom)
    }
    
    var loginButton: some View {
        Button {
            viewModel.login()
        } label: {
            Text("access_login_submit")
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .fontWeight(.medium)
                .frame(height: 40)
        }
        .buttonStyle(.borderedProminent)
    }
    
    var registerButton: some View {
        Button {
            viewModel.register()
        } label: {
            Text("access_register_submit")
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
                .fontWeight(.medium)
                .frame(height: 40)
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    AccessView()
        .environment(AccessViewModel())
}
