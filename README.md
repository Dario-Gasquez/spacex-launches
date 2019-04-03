# Space X Launches
A small iOS sample app that retrieves and shows Space X launches information

## Install Instructions
1. Download the zip file or clone the project from [here](https://github.com/Dario-Gasquez/spacex-launches)
2. Open ProjectName.xcodeproj
3. Compile and Run

NOTES: 
- Xcode 10.x was used to create this project.
- Although Carthage was used to include an external dependency, you should be able to compile the app without interacting with this dependency manager.

## Description
### Architecture
I tried to strike a balance between choosing a robust architecture on one hand and avoiding needless complexity or solution over-design on the other.
A lightweight MVVM architecture was used in the creation of Space X Launches. Functionality was divided in the following layers (which match some of the Xcode project groups names): `Model`, `ViewModel`, `Service`, `Persistence`, `Networking` and `ViewController`.

### Third Party Libraries
Although I try to keep the use of external libraries to a minimum (due to the risks related to having external dependencies), some of them allow us to save effort and avoid us having to reinvent the wheel.

I decided to use [Kingfisher](https://github.com/onevcat/Kingfisher) to provide the images download and caching functionality of the App. It was added with the help of [Carthage](https://github.com/Carthage/Carthage).


## Requirements
### 1. Retrieve the list of Space X launches in JSON format
This functionality is the main responsibility of `PlaceHolderNameService`, with the help of the `Networking` layer. It also converts the received JSON data to the model and view model used in the App. The information is saved to disk with the help of the `PlaceHolderNameDataStore` in the `Persistence` layer.

### 2. First Screen: display a list of Space X launches
`PlaceHolderNameViewController` and `PlaceHolderNameViewCell` are in charge of displaying this information. They use the `PlaceHolderNameViewModel` provided by `PlaceHolderNameService`.
An error message is shown if no information was retrieved (for example if no internet connection is available and there is no cached data saved in disk).

### 3. Second Screen: Launch details
I used `PlaceHolderNameViewController` and `SPlaceHolderNameView` to provide this functionality, with the help of the `PlaceHolderNameViewModel` provided by the `Service` layer.


## Extra Functionality Implemented
### 1. i18n & l10n
The App was internationalized and partially localized (to English and Spanish).

### 2. Testing
The `PlaceHolderNameTests` target provides some unit tests for the `PlaceHolderNameService` and `PlaceHolderNameViewModel`. Additional tests can be added to increase code coverage.

### 3. Persistence
`PlaceHolderNameDataStore` provides methods to save (or load) to disk the launches information retrieved from the backend. This is implemented by saving the information to a .plist file, whose format is compatible with the JSON format received.
NOTE: Other solutions like Core Data or Realm were considered needlessly complex for the current App's model.

### 4. Pull to Refresh
The user is able to refresh the information shown in the launches list screen by using the pull to refresh feature.
