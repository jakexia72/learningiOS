//
//  UserData.swift
//  Landmarks
//
//  Created by Jake Xia on 2020-04-07.
//  Copyright © 2020 Apple. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
    // final just means nothing else can inheret from it
    // Observable Object will allow swift UI to see changes and refresh views on changes
    
    @Published var showFavouritesOnly = false
    @Published var landmarks = landmarkData
    // Published allows for the creation of observable objects that automatically
    // announce when changes occur!!
    
}
