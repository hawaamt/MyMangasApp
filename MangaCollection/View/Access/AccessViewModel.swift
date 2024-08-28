//
//  AccessViewModel.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 27/8/24.
//

import SwiftUI

enum AccessType: Int, CaseIterable {
    case login = 0
    case register = 1
    
    var title: LocalizedStringKey {
        switch self {
        case .login:
            LocalizedStringKey("access_login_title")
        case .register:
            LocalizedStringKey("access_register_title")
        }
    }
}

@Observable
class AccessViewModel {
    
    var email: String = "" {
        didSet { errorEmail = nil }
    }
    var password: String = "" {
        didSet { errorPassword = nil }
    }
    var confirmPassword: String = "" {
        didSet { errorConfirmPassword = nil }
    }
    
    var errorEmail: String?
    var errorPassword: String?
    var errorConfirmPassword: String?
    
    var segmentSelected: Int = AccessType.login.rawValue {
        didSet { clearData() }
    }
    
    var isLoading: Bool = false
    var showAccessError: Bool = false
    var accessError: String = ""
    
    var isNotLogged: Bool
    
    var interactor: UserInteractor
    
    init(interactor: UserInteractor = UserInteractor()) {
        self.interactor = interactor
        isNotLogged = !KeychainManager.shared.isUserLogged
        self.interactor.delegate = self
    }
    
    var accessTypeSelected: AccessType {
        AccessType(rawValue: segmentSelected) ?? .login
    }
    
    func register() {
        guard validateEmpty() else { return }
        guard validateTextfield() else { return }
        
        let model = UserModel(email: email, password: password)
        Task {
            do {
                isLoading = true
                _ = try await interactor.register(with: model)
                login()
            } catch {
                isLoading = false
                showAccessError = true
                accessError = "access_error"
            }
        }
    }
    
    func login() {
        guard validateEmpty() else { return }
        guard validateTextfield() else { return }
        
        let model = UserModel(email: email, password: password)
        Task {
            do {
                isLoading = true
                _ = try await interactor.login(with: model)
                isLoading = false
                isNotLogged = false
            } catch {
                isLoading = false
                showAccessError = true
                accessError = "access_error"
            }
        }
    }
    
    func validateEmpty() -> Bool {
        errorEmail = email.isEmpty ? "required_error" : nil
        errorPassword = email.isEmpty ? "required_error" : nil
        switch accessTypeSelected {
        case .login:
            return !email.isEmpty && !password.isEmpty
        case .register:
            errorConfirmPassword = confirmPassword.isEmpty ? "required_error" : nil
            return !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty
        }
    }
    
    func validateTextfield() -> Bool {
        let isEmailValidated = isValidEmail(email)
        errorEmail = !isEmailValidated ? "email_format_error" : nil
        
        let isPasswordValidated = password.count > 7
        errorPassword = !isPasswordValidated ? "password_length_error" : nil
        
        switch accessTypeSelected {
        case .login:
            return isEmailValidated && isPasswordValidated
        case .register:
            let passwordsEquals = password == confirmPassword
            errorConfirmPassword = !passwordsEquals ? "passwords_distinct_error" : nil
            return isEmailValidated && isPasswordValidated && passwordsEquals
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func clearData() {
        email = ""
        password = ""
        confirmPassword = ""
        errorEmail = nil
        errorPassword = nil
        errorConfirmPassword = nil
    }
}

// MARK: - Close session
extension AccessViewModel: LogoutDelegate {
    
    func logout() {
        interactor.logout()
        isNotLogged = true
    }
}
