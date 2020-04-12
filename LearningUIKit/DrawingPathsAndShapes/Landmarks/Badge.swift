//
//  Badge.swift
//  Landmarks
//
//  Created by Jake Xia on 2020-04-10.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct Badge: View {
    static let rotationCount = 10
    
    var badgeSymbols: some View {
        ForEach(0..<Badge.rotationCount){ i in
            RotatedBadgeSymbol(angle: .init(degrees: Double(i * (360 / Badge.rotationCount))))
        }
                        .opacity(0.5)

    }
    
    var body: some View {
        ZStack {
            BadgeBackground()
            GeometryReader { geometry in
                self.badgeSymbols
                    .scaleEffect(1/4, anchor: .top)
                    .position(x: geometry.size.width / 2.0, y: (3.0 / 4.0) * geometry.size.height)
            }
        }
    .scaledToFit()
    }
}

struct Badge_Previews: PreviewProvider {
    static var previews: some View {
        Badge()
    }
}
