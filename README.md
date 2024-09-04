# 🏃‍♀️ FitnessApp
FitnessApp is developed to track training progress and plan gym routine. The app allows users to visualiza their progress as a chart and monitor various body metrics sucj as weight, height, waist, etc. Users also have an opportunity to select which metrics to track currently without losing data about unselected metrics. The app also includes a library of exercises categorized by muscle type, which allows to cerate a training routine. Furthermore, the app provides calculators for Body Mass Index(BMI), Fat Percentage and Daily Calories Requirement.

## Used Technologies
- UIKit: To develop user interface
- Firebase: User authentification, login, account deletion, and sign out
- Firestore: storing user profile data and metrics for further use
- Core Animation: CALayer used to animate progress chart

## Features
- 🔑 Autentification: Login, Registration, Password reset using Firebase
<table>
  <tr>
    <td><img src="https://res.cloudinary.com/de2e9rrkw/image/upload/v1725444344/Simulator_Screen_Shot_-_iPhone_14_Pro_-_2024-09-04_at_12.56.36_cujykr.png" alt="Signup" width="200"></td>
    <td><img src="https://res.cloudinary.com/de2e9rrkw/image/upload/v1725444345/Simulator_Screen_Shot_-_iPhone_14_Pro_-_2024-09-04_at_12.56.42_ocz5zt.png" alt="Login" width="200"/></td>
    <td><img src="https://res.cloudinary.com/de2e9rrkw/image/upload/v1725444345/Simulator_Screen_Shot_-_iPhone_14_Pro_-_2024-09-04_at_12.56.47_x0z8bl.png" alt="Forgot Password" width="200"/></td>
    <td><img src="https://res.cloudinary.com/de2e9rrkw/image/upload/v1725444345/Simulator_Screen_Shot_-_iPhone_14_Pro_-_2024-09-04_at_12.58.57_xolotc.png" alt="Forgot Password" width="200"/></td>
  </tr>
</table>

- 👤 Profile update: Allows users to update and change their profile information and select metrics to track and show on home screen
<table>
  <tr>
    <td><img src="https://res.cloudinary.com/de2e9rrkw/image/upload/v1725444345/Simulator_Screen_Shot_-_iPhone_14_Pro_-_2024-09-04_at_12.58.41_mqf2ar.png" alt="Home" width="200"></td>
    <td><img src="https://res.cloudinary.com/de2e9rrkw/image/upload/v1725444345/Simulator_Screen_Shot_-_iPhone_14_Pro_-_2024-09-04_at_12.58.47_jh5iei.png" alt="Profile" width="200"/></td>
    <td><img src="https://res.cloudinary.com/de2e9rrkw/image/upload/v1725444345/Simulator_Screen_Shot_-_iPhone_14_Pro_-_2024-09-04_at_12.59.01_hopzyo.png" alt="Select Options" width="200"/></td>
  </tr>
</table>

- 📈 Progress tracking: Displays all chosen metrics with a feature to visualize progress as a bar chart specifying dates of change
<table>
  <tr>
    <td><img src="https://res.cloudinary.com/de2e9rrkw/image/upload/v1725444346/Simulator_Screen_Shot_-_iPhone_14_Pro_-_2024-09-04_at_12.59.08_zifdd8.png" alt="Tracking Metrcis" width="200"></td>
    <td><img src="https://res.cloudinary.com/de2e9rrkw/image/upload/v1725444346/Simulator_Screen_Shot_-_iPhone_14_Pro_-_2024-09-04_at_12.59.49_bamxe7.png" alt="Chart" width="200"/></td>
  </tr>
</table>

- 🧮 Calculators: BMI, Fat Percentage, and Daily Calories Requierement calculators provide more detailed health monitoring
<table>
  <tr>
    <td><img src="https://res.cloudinary.com/de2e9rrkw/image/upload/v1725444346/Simulator_Screen_Shot_-_iPhone_14_Pro_-_2024-09-04_at_13.00.10_clfd5l.png" alt="BMI" width="200"></td>
    <td><img src="https://res.cloudinary.com/de2e9rrkw/image/upload/v1725444347/Simulator_Screen_Shot_-_iPhone_14_Pro_-_2024-09-04_at_13.01.14_ikylej.png" alt="Fat Percentage" width="200"/></td>
    <td><img src="https://res.cloudinary.com/de2e9rrkw/image/upload/v1725444347/Simulator_Screen_Shot_-_iPhone_14_Pro_-_2024-09-04_at_13.01.28_acmd51.png" alt="Calories Requirement" width="200"/></td>
  </tr>
</table>

- 💪 Exercises: Exercise library grouped by muscle type with description and visualization for better workouts
<table>
  <tr>
    <td><img src="https://res.cloudinary.com/de2e9rrkw/image/upload/v1725444347/Simulator_Screen_Shot_-_iPhone_14_Pro_-_2024-09-04_at_13.01.55_wcqou1.png" alt="Exercises List" width="200"></td>
    <td><img src="https://res.cloudinary.com/de2e9rrkw/image/upload/v1725444347/Simulator_Screen_Shot_-_iPhone_14_Pro_-_2024-09-04_at_13.02.15_ko6xgp.png" alt="Exercise Description" width="200"/></td>
  </tr>
</table>

- 🔴 Error checks: Verification of the entered data correctness based in the expected input
<table>
  <tr>
    <td><img src="https://res.cloudinary.com/de2e9rrkw/image/upload/v1725444347/Simulator_Screen_Shot_-_iPhone_14_Pro_-_2024-09-04_at_13.02.47_doh6xm.png" alt="Calculator Error" width="200"></td>
    <td><img src="https://res.cloudinary.com/de2e9rrkw/image/upload/v1725444348/Simulator_Screen_Shot_-_iPhone_14_Pro_-_2024-09-04_at_13.03.58_kjjqic.png" alt="Signup Error" width="200"/></td>
  </tr>
</table>

- 🧩 Custom UI Compinents: custom buttons, switches, segmented controls, and text fields provide more unified and complete interface

## Requirements

- iOS 15.0 or later
- Xcode 15.0 or later

## Installation

To install FitnessApp follow these steps:

1. Clone the repository to your local machine using the command: 
    git clone https://github.com/strahovochka/FitnessApp.git
2. Open the project in Xcode.
    cd FitnessApp
    open FitnessApp.xcworkspace
3. Install CocoaPods dependencies:
    pod install

4. Connect your iOS device to your computer and select it as the build destination in XCode
5. Build and run the application on your device
