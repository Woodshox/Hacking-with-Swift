# Project 5

Word scramble


*In this project you're going to learn how to make a word game that deals with anagrams


Challenge: Disallow answers that are shorter than three letters or are just our start word. For the three-letter check, the easiest thing to do is put a check into isReal() that returns false if the word length is under three letters. For the second part, just compare the start word against their input word and return false if they are the same. Refactor all the else statements we just added so that they call a new method called showErrorMessage(). This should accept an error message and a title, and do all the UIAlertController work from there. Add a left bar button item that calls startGame(), so users can restart with a new word whenever they want to. Bonus: Once you’ve done those three, there’s a really subtle bug in our game and I’d like you to try finding and fixing it.

To trigger the bug, look for a three-letter word in your starting word, and enter it with an uppercase letter. Once it appears in the table, try entering it again all lowercase – you’ll see it gets entered. Can you figure out what causes this and how to fix it?


 
![grab-landing-page](https://github.com/Woodshox/Hacking-with-Swift/blob/main/Project%205/Proj5.gif)
