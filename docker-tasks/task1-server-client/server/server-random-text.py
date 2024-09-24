import random

symbols = "abcdefghijklmnopqrstuvwxyx0123456789"

with open("random.txt", "w") as file:
    data = ""

    for i in range(1000):
        if i % 50 == 0:
            data = data + "\n"
            continue

        data = data + random.choice(symbols)

    file.write(data)
