//
//  StartView.swift
//  Payback
//
//  Created by Иван Вдовин on 25.10.2022.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        ZStack {
            HStack {
                VStack(spacing: 20) {
                    Text("Payback")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                    StartButtonView()
                }
            }
            .background(Capsule()
                .fill(.blue)
                .frame(width: 200, height: 200))
        }
        .background(Image("Payback"))
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .previewLayout(.fixed(width: 320, height: 640))
    }
}
