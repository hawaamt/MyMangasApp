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
    
    private var task: Task<Void, Never>?
    
    var interactor: UserInteractor
    
    init(interactor: UserInteractor = UserInteractor()) {
        self.interactor = interactor
        isNotLogged = !KeychainManager.shared.isUserLogged
        task = Task {
            for await _ in NotificationCenter.default.notifications(named: .logout, object: nil) {
                logout()
            }
        }
    }
    
    var accessTypeSelected: AccessType {
        AccessType(rawValue: segmentSelected) ?? .login
    }
    
    func login() {
        let isEmailValid = validateEmail()
        let isPasswordValid = validatePassword()
        guard isEmailValid,
              isPasswordValid else { return }
        
        let model = UserModel(email: email.lowercased(), password: password)
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
    
    func register() {
        let isEmailValid = validateEmail()
        let isPasswordValid = validatePassword()
        let isConfirmPasswordValid = validateConfirmPassword()
        guard isEmailValid,
              isPasswordValid,
              isConfirmPasswordValid else { return }
        
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
        
    func validateEmail() -> Bool {
        if email.isEmpty {
            errorEmail = "required_error"
            return false
        }
        let isEmailValidated = isValidEmail(email)
        if !isEmailValidated {
            errorEmail = "email_format_error"
            return false
        }
        return true
    }
    
    func validatePassword() -> Bool {
        if password.isEmpty {
            errorPassword = "required_error"
            return false
        }
        let isPasswordValidated = password.count > 7
        if !isPasswordValidated {
            errorPassword = "password_length_error"
            return false
        }
        return true
    }
    
    func validateConfirmPassword() -> Bool {
        let passwordsEquals = password == confirmPassword && !password.isEmpty
        if !passwordsEquals {
            errorConfirmPassword = "passwords_distinct_error"
            return false
        }
        return true
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
extension AccessViewModel {
    
    func logout() {
        interactor.logout()
        isNotLogged = true
    }
}
