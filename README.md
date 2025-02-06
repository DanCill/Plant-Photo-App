
## Installation instructions 
    1. Clone repo
    2. Run 'flutter pub get' to install dependencies
    3. Run 'flutter run lib/main.dart' to start application

## Notes:
    For Android tested on emulator running Android version 15, and Java JDK21.
    iOS was tested on physical device running iOS version 18.1.1

## Design choices
    This being a small app to start with and potentially can grow to a medium sized app, I decided to structure the code in a basic layered form. I split the data model into its own section, and if services get added later it will also be under data.
    
    The presentation layer is also seperate, and with more UI tweaks a seperate folder can be created for reuseable widgets when the application grows.

    I created a seperate folder for the theming for the application, this allows for an easier to maintain color palatte and more consistency in the app color scheme with light and dark themes.

    I used Flutter Provider for the state management as it was simple to implement and understand and with provided better performance than using setState to rebuild the entire widget tree when a plant was added or modified.
    For a much larger application a different state management could be utilized like BLoC, but in this instance it would have added too much complex business logic for such a small application.

## Light Mode
<img src="https://github.com/user-attachments/assets/c3d64e35-52b0-4646-9319-3aedeedf6f19" width=200>
<img src="https://github.com/user-attachments/assets/4417198a-0054-4038-8a60-657ef3b4a4d2" width=200>

## Dark Mode
<img src="https://github.com/user-attachments/assets/539ff55d-7ffc-4c23-9c41-445d5154de57" width=200>
<img src="https://github.com/user-attachments/assets/400c86b5-a118-4f40-bdfa-4273c2b38163" width=200>
