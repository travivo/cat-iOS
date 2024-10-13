# **🐱 Cat App**

## **Overview**

The **Cat App** is a fun iOS application that displays random cat images along with interesting cat facts. It uses a network layer to fetch data from APIs, caches images for smooth performance, and applies beautiful UI effects to enhance the user experience.

## **Features**

- 📸 **Fetches random cat images** from **The Cat API**
- 📚 **Displays interesting cat facts** from a **meowfacts API**
- 🚀 **Caches images** for quick loading and improved performance
- 🎨 **User-friendly interface** with smooth transitions and gradient backgrounds

## **Technologies Used**

- **Swift**
- **UIKit**
- **URLSession** for networking
- **Codable** for JSON parsing
- **CAGradientLayer** for UI effects

## **Architecture**

### **MVVM (Model-View-ViewModel)**

- **Model:** Represents the data structure of the application. In this app, the model consists of the data fetched from the APIs, including cat images and facts.

- **View:** The user interface of the application, built using UIKit. The `CatViewController` class is responsible for displaying cat images and facts to the user.

- **ViewModel:** The `CatViewModel` class serves as an intermediary between the view and the model. It handles data fetching, caching, and provides the necessary data to the view while maintaining the application logic.

## **Getting Started**

### **Prerequisites**

- **Xcode** (latest version recommended)
- **iOS 13.0** or later

### **Installation**

1. **Clone the repository**:
   ```bash
   git clone https://github.com/travivo/cat-iOS.git

### **Testing**

This project includes unit tests to ensure the functionality of key components. The tests verify:

- Data Fetching: Ensures that cat facts and images are successfully fetched from the API.
- Image Loading and Caching: Tests the functionality of loading images and caching them for improved performance.


## **Acknowledgments**

- **[The Cat API](https://developers.thecatapi.com/view-account/ylX4blBYT9FaoVd6OhvR?report=bOoHBz-8t)** for providing cat images.
- **[Meowfacts API](https://github.com/wh-iterabb-it/meowfacts)** for providing interesting cat facts.
