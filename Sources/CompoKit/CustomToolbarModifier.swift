//
//  CustomToolbarModifier.swift
//  ScoresAppSwiftUI
//
//  Created by Jon Gonzalez on 25/3/25.
//

import SwiftUI

public enum SortedBy: String, CaseIterable, Identifiable {
    case byID = "By Default"
    case ascending = "By Title Ascending"
    case descending = "By Title Descending"

    public var id: Self { self }
}

private struct CustomToolbarModifier: ViewModifier {
    @Binding var sorted: SortedBy
    func body(content: Content) -> some View {
        content
            .toolbar {
                #if os(macOS)
                ToolbarItem(placement: .secondaryAction) {
                    menu
                }
                #else
                ToolbarItem(placement: .topBarLeading) {
                    menu
                }
                #endif
            }
    }

    var menu: some View {
        Menu {
            ForEach(SortedBy.allCases) { option in
                Button {
                    sorted = option
                } label: {
                    Text(option.rawValue)
                }

            }
        } label: {
            Text("Order by")
        }
    }
}

extension View {
    public func customToolbar(_ sorted: Binding<SortedBy>) -> some View {
        modifier(CustomToolbarModifier(sorted: sorted))
    }
}
