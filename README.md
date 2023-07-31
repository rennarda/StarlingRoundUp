#  StarlingRoundUp

**Author**: Andrew Rennard

This is an implementation of the Starling Bank Technical Challenge for iOS, using Swift 5.8 and UIKit.

The minimum deployment target was set to iOS 16 (following clarification of the requirements on Slack). It was developed using Xcode 15 beta 5.


## Architecture
There is only a single ViewController in the app, so no navigation is involved. MVVM is used, keeping the ViewController as minimal as possible, with most of the application logic in the ViewModel.

The ViewModel is written as an `ObservableObject` using `@Published` properties from the `Combine` framework. This is a *SwiftUI style* ViewModel, and in fact the ViewController could be swapped out for a SwiftUI view with no changes required to the ViewModel.

The APIClient implementation is generic over request and response types (`Encodable` and `Decodable` respectively) . Each service type defines the endpoints it requires to operate, and uses the APIClient to perform the networking actions. 

## Tests
There is full test coverage of the ViewModel. Test coverage has been demonstrated in other areas (eg the `SavingsService`), but not fully completed due to available time. Tests coverage could be extended using the techniques demonstrated. 

No UI tests were added, and have been disabled in the test plan, again due to available time. 

## Usage

* replace the access token in the `APIClient` with a working access token
* run the app
* select a start date from the date picker. The app will show if the 7 days after this date contain transactions that can be rounded up. 
* click the 'Round up' button to create the savings goal and transfer the roundup to it.


## Third party dependencies
No third party code or libraries are used. 
