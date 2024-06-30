# GitCoredata

GitCoredata is an iOS application built using SwiftUI, Swift, MVVM, and CoreData. The app allows users to search for GitHub repositories, view repository details, and view contributors. The app also supports offline storage for the first 15 search results.

## Features

- **Home Screen**:
  - A search bar to search for repositories using GitHub API.
  - A list view to display search results with pagination (10 items per page).
  - Clicking on a repository navigates to the repository detail screen.
  - Offline storage for the first 15 search results.

- **Repository Details Screen**:
  - Displays detailed information about the selected repository.
  - Information includes repository name, owner avatar, project link, description, and contributors.
  - Clicking on the project link opens the link in a web view.
  - Clicking on a contributor displays the repositories tagged to the contributor.

## Screenshots

![Home Screen](https://github.com/gembalisandesh/GitCoredata/assets/93411433/8cd6f1d5-367c-47a7-b7b3-cc74c1267034)
*Home Screen with search bar and repository list*

![Repository Details Screen](https://github.com/gembalisandesh/GitCoredata/assets/93411433/74e9a1e1-e852-4239-8174-2924d3f7b49c)
*Repository Details Screen showing repository information and contributors*

![Contributor Repositories Screen](https://github.com/gembalisandesh/GitCoredata/assets/93411433/9f7d7b7e-0eca-4ffd-a724-1bdac1347cb0)
*Contributor Repositories Screen showing repositories tagged to the contributor*

## Requirements

- iOS 15.0+
- Xcode 14.0+
- Swift 5.0+

## Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/gembalisandesh/GitCoredata.git
    cd GitSearchWithCoredata
    ```

2. Open the project in Xcode:
    ```sh
    open GitCoredata.xcodeproj
    ```

3. Build and run the project on the simulator or a physical device.

## Usage

1. On the Home Screen, use the search bar to search for GitHub repositories.
2. The search results are displayed in a list view.
3. Click on a repository to view its details.
4. On the Repository Details Screen, you can see the repository's name, owner avatar, project link, description, and contributors.
5. Click on the project link to open it in a web view.
6. Click on a contributor to view their repositories.

## Architecture

The application follows the MVVM (Model-View-ViewModel) architecture pattern.

- **Model**: Defines the data structures for repositories and contributors.
- **View**: SwiftUI views for the Home Screen, Repository Details Screen, and Contributor Repositories Screen.
- **ViewModel**: Manages the data and business logic for each view, including fetching data from the GitHub API and CoreData.

## CoreData

The application uses CoreData for offline storage. The first 15 search results are saved to CoreData, allowing users to view them even when offline.

- `CachedRepository`: Entity representing a cached repository.
- `CachedOwner`: Entity representing a cached owner.

## GitHub API

The application interacts with the GitHub API to search for repositories and fetch repository details and contributors.


## Contributing

Contributions are welcome! Please fork the repository and create a pull request with your changes.

## Acknowledgments

- [GitHub API](https://developer.github.com/v3/)
- [SwiftUI](https://developer.apple.com/documentation/swiftui/)
- [CoreData](https://developer.apple.com/documentation/coredata/)

## Contact

For any inquiries, please contact [gembalisandesh](https://github.com/gembalisandesh).
