# ARchitect-ARrow
Phil Kalinowski, Olivia Lewis & Abraham Furlan

## Overview
In brief, this application is used for AR Direction when navigating our world through a mobile device. For this project in particular, usage is primarily for Android users through the Flutter/Dart coding environment.

The application uses concepts like Google Maps and other GPS-like devices/applications and provides a clearer sense of direction from the user's point of view, rather than the typical satellite point of view. The app allows the user to select/set their destination, opens their camera, and then gives the user a clear and dynamic AR arrow to serve as a guide, leading the user to the chosen location

## Details
Ideally, in the OVP stage of this project, there will be an AR Arrow that leads a user to a particular direction, based on longitude and latitude. Unfortunately, the code was not compatible via Mapbox API and Google Maps. In all consideration, Kotlin/Java or C code are languages which Google directly supports for this type of project.

The user is able to select a type of travel; Cycling, Walking, Driving. Based on that, there are a number of seconds that are calculated into the decision. Seconds are a universal method of time keeping, and therefore a more optimal and elite form of time knowledge. 

> [!WARNING]
> The Map does not work. (Broken)

## Take Aways
> [!IMPORTANT]
> There were attempts made at developing AR Code into this project, unsuccessfully. <br>
> The code should have encompassed the AR Core functionalities first before attempting to bring everything together <br>
> UI Could be worked on lastly instead of firstly, regardless that Dart is larger based on UI Widgets. <br>
> Mapbox API and ARCore are most likely not as compatible as first thought and Geospatial API from Google would have worked just fine <br>
> Although Geospatial API would worked well for us, Kotlin/Java is the more preferred language given knowledgeable tutorials and Android Studio <br>
> Do not try to recreate the wheel -- use what resources can be found and develop something based on those ideas to create something new and familiar <br>

## Resources
> [!NOTE]
> Mapbox API Overview: https://docs.mapbox.com/api/overview/ <br>
> Directions API: https://docs.mapbox.com/api/navigation/directions/ <br>
> ARCore Flutter Plugin https://pub.dev/packages/arcore_flutter_plugin <br>
> Attempted Geospatial Introduction via Kotlin / Java https://developers.google.com/ar/develop/java/geospatial/quickstart