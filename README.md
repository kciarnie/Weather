# Weather

This app shows the user a list of cities. From there, once clicked, the user can see a standard display of the weather details, followed by a weekly-overview forecast.


# Notes
This is a coding challenge from a company. The notes are in the following file: [e-mail.txt](email-txt)

### Features
- User is presented with a list of cities that they can click on to go to the Weather Details View
- [Dark Sky API](https://darksky.net/dev/docs) is used
- When app starts it loads the live forecast for default city.
- App supports only the portrait orientation.
- App supports dark mode. 
- App supports iOS version 13.x and above. Tested on iPhone SE (2nd Generation) simulator.

# Sample Screens

An example of the listview

![](screenshots/cities_list.png?raw=true)

and the details screen

![](screenshots/overview.png?raw=true)

## Getting Started
 
### Prerequisites

You would need a macbook with XCode 11.x installed. I built the app with XCode 11.5 (11E608c)

- Create a file in `Weather/Network/APIKey.swift` with the following:

```
//
//  APIKey.swift
//  Weather
//
//  Created by Kevin on 2020-06-16.
//  Copyright © 2020 Kevin Ciarniello. All rights reserved.
//

import Foundation

let DARKSKY_API_KEY = "xxxxxxxxxxxxxxxxxxxxxx"

```

Where `xxxxxxxxxxxxxxxxxxxxxx` is your API Key for Dark Sky. If you do not have one, please contact me at `kciarnie@gmail.com` and I can send you mine.

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
- [Codeable Protocol](https://developer.apple.com/documentation/swift/codable) is used to parse JSON into `struct` objects
- The main app is created with a UITableViewCell inside the header as the basis for showing all the information for the specific city
- the tableview is then filled with the forecast information using the `ForecastTableViewCell.xib`.
- The header cell is `HeaderTableViewCell.xib`
- The model, `DarkSkyViewModel.swift` is the viewModel that communicates between the `DarkSkyService.swift` and `WeatherDetailsViewController.swift`
- Font: `weathericons-regular.ttf` is a Weather Icons font from [Weather Icon Pack](https://erikflowers.github.io/weather-icons/). Using `WeatherIcon.swift` this model converts the string -> the proper icon

## Built With
- XCode 11.5 (11E608c)
- Tested on iPhone SE (2nd Generation) simulator

# Authors

- **Kevin Ciarniello** - (https://github.com/kciarnie)

# Acknowledgement

- [Weather Icon Pack](https://erikflowers.github.io/weather-icons/)
- [Beautiful Minimal design (Inspiration of this site)](https://flutterawesome.com/an-elegant-easy-on-the-eyes-weather-app-build-with-flutter/)

# License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details




