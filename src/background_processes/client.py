import sys

from worker import count_words

if __name__ == "__main__":
    count_words.send(sys.argv[1])
