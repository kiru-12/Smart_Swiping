Smart Swiping: Phrase-Based Gesture Typing

Overview

Smart Swiping is an advanced gesture-based typing system designed for smartphones. Unlike traditional gesture typing, which limits input to a single word, this project enables the input of entire phrases and sentences in one continuous swipe without needing to lift a finger between words.

The model uses Google T5-small for natural language processing and achieves an error rate of approximately 8%, making it both innovative and efficient for real-world use cases.

Features

	•	Continuous Gesture Typing: Input entire sentences or phrases in a single swipe.
	•	AI-Powered Prediction: Utilizes Google T5-small to intelligently interpret swiping gestures.
	•	Low Error Rate: Achieves ~8% error rate for accurate predictions.
	•	Seamless User Experience: Designed to enhance typing speed and usability on mobile devices.

How It Works

	1.	Input Phase: The user swipes their finger across the virtual keyboard without lifting it.
	2.	Path Analysis: The model interprets the swipe path and maps it to potential words and phrases.
	3.	Prediction Phase: Using Google T5-small, the model generates the most likely sentence based on the swipe input.
	4.	Output: The predicted phrase/sentence is displayed to the user.

Architecture

The system leverages:

	•	Google T5-small: A state-of-the-art text-to-text transformer model for sentence prediction.
	•	Gesture Recognition: Captures swipe paths and processes them for word boundary detection.
	•	Error Correction: Refines predictions to minimize error and improve accuracy.

Installation

	1.	Clone the repository:

git clone https://github.com/kiru-12/Smart_Swiping.git
cd Smart_Swiping


	2.	Install dependencies:
Ensure Python 3.8+ is installed, then run:

pip install -r requirements.txt


	3.	Run the project:

python main.py



Demo

A short demo showcasing the gesture typing in action will be uploaded soon.

Technologies Used

	•	Python
	•	Google T5-small
	•	TensorFlow/PyTorch
	•	Gesture Recognition Framework (e.g., touch event APIs for smartphones)

Future Scope

	•	Real-time Deployment: Integrate with smartphone keyboards.
	•	Customization: Allow users to train the model for personalized typing.
	•	Multilingual Support: Extend gesture typing capabilities to other languages.

Contributions

Contributions are welcome! If you’d like to improve Smart Swiping, follow these steps:

	1.	Fork the repository.
	2.	Create a feature branch:

git checkout -b feature/your-feature


	3.	Commit your changes:

git commit -m "Add your feature"  
git push origin feature/your-feature


	4.	Submit a pull request.

License

This project is licensed under the MIT License.

Contact

For queries or feedback, reach out to:
[Your Name]

	•	GitHub: kiru-12
	•	Email: [Your Email Address]

Let me know if you’d like further refinements or specific sections added!
