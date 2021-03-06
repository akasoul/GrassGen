//
//  GrassGenApp.swift
//  GrassGen
//
//  Created by Anton Voloshuk on 17.01.2021.
//

import SwiftUI

@main
struct GrassGenApp: App {
    var model = decoderWrapper()
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(self.model)
        }
    }
}
