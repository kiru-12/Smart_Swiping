# Smart Swiping: Phrase-Based Gesture Typing  

## Overview  
**Smart Swiping** is an advanced gesture-based typing system designed for smartphones. Unlike traditional gesture typing, which limits input to a single word, this project enables the input of entire **phrases** and **sentences** in one continuous swipe without needing to lift a finger between words.  

The model uses **Google T5-small** for natural language processing and achieves an **error rate of approximately 8%**, making it both innovative and efficient for real-world use cases.

---

## Features  
- **Continuous Gesture Typing**: Input entire sentences or phrases in a single swipe.  
- **AI-Powered Prediction**: Utilizes Google T5-small to intelligently interpret swiping gestures.  
- **Low Error Rate**: Achieves ~8% error rate for accurate predictions.  
- **Seamless User Experience**: Designed to enhance typing speed and usability on mobile devices.  

---

## How It Works  
1. **Input Phase**: The user swipes their finger across the virtual keyboard without lifting it.  
2. **Path Analysis**: The model interprets the swipe path and maps it to potential words and phrases.  
3. **Prediction Phase**: Using Google T5-small, the model generates the most likely sentence based on the swipe input.  
4. **Output**: The predicted phrase/sentence is displayed to the user.  

---

## Architecture  
The system leverages:  
- **Google T5-small**: A state-of-the-art text-to-text transformer model for sentence prediction.  
- **Gesture Recognition**: Captures swipe paths and processes them for word boundary detection.  
- **Error Correction**: Refines predictions to minimize error and improve accuracy.  

---
