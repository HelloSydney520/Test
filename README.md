## Getting Started
1. Install CocoaPods & XCode 11.
1. Clone the repository.
1. Run `make bootstrap` to install tools and dependencies.
1. Run `make test-all` to build and run unit testing & snapshot testing & UI testing. 
1. Go to Build/Logs/Test to check test report which has code coverage.

## Highlights
* Use RxSwift & MVVM to make controller slim and passive, most business logic is in ViewModel.
* Use SwiftLint to enforce Swift style and conventions.
* Use materialize operator to handle API response errors.
* Use protocol oriented programming to create different environments. Replace the environment using mock service to make testing very easily.