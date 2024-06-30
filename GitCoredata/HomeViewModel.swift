//
//  HomeViewModel.swift
//  GitCoredata
//
//  Created by user263604 on 6/29/24
6/29/24.
//

import Combine
import SwiftUI
import CoreData

class HomeViewModel: ObservableObject {
    @Published var repositories = [Repository]()
    @Published var searchText = ""
    @Published var page = 1

    private var cancellables = Set<AnyCancellable>()
    private let gitHubAPIService: GitHubAPIService
    private let context: NSManagedObjectContext

    init(authToken: String? = nil, context: NSManagedObjectContext) {
        self.gitHubAPIService = GitHubAPIService(authToken: authToken)
        self.context = context
        setupSearchSubscription()
    }

    func setupSearchSubscription() {
        $searchText
            .debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .flatMap { [weak self] query -> AnyPublisher<[Repository], Never> in
                guard let self = self, !query.isEmpty else { return Just([]).eraseToAnyPublisher() }
                self.page = 1 // Reset the page when a new search is initiated
                return self.gitHubAPIService.searchRepositories(query: query, page: self.page)
                    .catch { _ in Just([]) }
                    .receive(on: DispatchQueue.main)
                    .handleEvents(receiveOutput: { [weak self] repos in
                        self?.saveToCoreData(repositories: repos)
                    })
                    .eraseToAnyPublisher()
            }
            .receive(on: DispatchQueue.main)
            .assign(to: \.repositories, on: self)
            .store(in: &cancellables)
    }

    func loadMoreRepositories() {
        page += 1
        gitHubAPIService.searchRepositories(query: searchText, page: page)
            .catch { _ in Just([]) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] newRepos in
                self?.repositories.append(contentsOf: newRepos)
                self?.saveToCoreData(repositories: newRepos)
            })
            .store(in: &cancellables)
    }

    private func saveToCoreData(repositories: [Repository]) {
        context.perform {
            for repo in repositories.prefix(15) {
                let cachedRepo = CachedRepository(context: self.context)
                cachedRepo.id = Int64(repo.id)
                cachedRepo.name = repo.name
                cachedRepo.desc = repo.description
                cachedRepo.html_url = repo.html_url
                cachedRepo.contributors_url = repo.contributors_url

                let owner = CachedOwner(context: self.context)
                owner.login = repo.owner.login
                owner.avatar_url = repo.owner.avatar_url
                cachedRepo.owner = owner

                try? self.context.save()
            }
        }
    }

    func fetchOfflineData() {
        let fetchRequest: NSFetchRequest<CachedRepository> = CachedRepository.fetchRequest()

        do {
            let cachedRepositories = try context.fetch(fetchRequest)
            self.repositories = cachedRepositories.map { repo in
                Repository(
                    id: Int(repo.id),
                    name: repo.name ?? "",
                    owner: Repository.Owner(
                        avatar_url: repo.owner?.avatar_url ?? "",
                        login: repo.owner?.login ?? ""
                    ),
                    description: repo.desc,
                    html_url: repo.html_url ?? "",
                    contributors_url: repo.contributors_url
                )
            }
        } catch {
            print("Failed to fetch cached repositories: \(error)")
        }
    }
}
