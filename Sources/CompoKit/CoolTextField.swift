//
//  CoolTextField.swift
//  ScoresAppSwiftUI
//
//  Created by Jon Gonzalez on 26/3/25.
//

import SwiftUI

public struct CoolTextField: View {
    let titleLabel: String
    let placeholder: String
    @Binding var value: String
    let validation: (String) -> String?

    @State private var error: String?

    public init(titleLabel: String,
                placeholder: String,
                value: Binding<String>,
                validation: @escaping (String) -> String?) {
        self.titleLabel = titleLabel
        self.placeholder = placeholder
        self._value = value
        self.validation = validation
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Text(titleLabel)
                .font(.headline)
                .padding(.leading)
            HStack(alignment: .top) {
                TextField(placeholder, text: $value, axis: .vertical)
                if !value.isEmpty {
                    Button {
                        value = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                    }
                    .buttonStyle(.plain)
                    .opacity(0.2)
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
            .background {
                Color.secondary.opacity(0.1)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 3)
                    .fill(.linearGradient(colors: [.red.opacity(0.9), .red.opacity(0.5)], startPoint: .leading, endPoint: .trailing))
                    .opacity(error != nil ? 1 : 0)
            }

            Text("\(titleLabel) \(error ?? "")")
                .font(.caption)
                .foregroundStyle(.red)
                .padding(.leading)
                .opacity(error != nil ? 1 : 0)
        }
        .onChange(of: value) {
            error = validation(value)
        }
        .animation(.bouncy, value: error)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(titleLabel))
    }
}

#Preview {
    @Previewable @State var value = ""
    CoolTextField(titleLabel: "Title of the score", placeholder: "Enter the title", value: $value) {
        $0.isEmpty ? "cannot be empty" : nil
    }
}
