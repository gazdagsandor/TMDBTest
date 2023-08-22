# BragiMovies

## Inatallation

1. checkout
2. go to the project root filder (the same location where the BragiMovies.xcodeproj file is)
3. execute `bundle install`
4. execute `bundle exec pod install`
5. execute `open BragiMovies.xcworkspace`
6. in XCode press the Run button or use the `Cmd+R` shortcut

### Third parties

- RxSwift/RxCocoa - for reactive behaviour
- Kingsfisher - for image loading

## Architecture

Partial MVVM+C + UseCase + Repository due to the lack of screens. Partial because the Coordinator layer has no parent/children handling because of the lack of time and screen hierarchy.

### Business layers

The Business facing layers are the UseCase (`TMDBUseCase`) and Repository (`TMDBRepository`) layers. 

### Networking

A simple URLSession implementation (Copy pasted from a combine based previous one and changed for Rx)

### Known issues

- Genre list glitching out on scrolling back from the end after a selection of a genre from the end.
- Unit tests needed at the least
- Use case layer shallow while VM layer and UI overcrowded
