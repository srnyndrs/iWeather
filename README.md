# iWeather
 The purpose of the application is to provide valuable information about current and future weather through <i><a href="https://openweathermap.org/current">OpenWeather API</a></i>. Location data permission is required for full functionality.

## Technologies
- SwiftUI
- MapKit
- CoreData
- CoreLocation
- API usage

## Description

### Home
On the home page, it displays weather data corresponding to the user's position. The application monitors position changes every minute to always show the latest data.

   Current             |  Forecast
:-------------------------:|:-------------------------:
![](/pictures/Home.gif) |   ![](/pictures/Forecast.gif)

### Locations
On the locations page, users can save additional locations. The list can be expanded by providing coordinates, but there is also a search function through <a href="https://www.geoapify.com/geocoding-api"><i>Geoapify</i></a>, that complements these values based on city names. After selecting saved cities, it displays the data in a view similar to the home page.

   List             |  Location View
:-------------------------:|:-------------------------:
![](/pictures/Locations.gif) |   ![](/pictures/LocationView.gif)

   New Location             |  Validation
:-------------------------:|:-------------------------:
![](/pictures/NewLocation.gif) |   ![](/pictures/Validation.gif)


### Map
The map page features a map view showing the current weather data for the saved locations.
   Map View             |
:-------------------------:|
![](/pictures/Map.gif) |