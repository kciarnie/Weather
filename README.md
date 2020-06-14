# Weather
App Presents information in the view about the temperature, time, date and weather icon in a form of a list, where each row contains all forecasts for a certain day, scrollable of the screen to the right

## Notes
This is a coding challenge from a company. The notes are in the following file: [e-mail.txt](email-txt)

### Features
- User is presented with a list of cities that they can click on to go to the Weather Details View
- [openWeather API](https://openweathermap.org/) is used
- When app starts it loads the live forcast for default city.
- App supports only the portrait orientation.
- App supports dark mode. 
- App supports iOS version 13.x and above. Tested on iPhone SE (2nd Generation) simulator.

## Sample Screens

## Getting Started
 
### Prerequisites

You would need a macbook with XCode 11.x installed. I built the app with XCode 11.5 (11E608c)

### Installing Builds

- To be able to install the build on the iPhone you will be needing Apple Developer provisioning and certifcate. You can create your Apple developer account [here](https://developer.apple.com/).
- You can create build on iOS 13.x or later simulator provided with the XCode 11.x or later.
- To run the project Navigate to the *Weather* folder on your machine where you cloned it. Open the project using *Weather.xcodeproj* file. To run the project, type COMMAND+R (⌘+R).

## User Guide to use the app
- On Launch if app is connected to the internet it automatically fetches forcast for deafult city.
- By clicking on a city, it will go to the next screen which is the details screen of the city and fetch the data of the city clicked.

## Technical Details

### Third Party
- No third party library is used.

### App Architecture
- MVVM Architecture is used in the app. It was chosen because of my familiarity of it with both the Android Framework and the new patterns being used for iOS.
- Network layer is based on protocol oriented design. 
- [Codeable Protocl](https://developer.apple.com/documentation/swift/codable) is used to parse JSON into `struct` objects

### Code Structure
Code is divided into following Groups
- AppDeleagte  group contains the xcode auto generated AppDelegate and SceneDelegate classes.
- Constants group contains  Constant file which stores all the constants used across the app.
- Utlities contains AlertService protocol, Utility struct, Extension, DataModelDecoder. This code is reusable generic code used through out the app.
- Networking group contains all the files related to network layer. It contains sub groups of Reachability, NetworkHandler, NetworkRouting, HTTPHandlers, EndPoints and Services.
- Models group contains the *ForcastResult*,*Forcast*,*WeatherParticular*,*Weather*,*City* models being used in the app.
- Constants group contains all the constants being used across the app.
- Source group contains the modules with their respetive view, view controllers, collection cells, collection headers and view models. Source group contains further subgroups named WeatherHome, AutoComplete, Binder.
- Home subgroup contains *WeatherViewController* and *WeatherViewModel*  for main forcast view. *WeatherCollectionCell*, *WeatherCollectionCellViewModel* and *DateHeaderCollectionReusableView* for displaying date wise weather forcast.
- Binder subgroup contains Bindable swift class. Its a generic type which provides a closure to be bind on the value so that events can be triggered on value change.

### Unit Tests
- Unit test will be written and provide a code coverage of some high percentage.

Unit tests are arranged in two subgroups:
- ViewModel subgroup contains tests written on ViewModels
- Networking subgroup contains tests written on Network Services

Following test cases are written:
- Weather Service test for checking if forcast is fetched correctly.
- Image Service test for checking if weather icon image is fetched correctly.
- Url encoding test for URLEncoder to see if urls are being configured correctly.

## Built With
- XCode 11.5 (11E608c)
- Tested on iPhone SE (2nd Generation) simulator

## Authors

- **Kevin Ciarniello ** - (https://github.com/kciarnie)

## Acknowledgement

- [Weather Icon Pack](https://erikflowers.github.io/weather-icons/)
- [Beautiful Minimal design](https://flutterawesome.com/an-elegant-easy-on-the-eyes-weather-app-build-with-flutter/)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details




