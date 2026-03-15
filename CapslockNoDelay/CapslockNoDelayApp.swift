//
//  CapslockNoDelayApp.swift
//  CapslockNoDelay
//
//  Created by Jiawei Chen on 2026/3/15.
//

import SwiftUI
import os

let logger = Logger()

@main
struct CapslockNoDelayApp: App {
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }

    init() {
        Task {
            await run()
            await MainActor.run {
                NSApp.terminate(nil)
            }
        }
    }
}

func run() async {
    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
    process.arguments = [
        "hidutil", "property", "--set", "{\"CapsLockDelayOverride\":0}",
    ]
    do {
        try process.run()
    } catch {
        logger
            .error(
                "ERROR: failed to execute capslock no-delay shell commands, error: \(error.localizedDescription)"
            )
    }
}
