# Sustainfulness
Sustainfulness is an mobile app for Android and iOS.

⬇️ **Android**: Download the [sustainfulness.apk](https://github.com/jimicy/sustainfulness/raw/main/download_app/sustainfulness.apk)

⬇️ **iOS**: If you need to test iOS, please contact us!
  - Apple requires paid Developer accounts in order to sign and release an iOS for other to test, we we weren't able to get this setup in time for devpost deadline.
  - We tested that the app works great on iOS though

For judges, please reach out so we can add your email as a Tester for Google wallet integration!

➡️ See youtube video: https://www.youtube.com/watch?v=wDzpevscH3o

## How we built it
Our App is a combination of Flutter and Web technologies.
+ Flutter allows us to easily build apps for both android and ios with the same shared codebase, it also provides a great set of Widgets for building responsive views for mobile apps.
+ Web allowed us to use technologies that might not be supported yet on Flutter like three.js, WebGL.

Animations are powered by  [flutter_animate](https://pub.dev/packages/flutter_animate) package. Animations are a big part of makes this app a delight and fun to use!

For making the card fun to interact with, we added touch control where you can tap & hold to tilt the card. As well as gyro controls, if you tilt you phone the card preview tilts as well! Powered by Tilt controls: [flutter_titlt](https://pub.dev/packages/flutter_tilt).

For our 3D energy catching game, we utilized three.js and web. [webview_flutter](https://pub.dev/packages/webview_flutter) integrate Flutter App and Web together, as well as handle the communications between them.
+ The code for the three.js game lives at [/docs](/docs) folder. Since Github pages convetion serves from a folder named `docs`.
+ And it's hosted on [https://jimicy.github.io/sustainfulness/](https://jimicy.github.io/sustainfulness/) which our Flutter app loads via a Webview

For logic, we separated business logic from UI by utilizing the Bloc pattern. This makes it easier to do separate of concerns and refactor UI without needing to ensure business logic doesn't get broke in the process. For persisting data to the devices, hydrated_bloc allowed use to easily persistent our Bloc (business logic data) by swapping the class to HydratedBloc class!  

Here's a medium article describing the process of building this Flutter app!
+ [https://medium.com/@jimicy/our-experience-developing-sustainfulness-flutter-545cb919546f](https://medium.com/@jimicy/our-experience-developing-sustainfulness-flutter-545cb919546f)
+ A deeper technical breakdown and what others can learn from other for their Flutter apps!

## Screens

Animated splash screen fades element delightfully in and out
| Splash screen #1 | Splash screen #2 |
| -----------------|------------------|
| <img src="https://github.com/jimicy/sustainfulness/assets/3952128/bbca4394-d705-4679-aa43-b19e176ace63" height=600> | <img height=600 src="https://github.com/jimicy/sustainfulness/assets/3952128/a9deb0cb-4a1f-46ce-9447-f069f9d7781b"> |


| 3D energy catching game | Reward screen|  Revealed Daily card | 
| ----------------- | ------ | -------|
| ![](https://d112y698adiu2z.cloudfront.net/photos/production/software_photos/002/810/614/datas/original.PNG) | ![](https://d112y698adiu2z.cloudfront.net/photos/production/software_photos/002/811/152/datas/original.jpeg) | ![](https://d112y698adiu2z.cloudfront.net/photos/production/software_photos/002/811/153/datas/original.png) |

## References
Key flutter packages:
+ [flutter_animate](https://pub.dev/packages/flutter_animate).
+ [flutter_titlt](https://pub.dev/packages/flutter_tilt)
+ [webview_flutter](https://pub.dev/packages/webview_flutter)
+ [flutter_bloc](https://pub.dev/packages/flutter_bloc)
+ [hydrated_bloc](https://pub.dev/packages/hydrated_bloc)
+ [fl_charts](https://pub.dev/packages/fl_chart)

Tutorials followed:
+ https://tympanus.net/codrops/2016/04/26/the-aviator-animating-basic-3d-scene-threejs/
