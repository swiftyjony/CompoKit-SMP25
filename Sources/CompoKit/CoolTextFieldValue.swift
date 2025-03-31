//
//  CoolTextFieldValue.swift
//  ScoresAppSwiftUI
//
//  Created by Jon Gonzalez on 26/3/25.
//

import SwiftUI

public struct CoolTextFieldValue<Format: ParseableFormatStyle>: View where Format.FormatOutput == String, Format.FormatInput: Equatable {
    let label: String
    let placeholder: String
    @Binding var value: Format.FormatInput
    let format: Format
    let validation: (Format.FormatInput) -> String?

    @State private var error: String?

    public init(label: String,
                placeholder: String,
                value: Binding<Format.FormatInput>,
                format: Format,
                validation: @escaping (Format.FormatInput) -> String?) {
        self.label = label
        self.placeholder = placeholder
        self._value = value
        self.format = format
        self.validation = validation
    }

    public var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.headline)
                .padding(.leading)
            HStack(alignment: .top) {
                TextField(placeholder, value: $value, format: format)
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

            Text("\(label) \(error ?? "")")
                .font(.caption)
                .foregroundStyle(.red)
                .padding(.leading)
                .opacity(error != nil ? 1 : 0)
        }
        .onChange(of: value) {
            error = validation(value)
        }
        .animation(.bouncy, value: error)
    }
}

#Preview {
    @Previewable @State var value = 1985
    CoolTextFieldValue(label: "Year", placeholder: "Enter the score year", value: $value, format: .number.precision(.integerLength(4))) {
        ($0 < 1900 || $0 > 2050) ? "invalid": nil
    }
}
