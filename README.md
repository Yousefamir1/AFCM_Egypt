## afcm_egypt
Flutter detect rheumatoid arthritis. The app uses the TensorFlow Lite package to run a machine learning model, combining machine learning and X-rays to detect whether a person has rheumatoid arthritis or not. It also allows you to use the camera to take a picture and also choose the picture from the device gallery

## Project Overview
Our Flutter app uses ML to detect rheumatoid arthritis in X-ray images. With an intuitive interface and real-time predictions,by using the camera to take a picture and also choose the picture from the device gallery


## Dependencies
The app utilizes the following Flutter packages:

1. Tflite: This package is used to run the TensorFlow Lite model for rheumatoid arthritis detection.

2. Camera: The camera package enables access to the device's camera for capturing real-time images.

3. image_picker: This package provides the ability to select images from the device's gallery.


## Features
The "afcm Egypt" Flutter project includes the following features:

1. Image Selection Options:
 - Gallery: Users can choose an X-ray image from their device's gallery.
 - Camera: The app allows users to capture X-ray images in real-time using the device's camera.

2. Grayscale Image Processing:
 - The app offers the option to apply a grayscale filter to selected images, enhancing the quality of input data for analysis.

3. Machine Learning Model Integration:
 - TensorFlow Lite powers the machine learning model for disease detection.
 - The model processes images to identify rheumatoid arthritis indicators.
 - It provides predictions with associated confidence scores.

4. Result Screen:
 - After processing, the app displays the original X-ray image.
 - Predicted results, including labels and confidence scores, are presented to users.

5. User-Friendly Interface:
 - The app boasts an intuitive and visually engaging user interface.
 - It offers easy navigation and clear presentation of results.

6. Theme Options:
 - Users can switch between light and dark themes to suit their preferences.
 - Theme changes are instantly applied throughout the app.

7. Persistent Storage Management:
 - The app utilizes SharedPreferences and GetStorage for efficient data storage and retrieval.
 - Preferences such as theme choice and first-time app use are managed.

8. App Logo and Branding:
 - The app incorporates a distinctive logo and branding to establish its identity.



