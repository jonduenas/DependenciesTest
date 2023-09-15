//
//  ContentView.swift
//  DependenciesTest
//
//  Created by Jon Duenas on 9/15/23.
//

import Dependencies
import SwiftUI
import SwiftUINavigation

@Observable
class ContentViewModel {
    enum Destination {
        case child(ChildViewModel)
    }

    var sheetDestination: Destination?

    // If I uncomment this, everything passes and no errors
    // @Dependency(\.date.now) private var now

    func childButtonTapped() {
        // This causes a runtime error when not running tests
        // because ContentViewModel doesn't have any dependencies
        // and isn't created from a higher up `withDependencies`.
        // But if I remove it, I get test failures.
        withDependencies(from: self) {
            sheetDestination = .child(ChildViewModel())
        }

        // If I don't wrap this in `withDependencies`, I get a test failure
        // sheetDestination = .child(ChildViewModel())
    }
}

struct ContentView: View {
    @State private var viewModel = ContentViewModel()

    var body: some View {
        Button("Child") {
            viewModel.childButtonTapped()
        }
        .padding()
        .sheet(
            unwrapping: $viewModel.sheetDestination,
            case: /ContentViewModel.Destination.child
        ) { $viewModel in
            ChildView(viewModel: viewModel)
        }
    }
}

#Preview {
    ContentView()
}
