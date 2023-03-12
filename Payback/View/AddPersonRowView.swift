//
//  AddPersonRowView.swift
//  Payback
//
//  Created by Иван Вдовин on 10.03.2023.
//

import SwiftUI

struct AddPersonRowView: View {
    var body: some View {
        Button(
            action: {
            
            },
            label: {
                ZStack {
                    Image("")
                        .frame(width: 70, height: 70)
                        .background(.gray)
                        .opacity(0.5)
                        .clipShape(SuperEllipseShape(rate: 0.9))
                    Image(systemName: "plus")
                        .frame(width: 30, height: 30)
                }
            }
        )
    }
}

struct AddPersonRowView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonRowView()
    }
}
