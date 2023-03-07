//
//  StartButtonView.swift
//  Payback
//
//  Created by Иван Вдовин on 25.10.2022.
//

import SwiftUI

struct StartButtonView: View {
    @AppStorage("isStartView") var isStartView: Bool?

    var body: some View {
        Button(action: {
            isStartView = false
        }) {
            HStack(spacing: 8) {
                Text("Начать")
                Image(systemName: "arrow.right.circle")
                    .imageScale(.large)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                Capsule().strokeBorder(.white, lineWidth: 1.25))
        }
        .accentColor(.white)
    }
}

struct StartButtonView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonView()
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
    }
}
