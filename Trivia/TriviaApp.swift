//
//  TriviaApp.swift
//  Trivia
//
//  Created by Jasper on 21.04.24.
//

import SwiftUI

@main
struct TriviaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.font, Font.system(.body, design: .rounded))
        }
    }
}
