Developing an app that predicts the next word using NLP
========================================================
author: Shreyas S
date: 29/08/2019
autosize: true

Introduction
========================================================
- Every person uses a keyboard to type messages or to search the internet
- Using Natural Language Processing we can build-in into the keyboard functionality to suggest words
- This project deals with development of such a program using the ngram tokenization to predict next word of every day phrases

Objectives
========================================================
- Clean, Sample and Tokenize the data and perform Exploratory Data Analysis
- Create a Prediction Model that predicts the next word considering the words already input
- Build a Shiny app that allows to input words and gives the next word along with a graph of the top 15 ngram respectively

Prediction Model and App
========================================================
- The model predicts next word based on the number of words input by the user
[https://github.com/shreyassatam/Predict_Next_Word/blob/master/prediction%20model%20project/pred_model.R]

- The app has a textbox to input words and shows the predicted word and the ngram it used to get the word from with the top 15 matches. It selects the most frequent occuring next word
[https://github.com/shreyassatam/Predict_Next_Word/blob/master/prediction%20model%20project/app.R]

- The app also has tabs which show different top 20 ngrams that occur
[http://shreyassatam.shinyapps.io/next_word_final]

Conclusion
========================================================
- The app computes accurately the next word and takes minimal time which shows the efficiency of the overall prediction model
- The model should work with similar performance with large data sets
- The app developed is easy to use and give the information needed to verify the next word predicted
