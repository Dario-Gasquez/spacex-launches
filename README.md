[![Build Status](https://travis-ci.com/Dario-Gasquez/spacex-launches.svg)](https://travis-ci.com/Dario-Gasquez/spacex-launches)

# Space X Launches
A small iOS sample app that retrieves and shows Space X launches information by consuming the information provided by the [Space X API](https://github.com/r-spacex/SpaceX-API).

## Requirements
1. Xcode 12

## Install Instructions
1. Download the zip file or clone the project from [here](https://github.com/Dario-Gasquez/spacex-launches)
2. Open LightweightMVVM/SpaceX.xcodeproj
3. Compile and Run

NOTES: 
- Although Carthage was used to include [Kingfisher](https://github.com/onevcat/Kingfisher), you should be able to compile the application without interacting with this dependency manager.
- This project is configured to run [SwiftLint](https://github.com/realm/SwiftLint), if installed. A few violations have been left on purpose to ilustrate the use of SwiftLint.

## Description
### Architecture
I tried to strike a balance between choosing a robust architecture on one hand and avoiding needless complexity or solution over-design on the other.
A lightweight MVVM architecture was used in the creation of Space X Launches. Functionality was divided in the following layers (which match some of the Xcode project groups names): `Model`, `ViewModel`, `Service`, `Persistence`, `Networking` and `ViewController`.

#### Lightweight MVVM
I will elaborate briefly on what I mean by this. The decision to use the *lightweight* term lies mainly in a couple of reasons:
- There is no data binding mechanism between the viewModel and the model. This would allow, for example, to update the model based on 
user actions (this is not needed in this application as all the screens / views are "read only").
- The viewModel is mainly a data type responsible to adapt the model to the needs of a particular view and only contains the specific presentation logic for that view. It does not contain business logic, interaction with the networking layer or other functionality. I think this is good to keep the viewModel's role consistent with its name, and additionaly avoids violating the [Single responsibility principle](https://en.wikipedia.org/wiki/Single_responsibility_principle).

##### ViewModel approach: additional references
The viewModel approach for this project is inspired by those presented in the following articles:

[Our View on View Models](https://blog.lickability.com/our-view-on-view-models-4bb1d0675038)

[The MVVM Pattern for iOS Apps in Swift: a Pragmatic Approach](https://matteomanferdini.com/mvvm-pattern-ios-swift/)

Additional food for thought regarding pros and cons of MVVM:

[MVVM is Not Very Good](http://khanlou.com/2015/12/mvvm-is-not-very-good/)

[Advantages and disadvantages of M-V-VM](https://blogs.msdn.microsoft.com/johngossman/2006/03/04/advantages-and-disadvantages-of-m-v-vm/)

### Third Party Libraries
Although I try to keep the use of external libraries to a minimum (due to the risks related to having external dependencies), some of them allow us to save effort and avoid us having to reinvent the wheel.

I decided to use [Kingfisher](https://github.com/onevcat/Kingfisher) to provide the images download and caching functionality of the App. It was added with the help of [Carthage](https://github.com/Carthage/Carthage).


## Requirements
### 1. Retrieve the list of Space X launches in JSON format
This functionality is the main responsibility of `LaunchesService`, with the help of the `Networking` layer. It also converts the received JSON data to the model and view model used in the App. The information is saved to disk with the help of the `LaunchesDataStore` in the `Persistence` layer.

### 2. First Screen: display a list of Space X launches
`LaunchesViewController` and `LaunchCollectionViewCell` are in charge of displaying this information. They use the `LaunchViewModel` provided by `LaunchesService`.
An error message is shown if no information was retrieved (for example if no internet connection is available and there is no cached data saved in disk).

### 3. Second Screen: Launch details
I used `LaunchDetailsViewController` and `LaunchDetailsView` to provide this functionality, with the help of the `LaunchViewModel` generated by `LaunchesService`.

### 4. Parallax Effect
When the user scrolls in the launches screen, a parallax effect can be seen. This functionality is provided by `ParallaxFlowLayout` (a custom flow layout class). An approach with less coding was possible, but it involved adding the parallax code to the `LaunchesViewController` which was not desired. This approach also gives us finer control on the desired collection view layout and visual effects.

### 5. Launch web article
In the launch details screen the launch's web article is displayed (if available). This was achieved by adding a web view (`WKWebView`) below the mission details label in the Main storyboard. Additonal changes were made as required for example to `LaunchViewModel` and `LaunchDetailsView`.

### 6. Mission Patch Image Stretch Effect
If the content in the launch details screen is scrollable, then the mission patch image is stretched when the user scrolls down. This was implemented in `LaunchDetailsView` by aplying a scale and translate `CGAffineTransform` when the scroll down is detected.

### 7. MultiColumn mode
In the launches screen there is a new toolbar at the bottom with two buttons that allow the user to change between 1 or 2 columns modes. 
To implement this feature, a new `UICollectionView` subclass named `MultiColumnCollectionView` was added as well as new image assets for the toolbar buttons, changes in the Main storyboard, `LaunchesViewController` and `ParallaxFlowLayout`.

### 8. Hide/Show navigation and tool bars on swipe
In the launches screen, when the user swipes up both navigation and tool bars are hidden, and when they swipe down they are shown again.
A very simple solution using `UINavigationController`'s `hidesBarsOnSwipe` property was implemented. If a different result is required (for example while dragging instead of swiping) a more complex solution would be needed. In this scenario `UIScrollViewDelegate` methods: `scrollViewDidScroll` and/or `scrollViewWillBeginDragging` might come handy.


## Extra Functionality Implemented
### 1. i18n & l10n
The App was internationalized and partially localized (to English and Spanish).

### 2. Testing
The `SpaceXTests` target provides some unit tests for the `LaunchesService` and `LaunchViewModel`. In a similar way `SpaceXUITests` includes a couple of UI tests.

### 3. Persistence
`LaunchesDataStore` provides methods to save (or load) to disk the launches information retrieved from the backend. This is implemented by saving the information to a .plist file, whose format is compatible with the JSON format received.
NOTE: Other solutions like Core Data or Realm were considered needlessly complex for the current App's model.

### 4. Pull to Refresh
The user is able to refresh the information shown in the launches list screen by using the pull to refresh feature.


### 7. Mission Patch Image Stretch Effect
If the content in the launch details screen is scrollable, then the mission patch image is stretched when the user scrolls down. This was implemented in `LaunchDetailsView` by aplying a scale and translate `CGAffineTransform` when the scroll down is detected.

## Troubleshooting
### Module compiled with Swift version.x cannot be imported by the Swift version.y compiler (Kingfisher)
Update the library using the following command:
`carthage update Kingfisher --platform iOS --no-use-binaries`
