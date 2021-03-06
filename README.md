# AppOpenTracker

AppOpenTracker provides an observable AppOpenTracker.shared instance that can be used to track
- the last version that the app was opened in
- the last build that the app was opened in
- how often the app was opened

AppOpenTracker also includes an `UpdateService` (thanks to [Antoine v. d. Lee](https://www.avanderlee.com/swift/app-update-notifier/?utm_campaign=coschedule&utm_source=twitter&utm_medium=twannl&utm_content=Creating%20an%20App%20Update%20Notifier%20using%20Combine%20and%20async%2Fawait)) that can be used to check for an available app update.

## Installation
AppOpenTracker can be installed via Swift Package Manager, just copy the repository URL into the respective Xcode window:

```
https://github.com/chFlorian/AppOpenTracker
```

## Usage
AppOpenTracker exposes a `shared` instance, that can be accessed like this:

```swift
import AppOpenTracker

struct ContentView: View {
  @ObservedObject private var appOpenTracker = AppOpenTracker.shared
}
```

There are several exposed `@Published` member variables:

| Name                     | Description                                                                    |
|--------------------------|--------------------------------------------------------------------------------|
| `versionFirstOpened`     | A flag that resembles wether this version was opened for the first time        |
| `countOfAppOpenedBefore` | A counter that keeps track of how often the app was opened before this session |
| `appIsFirstOpened`       | A flag that resembles wether this is the first time the user opened the app    |
