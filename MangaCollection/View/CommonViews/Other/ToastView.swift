//
//  ToastView.swift
//  MangaCollection
//
//  Created by Eva Gonzalez Ferreira on 24/8/24.
//

import SwiftUI

enum ToastType {
    case error
    case success
    case info
    
    var color: Color {
        switch self {
        case .error:
            return Color.errorBg
        case .success:
            return Color.success
        case .info:
            return Color.finished
        }
    }
}

enum ToastPosition {
    case top
    case bottom
}

struct ToastView: View {
    
    let text: LocalizedStringKey
    let type: ToastType
    let position: ToastPosition
    @Binding var show: Bool
    
    var body: some View {
        VStack {
            if position == .bottom {
                Spacer()
            }
            HStack {
                Text(text)
                    .font(.subheadline)
            }
            .font(.headline)
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity)
            .padding()
            .background(type.color)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            if position == .top {
                Spacer()
            }
        }
        .frame(width: UIScreen.main.bounds.width / 1.25)
        .transition(AnyTransition.move(edge: .bottom).combined(with: .opacity))
        .onTapGesture {
            withAnimation {
                self.show = false
            }
        }
        .onAppear(perform: {
            Task {
                try await Task.sleep(for: .seconds(5))
                withAnimation {
                    self.show = false
                }
            }
        })
    }
}

struct ToastModifier : ViewModifier {
    @Binding var show: Bool
    
    let toastView: ToastView
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if show {
                toastView
            }
        }
    }
}

extension View {
    func toast(toastView: ToastView, show: Binding<Bool>) -> some View {
        self.modifier(ToastModifier.init(show: show, toastView: toastView))
    }
}

#Preview {
    @State var show = true
    return ToastView(text: "filterBy_author_error", type: .error, position: .top, show: $show)
}
