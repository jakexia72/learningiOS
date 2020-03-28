//
//  CircleImage.swift
//  Landmarks
//
//  Created by Jake Xia on 2020-03-28.
//  Copyright © 2020 Jake Xia. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
    Image("location")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .clipShape(Circle())
        .overlay(
            Circle().stroke(Color.white, lineWidth: 5)
        )
        .shadow(radius: 10)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
