//
//  ContributorReposViewModel.swift
//  GitCoredata
//
//  Created by user263604 on 6/29/24.
//

import Combine
class ContributorReposViewModel: ObservableObject {
    @Published var repositories = [Repository]()
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchRepositories(for user: String) {
        GitHubAPIService().fetchRepositories(for: user)
            .catch { _ in Just([]) }
            .assign(to: \.repositories, on: self)
            .store(in: &cancellables)
    }
}
