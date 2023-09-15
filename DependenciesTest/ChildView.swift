//
//  ChildView.swift
//  DependenciesTest
//
//  Created by Jon Duenas on 9/15/23.
//

import Dependencies
import SwiftUI

@Observable
class ChildViewModel {
    var date: Date

    init() {
        @Dependency(\.date.now) var now
        self.date = now
    }
}

struct ChildView: View {
    var viewModel: ChildViewModel

    var body: some View {
        Text(viewModel.date.formatted())
    }
}

#Preview {
    ChildView(viewModel: .init())
}
