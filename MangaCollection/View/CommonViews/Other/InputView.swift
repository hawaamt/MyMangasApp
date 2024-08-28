//
//  InputView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 28/8/24.
//

import SwiftUI

struct InputView: View {
    var title: String
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var submitLabel: SubmitLabel = .done
    var textContentType: UITextContentType? = nil
    var keyboardType: UIKeyboardType = .default
    var error: String? = nil
    var onSubmit: (() -> Void)? = nil
    var onEditingChanged: ((Bool) -> Void)? = nil
    
    var body: some View {
        VStack {
            Text(LocalizedStringKey(title))
                .leadingAlign()
                .font(.subheadline)
                .fontWeight(.medium)
            if isSecure {
                SecureField(LocalizedStringKey(placeholder),
                            text: $text)
                    .customStyle
                    .submitLabel(submitLabel)
                    .textContentType(textContentType)
                    .keyboardType(keyboardType)
                    .autocorrectionDisabled()
                    .foregroundColor(.text)
                    .onSubmit {
                        onSubmit?()
                    }
            } else {
                TextField(LocalizedStringKey(placeholder),
                          text: $text,
                          onEditingChanged: { editingChanged in
                    onEditingChanged?(editingChanged)
                })
                .customStyle
                .submitLabel(submitLabel)
                .textContentType(textContentType)
                .keyboardType(keyboardType)
                .autocorrectionDisabled()
                .foregroundColor(.text)
                .onSubmit {
                    onSubmit?()
                }
            }
            if let error {
                Text(LocalizedStringKey(error))
                    .leadingAlign()
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundColor(Color(.error))
            }
        }
    }
}

#Preview {
    @State var text = ""
    return InputView(title: "Input",
                     placeholder: "Input placeholder",
                     text: $text,
                     error: "This is the error")
    .padding()
}
