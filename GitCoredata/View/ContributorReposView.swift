//
//  ContributorReposView.swift
//  GitCoredata
//
//  Created by user263604 on 6/29/24
6/29/24.
//

import SwiftUI

struct ContributorReposView: View {
    var contributor: Contributor
    @StateObject private var viewModel = ContributorReposViewModel()
    
    var body: some View {
        List(viewModel.repositories) { repo in
            RepoRowView(repository: repo)
        }
        .onAppear {
            viewModel.fetchRepositories(for: contributor.login)
        }
    }
}
