//
//  KeychainManager.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 27/8/24.
//

import Foundation

enum KeychainItem: String {
    case token
}

struct KeychainManager {
    
    static let shared = KeychainManager(bundle: "hawaa.com.MangaCollection")
    
    private let bundle: String
    
    init(bundle: String) {
        self.bundle = bundle
    }
    
    func save(item: KeychainItem, _ value: String) -> Bool {
        guard let data = value.data(using: .utf8) else { return false }
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: bundle,
            kSecAttrAccount as String: item.rawValue,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        let result = SecItemAdd(query as CFDictionary, nil)
        
        guard result == errSecSuccess else {
            print("Error \(result)")
            return false
        }
        
        return true
    }
    
    func read(_ item: KeychainItem) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: bundle,
            kSecAttrAccount as String: item.rawValue,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let result = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard result == errSecSuccess else {
            print("Error \(result)")
            return nil
        }
        
        guard let data = item as? Data,
              let value = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return value
    }
    
    func delete(_ item: KeychainItem) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: bundle,
            kSecAttrAccount as String: item.rawValue
        ]
        
        let result = SecItemDelete(query as CFDictionary)
        
        guard result == errSecSuccess else {
            print("Error \(result)")
            return false
        }
        
        return true
    }
    
    var isUserLogged: Bool {
        read(.token) != nil
    }
}
