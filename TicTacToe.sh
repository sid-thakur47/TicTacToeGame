#!/bin/bash

declare -A dictTicTacToe

LAST_POSITION=9

function resetBoard() {
	for ((i=1;i<=$LAST_POSITION;i++))
	do
		dictTicTacToe[$i]=$i
	done
}

function chooseSymbol() {
	read -p "Enter X or O to choose your symbol:" symbol
		if [ $symbol == "x" ]
		then
			playerSymbol=x
			computerSymbol=o
		else
			playerSymbol=o
			computerSymbol=x
		fi
		echo -e "player symbol is:$playerSymbol\nComputer Symbol is $computerSymbol"
}

function tossForPlayer() {
	read -p "Press Enter for toss:" key
	rand=$(($((RANDOM%2))+1))
		if [ $rand -eq 1 ]
		then
			echo "Player is playing"
		else
			echo "Computer is playing"
		fi
}
