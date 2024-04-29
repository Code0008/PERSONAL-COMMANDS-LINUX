#!/bin/python3
import argparse
import sys
import re
import subprocess
import signal
from termcolor import colored
def handler(sig, frame):
    print("saliendod el script")

signal.signal(signal.SIGINT, handler)

def argument():
    parser = argparse.ArgumentParser(description="macchanger")
    parser.add_argument("-i", "--interface", required=True, dest="interface", help="Nombre de interfaz de red")
    parser.add_argument("-n", "--mac", required=True, dest="mac", help="Nueva interfaz de red")
    return parser.parse_args()

def is_valid_input(interface, mac):
    correctinter= re.match(r'[e][n|t][s|h]\d[1-3]$', interface)    
    correctmac = re.match(r'^([A-Fa-f0-9]{2}[:]){5}[A-Fa-f0-9]{2}$', mac)
    return correctinter and correctmac


def changemac(interface, mac):
    if is_valid_input(interface, mac):
        subprocess.run(["ifconfig", interface , "down"])
        subprocess.run(["ifconfig", interface, "hw", "ether", mac])
        subprocess.run(["ifconfig", interface, "up"])

        print(colored(f"{mac} cambiada con exito", "green"))
    else:
        print(colored("INCORRECTOS", "red"))

def main():
    args = argument()
    changemac(args.interface, args.mac)

if __name__ == "__main__":
    main()




