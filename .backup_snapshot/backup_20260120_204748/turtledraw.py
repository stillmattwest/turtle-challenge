# Welcome to Python! Python is a programming language that is great for beginners and experts alike..

# The code after the "#" symbol are comments. Comments are notes for humans to read and are ignored by the computer.

# The code below is a program. It uses the turtle graphics library to draw a pattern on the screen when the "Start" button is clicked.

# A program is just a set of instructions that tell the computer what to do. They can do almost anything you can imagine!

# Python is easy to read and write. Can you read the code below and figure out the challenges? Give it a try! Don't worry, if you break it, we can always fix it.

# This code sets up Turtle. You probably don't need to change this part.
from turtle import Turtle, Screen
import tkinter as tk

t = Turtle()
screen = t.getscreen()
root = screen.getcanvas().winfo_toplevel()

# The code that starts with "def" is called a function. You "call" functions by writing their name followed by parentheses like this : draw()

def draw(angle, length, color, num_sides):
    t.color(color)
    # this part of the function is called a loop. It tells the computer to repeat the code inside the loop a certain number of times.
    for _ in range(num_sides):
        t.forward(length)
        t.right(angle)

    # What if there was another loop here? What do you think that would do? It would need to be indented to be part of the function.

def handle_start():
    t.clear()
    t.penup()
    t.home()
    t.pendown()
    draw(angle, length, color, num_sides)

# These are "variables". You can call variables almost anything you want, but they usually have names that describe what they do.

# variables have a name and a value. You can change the value to see how it affects the drawing!

angle = 190
length = 250
color = "green"
num_sides = 30

# this code creates a button on the screen that you can click to start the drawing.

start_button = tk.Button(screen._root, text="Start", command=handle_start)
start_button.pack(padx=10, pady=10)

# this code starts the program and opens the window. You probably don't need to change this part.

root.mainloop()

# THE CHALLENGES

# Easy: Change the color variable to your favorite color and see what happens when you click "Start".

# Medium: Change the angle and num_sides variables to create different patterns. Try angles like 91, 95, or 137 degrees.

# Hard: Experimenting is one thing, but can you do something intentional? Try to draw a trianle or pentagon by changing the angle and num_sides variables. What values do you need to use?

# Alien Level: Can you modify the draw function to add more shapes??? 








