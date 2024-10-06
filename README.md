# ProjectDetect: Unraveling Dyscalculia in Early Education

**ProjectDetect** is a mobile application designed to identify mathematical learning difficulties (dyscalculia) in primary school students through interactive learning modules. The app incorporates quizzes to assess color detection, counting, calculation, and verbal communication, and uses fuzzy logic to monitor and predict a student’s learning progress.

## Features

- **Dyscalculia Detection**: Provides early identification of dyscalculia through interactive quizzes on color recognition, counting, and arithmetic.
- **Fuzzy Logic Integration**: Implements fuzzy logic for personalized learning by tailoring quiz difficulty based on the student’s performance.
- **Speech Recognition**: Includes speech-to-text functionality to assess verbal articulation of numerical concepts.
- **Graphical Results**: Offers dynamic graphical representations to track the progress of students over time.

## Technologies Used

- **Frontend**: Flutter (for UI and user interaction)
- **Backend**: Flask (Python) with SQLite (for database management)
- **Machine Learning**: Fuzzy logic (for personalized student progress assessment)
- **APIs**: Speech recognition and other external APIs for enhanced interactivity
- **Libraries**: Yolov5 (for future object detection integrations), Matplotlib (for graph plotting)

## Getting Started

### Prerequisites

Ensure the following are installed:

- Python 3.x
- Flutter and Dart
- Flask
- SQLite
- Required Python libraries (install via `requirements.txt`)

### Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/RKayyy/projectdetect.git
    ```
2. Navigate to the project directory:
    ```bash
    cd projectdetect
    ```
3. Install required dependencies:
    ```bash
    pip install -r requirements.txt
    ```
4. Set up the SQLite database:
    ```bash
    python manage.py migrate
    ```
5. Run the application:
    ```bash
    flutter run
    ```

### Usage

1. Launch the mobile app.
2. Users can attempt various quizzes: **Coloring**, **Counting**, and **Calculating**.
3. Speech-to-text features can be used in the quizzes to assess verbal responses.
4. Monitor progress through visual graphs showing accuracy, quiz attempts, and prediction trends.


## Project Structure

- `app/`: Contains core Flask backend and API files.
- `lib/`: Flutter UI components and quiz modules.
- `models/`: Fuzzy logic model and assessment logic.
- `static/`: Static assets like images, JS, CSS.
- `database/`: SQLite database schema and migrations.

---

## Methodology

The application uses three assessment modules to test students on:
- **Color Detection**: Enhances visual discrimination by asking students to identify colors.
- **Counting**: Tests the student’s basic numeracy by asking them to count objects.
- **Calculation**: Engages students with elementary arithmetic problems to test their math skills.

The results from each quiz are processed through a **fuzzy logic** model to determine the student’s level of dyscalculia. The fuzzy rules consider quiz accuracy, time taken, and the number of attempts to provide an accurate prediction.

---

## Experimental Results

- 15 young learners aged 4-6 were tested using the app.
- The app demonstrated a 90% accuracy in identifying students with dyscalculia.
- Graphical feedback helped students track their progress over multiple quiz attempts.

## Future Directions

- **Integration of AI/ML**: Expand the app with more advanced machine learning techniques for better prediction accuracy.
- **Enhanced Learning Modules**: Explore the integration of VR and AR for a more immersive learning experience.
- **Teacher Training Programs**: Develop tools to help educators use the app for identifying and supporting dyscalculia in students.


