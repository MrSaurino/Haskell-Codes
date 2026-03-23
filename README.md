# Haskell-Codes
A set of exercises and projects used to learn the language and apply it in practice.

Some of the exercises and examples are:

## Rotation Cipher

### Instructions
Create an implementation of the rotational cipher, also sometimes called the Caesar cipher.

The Caesar cipher is a simple shift cipher that relies on transposing all the letters in the alphabet using an integer key between 0 and 26. Using a key of 0 or 26 will always yield the same output due to modular arithmetic. The letter is shifted for as many values as the value of the key.

The general notation for rotational ciphers is ROT + <key>. The most commonly used rotational cipher is ROT13.

A ROT13 on the Latin alphabet would be as follows:

> Plain:  abcdefghijklmnopqrstuvwxyz
> <br>
Cipher: nopqrstuvwxyzabcdefghijklm

## ISBN Verifier

### Instructions
The ISBN-10 verification process is used to validate book identification numbers. These normally contain dashes and look like: `3-598-21508-8`

The ISBN-10 format is 9 digits (0 to 9) plus one check character (either a digit or an X only). In the case the check character is an X, this represents the value '10'. These may be communicated with or without hyphens.

Given a string the program should check if the provided string is a valid ISBN-10. Putting this into place requires some thinking about preprocessing/parsing of the string prior to calculating the check digit for the ISBN.

The program should be able to verify ISBN-10 both with and without separating dashes.

## Diamond

### Instructions
The diamond kata takes as its input a letter, and outputs it in a diamond shape. Given a letter, it prints a diamond starting with 'A', with the supplied letter at the widest point.

### Requirements
* The first row contains one 'A'.
* The last row contains one 'A'.
* All rows, except the first and last, have exactly two identical letters.
* All rows have as many trailing spaces as leading spaces. (This might be 0).
* The diamond is horizontally symmetric.
* The diamond is vertically symmetric.
* The diamond has a square shape (width equals height).
* The letters form a diamond shape.
* The top half has the letters in ascending order.
* The bottom half has the letters in descending order.
* The four corners (containing the spaces) are triangles.

Diamond for letter 'C':
>··A··\
·B·B·\
C···C\
·B·B·\
··A··

## Atbash Cipher

### Instructions
Create an implementation of the atbash cipher, an ancient encryption system created in the Middle East.

The Atbash cipher is a simple substitution cipher that relies on transposing all the letters in the alphabet such that the resulting alphabet is backwards. The first letter is replaced with the last letter, the second with the second-last, and so on.
>Plain:  abcdefghijklmnopqrstuvwxyz
> <br>
Cipher: zyxwvutsrqponmlkjihgfedcba

## Anagram

### Instructions
Your task is to, given a target word and a set of candidate words, to find the subset of the candidates that are anagrams of the target.

An anagram is a rearrangement of letters to form a new word: for example "owns" is an anagram of "snow". A word is not its own anagram: for example, "stop" is not an anagram of "stop".

The target and candidates are words of one or more ASCII alphabetic characters (A-Z and a-z). Lowercase and uppercase characters are equivalent: for example, "PoTS" is an anagram of "sTOp", but StoP is not an anagram of sTOp. The anagram set is the subset of the candidate set that are anagrams of the target (in any order). Words in the anagram set should have the same letter case as in the candidate set.

Given the target "stone" and candidates "stone", "tones", "banana", "tons", "notes", "Seton", the anagram set is "tones", "notes", "Seton".

To complete this exercise you need to implement the function anagramsFor, that takes a word and a group of words, returning the ones that are anagrams of the given word.

You must return the anagrams in the same order as they are listed in the candidate words.

## Beer Song

### Instructions
Recite the lyrics to that beloved classic, that field-trip favorite: 99 Bottles of Beer on the Wall.

Note that not all verses are identical.

>99 bottles of beer on the wall, 99 bottles of beer.
> <br>
Take one down and pass it around, 98 bottles of beer on the wall.
> <br> <br>
98 bottles of beer on the wall, 98 bottles of beer.
> <br>
Take one down and pass it around, 97 bottles of beer on the wall.


## To-do list

### Instructions
Develop a task management system (To-Do List) using the Haskell programming language. This system will allow users to add, delete, edit and list tasks via a command-line interface (CLI). It will also implement features such as task categorisation, due dates and priorities.

### Requirements
* To develop an interactive CLI for task management.
* To implement data persistence via local files.
* To incorporate features such as categorisation, due dates and priorities.
* The user can add a new task by providing a title, description, category, due date and priority.
* The user has the option to delete a task they have created.
* The user can edit the details of an existing task, such as itstitle, description, category, due date and priority.
* The user can list the tasks that are stored, as well aschoose how to sort them, with the sorting options being title, category, duedate and priority.
* To improve organisation, tasks are categorised; this allows the user to group and list tasks according to their category.
* Tasks can be assigned a due date, which helps to prioritise and manage tasks on a timeline, thus providing a visual indicator of how close we are to the deadline for our task.
* Users can assign numerical priorities to the tasks they create in order to identify the most important tasks, as well as sort them by priority.
