//
//  CoolTextField.swift
//  ScoresAppSwiftUI
//
//  Created by Jon Gonzalez on 26/3/25.
//

import SwiftUI

public struct CoolTextField: View {
    let titleLabel: LocalizedStringResource
    let placeholder: LocalizedStringResource
    @Binding var value: String
    let validation: ValidationType
    let focus: Bool

    @State private var error: LocalizedStringResource?

    public init(titleLabel: LocalizedStringResource,
                placeholder: LocalizedStringResource,
                value: Binding<String>,
                validation: ValidationType,
                focus: Bool) {
        self.titleLabel = titleLabel
        self.placeholder = placeholder
        self._value = value
        self.validation = validation
        self.focus = focus
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Text(titleLabel)
                .font(.headline)
                .padding(.leading)
            HStack(alignment: .top) {
                TextField("\(placeholder)", text: $value, axis: .vertical)
                if !value.isEmpty && focus {
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
            error = validation.validate(value)
        }
        .animation(.bouncy, value: error)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(Text(titleLabel))
    }
}

#Preview {
    @Previewable @State var value = ""
    CoolTextField(titleLabel: "Title of the score",
                  placeholder: "Enter the title",
                  value: $value,
                  validation: .isNotEmpty,
                  focus: true)
}
