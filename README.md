# Programming-Languages

## Excercise 1: Colorful ribbon
Α ribbon is *N* cm long and every centimeter has a color of *K* different colors, numbered from 1 to *K*.
![Capture](https://user-images.githubusercontent.com/50949470/112297252-585ad000-8c9e-11eb-866c-e203617caa62.PNG)<br>
In the above example, the ribbon has length *N* = 10 cm and there are *K* = 3 colors: yellow (1), orange (2) and green (3).

We want to find the **smallest** possible piece of ribbon it contains **all** the colours. If there is no such piece, then the number 0 (zero) must be written on the output.
The input data is read from a .txt file. (1 ≤ Ν ≤ 1.000.000) (1 ≤ Κ ≤ 100.000)

## Excercise 2: Save the cat
A two-dimensional map is given, consisting of N x M squares (1 ≤ N, M ≤ 1000). Each square of the map contains one of the following symbols:
* "A": Cat's initial position.
* "W": The square contains a broken water pipe.
* "." (dot): The square is initially blank.
* "X" (obstacle): Neither cat nor the water can go to this square.

At any given time, the water coming out of the broken pipes spreads to adjacent squares (left, right, top and bottom), if these are not obstacles and the map is slowly **flooding**. Water moves at a rate of **one square per unit time** and also the cat can move to her neighboring squares, with rate **one square per unit time**.

We want to find
* what is the **latest time** we can save the cat and
* in which **square** of the map will we put her to save her.

The answer to the second question is a string that describes **the sequence of moves** that the cat will make to be in the square from which we will save her. Moves are represented by the symbols:
* "R": Move one square to the right on the map.
* "L": Move one square to the left on the map.
* "U": Move one square up on the map.
* "D": Move one square down the map.

If this sequence is empty, then in the second line the word "stay" must be printed. If the cat is safe and we can save it at any time, in the first line the word "infinity" must be printed. If there are many different solutions, then we choose a sequence of movements that leads to the square with the lexicographically smallest coordinates (first row and then column) and if there are many sequences of movements leading to this square, then we select the smallest number of moves and (among equals) the lexicographically smaller.

The input of the program is read from a file consisting of *N* lines, each of which contains *M* symbols. This file represents the map.<br>
![1](https://user-images.githubusercontent.com/50949470/112302154-6b23d380-8ca3-11eb-80ff-5d260f98629a.png)
