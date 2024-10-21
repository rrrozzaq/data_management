# Data Management App

## Overview

This Flutter application is developed as the second part of a recruitment test for PT Efea Inovasi Solusi. It serves as a mobile client for inputting KTP data using the RESTful API. The app enables users to search for existing Kartu Keluarga (KK) records and add new KTP entries linked to these records.

## Features

- **Search KK Records**: Users can search and select KK records retrieved from the backend API.
- **Add KTP Data**: Allows for the input of detailed KTP data, associating it with selected KK records.
- **Seamless Integration**: Directly interacts with the Laravel API, ensuring real-time data handling and synchronization.

## Technology Stack

- **Flutter**: For building a high-quality, natively compiled application for mobile platforms.
- **Laravel API**: Connects to the Laravel backend to fetch KK data and post KTP records.
- **Git**: Used for version control, with the project hosted on GitLab.

## Getting Started

### Prerequisites

- Flutter installed on your development machine (See [Flutter Installation](https://flutter.dev/docs/get-started/install)).
- An IDE with Flutter SDK configured (e.g., Android Studio, VS Code).
- Access to the backend API running either locally or hosted.

### Installation

1. **Clone the repository:**

    ```bash
    git clone https://gitlab.com/your-gitlab-repo/ktp_data_input_app.git
    cd ktp_data_input_app
    ```

2. **Install dependencies:**

    ```bash
    flutter pub get
    ```

3. **Run the app:**

    ```bash
    flutter run
    ```

Ensure your device or emulator is running and connected. The app will connect to the backend API at the configured endpoint.

## Using the App

1. **Start the app**: Open the app on your device or emulator, and choose the features.

![image](https://github.com/user-attachments/assets/21d02eed-cc01-4d78-aac3-ca6d747a5435)

2. **Fetch Data and Search KK**: Navigate to the search page and enter a KK number to fetch associated records.

![image](https://github.com/user-attachments/assets/c35f33d6-fdf2-44f8-a6d1-258e43fdc71f)

3. **Detailed Data KK**: Click data KK and see the detail of member.

![image](https://github.com/user-attachments/assets/49a0a5d9-07d1-4342-a64f-6cddb9ba18ac)

4. **Add KTP**: After selecting a KK record, fill in the KTP form and submit it to create a new KTP record linked to the KK. Your data will be show on the KK screen once you submitted the KTP data.

![image](https://github.com/user-attachments/assets/14136ed0-3e78-4169-9401-c02d78525179)

## Documentation

For more detailed documentation on the API endpoints and their functionalities, refer to the Laravel project's API documentation provided in [API Documentation](https://documenter.getpostman.com/view/24386185/2sAXxY48R5).

## Contributing

Contributions to improve the app are welcome. Please fork the repository, make your changes, and submit a pull request for review.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE.md) file for details.

---
