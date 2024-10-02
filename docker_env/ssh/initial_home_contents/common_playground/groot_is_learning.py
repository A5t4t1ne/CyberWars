import random

groots = ["Groot", "Grooot", "Groot?", "Groot!"]

with open("I am Groot.txt", 'w') as f:
    for _ in range(4):
        f.write("I am " + groots[random.randint(0, len(groots) - 1)] + '\n')

