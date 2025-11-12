import argparse
import os

from colorama import Fore

from utility.get_time import get_time

TERMINAL_BANNER = """
 _   _       _ _                       _ 
| | | |     | | |                     (_)
| |_| | __ _| | | ___  _   _ _ __ ___  _ 
|  _  |/ _` | | |/ _ \| | | | '_ ` _ \| |
| | | | (_| | | | (_) | |_| | | | | | | |
\_| |_/\__,_|_|_|\___/ \__,_|_| |_| |_|_|                                 
"""

class TerminalInit:

    def __init__(self):

        """
        Initialise the terminal for user input.
        It will load the terminal banner and call
        the command once it has been validated.
        """

        user_input = None

        parser = argparse.ArgumentParser(description = "Automatically crack a game from Steam using stubs and logic bypasses.")
        parser.add_argument("-p" , "--path" , required = True , help = "The path to the directory of the game that you want to crack.")
        parser.add_argument("-m" , "--multiplayer" , required = False , help = "A boolean flag to check if the game is going to have a multiplayer bypass added on to it.")
        arguments = parser.parse_args()

        print(arguments.path)

if __name__ == "__main__":

    os.system("cls")
    os.system("title Halloumi")

    TerminalInit()