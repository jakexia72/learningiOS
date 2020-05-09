//
//  CategoryHome.swift
//  Landmarks
//
//  Created by Jake on 2020-05-08.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI

struct CategoryHome: View {
    var categories: [String: [Landmark]] {
        Dictionary(
            grouping: landmarkData,
            by: { $0.category.rawValue }
        )
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(categories.keys.sorted(), id: \.self){
                    key in
                    Text(key)
                }
            }
                .navigationBarTitle(Text("Featured"))
        }
    }
}

struct CategoryHome_Previews: PreviewProvider {
    static var previews: some View {
        CategoryHome()
    }
}
