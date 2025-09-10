import 'dart:io';

void main() {
  // --- Start of Flowchart Logic ---

  // Initialize variables
  List<String> listOfWords = ['BANANA', 'APPLE', 'BIRD', 'GRAPE', 'SUNFLOWER', 'TOMATO'];
  
  // Select a word without the dart:math library by using the current time
  int randomIndex = DateTime.now().millisecond % listOfWords.length;
  String randomWord = listOfWords[randomIndex].toUpperCase();
  
  List<String> letterGuess = List.filled(randomWord.length, '_');
  int lives = 6;
  int lettersUsed = 0;
  List<String> lettersGuessed = [];

  print("Welcome to the word guessing game! Let's start playing.");

  // Main game loop (while LetterGuess.join('') != RandomWord AND Lives > 0)
  while (letterGuess.join('') != randomWord && lives > 0) {
    print("\n");
    print("Current Word: ${letterGuess.join(' ')}");
    print("Lives Left: $lives");
    print("Letters Guessed: ${lettersGuessed.join(', ')}");

    String? userInput;
    bool isValidInput = false;

    // Loop for valid user input (Is the length of the user input >= 1?)
    while (!isValidInput) {
      stdout.write("Enter a letter or guess the word: ");
      userInput = stdin.readLineSync()?.trim().toUpperCase();

      if (userInput != null && userInput.isNotEmpty) {
        if (userInput.length > 1) {
          // If the input is more than one letter, it's a full word guess.
          if (userInput == randomWord) {
            letterGuess = randomWord.split('');
            print("Congratulations! You've guessed the word correctly!");
            break; // Exit the inner loop and main game loop.
          } else {
            print("Incorrect word guess. Try again.");
            lives--; // Decrement lives for an incorrect word guess.
            break;
          }
        } else {
          // Input is a single character.
          if (lettersGuessed.contains(userInput)) {
            print("You already chose this letter. Try another one.");
          } else if (RegExp(r'^[A-Z]$').hasMatch(userInput)) {
            lettersGuessed.add(userInput);
            isValidInput = true;
          } else {
            print("Incorrect character input. Please enter a single letter.");
          }
        }
      } else {
        print("Please enter a letter or a word.");
      }
    }

    if (letterGuess.join('') == randomWord) {
      break; // Exit main game loop if the word was guessed.
    }

    // Check if the guessed letter is in the random word
    if (randomWord.contains(userInput!)) {
      print("Correct guess!");
      bool isMatchFound = false;
      for (int i = 0; i < randomWord.length; i++) {
        if (randomWord[i] == userInput) {
          if (letterGuess[i] == '_') {
            letterGuess[i] = userInput;
            isMatchFound = true;
          }
        }
      }
      if (!isMatchFound) {
        print("You already guessed that letter correctly.");
      }
    } else {
      print("Incorrect guess. You lose a life.");
      lives--;
    }
  }

  // --- End of game logic ---
  print("\n");
  if (letterGuess.join('') == randomWord) {
    print("Well done! The word was '$randomWord'. You won!");
  } else {
    print("You're out of lives. The word was '$randomWord'. You lost.");
  }
}