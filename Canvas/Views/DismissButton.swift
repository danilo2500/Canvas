//
//  DismissButton.swift
//  Canvas
//
//  Created by Danilo Henrique on 06/02/25.
//

import SwiftUI

struct DismissButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.gray)
        }
    }
}
