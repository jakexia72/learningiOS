//
//  ContentView.swift
//  Landmarks
//
//  Created by Jake Xia on 2020-03-07.
//  Copyright © 2020 Jake Xia. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MapView()
                .frame(height:300)
                .edgesIgnoringSafeArea(.top)
            CircleImage()
                .frame(height: 300)
                .offset(y: -130)
                .padding(.bottom, -130)
            VStack(alignment: .leading) {
                Text("This Is a Title")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.green)
                //Spacer()
                HStack {
                    Text("This is a Subtitle")
                        .font(.subheadline)
                    Spacer()
                    Text("Other Info")
                        .font(.subheadline)
                }
                
            }
            .padding()
         Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
