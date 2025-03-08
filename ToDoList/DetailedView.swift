//
//  DetailedView.swift
//  ToDoList
//
//  Created by Zhejun Zhang on 3/7/25.
//

import SwiftUI

struct DetailedView: View {
    var passedValue: String //Don't initialize it, it will be passed from the parent view
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        VStack {
            Image(systemName: "swift")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.orange)
            
            Text("You are a swift legend!\n And you passed over the value \(passedValue)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .minimumScaleFactor(0.5)
            
            Spacer()
            
            Button("Get back!") {
                dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
//        .navigationBarBackButtonHidden()
    }
}

#Preview {
    DetailedView(passedValue: "")
}
