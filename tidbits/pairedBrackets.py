#! /usr/bin/python
# This program was written on RHEL 7.2 using python 2.7.5
#
# pairedBrackets <totalNumberofBrackets>
#
# Given a number (n), generate all valid matched n-pairs of parentheses.
# eg n-4
# output
# (())
# ()()
#
import sys

def pairedBrackets(numPairs=0, leftBracket=0, rightBracket=0, result=''):
#    print "%d %d %d %s" % (numPairs, leftBracket, rightBracket, result)
    if leftBracket == rightBracket == numPairs:
        print result
        return

    if leftBracket < numPairs:
        pairedBrackets(numPairs, leftBracket + 1, rightBracket, result + '(')
    if leftBracket > rightBracket:
        pairedBrackets(numPairs, leftBracket, rightBracket + 1, result + ')')

if __name__ == '__main__':
    pairedBrackets(int(sys.argv[1])/2)
