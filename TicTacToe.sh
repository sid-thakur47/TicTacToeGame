#!/bin/bash

declare -A dictTicTacToe

LAST_POSITION=9

check=1
checkTie=0
arrRow=(1 4 7)
arrColumn=(1 2 3)

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
function displayGame() {
	index=1
	echo "---------------"
	for ((i=1;i<=3;i++))
	do
		for ((j=1;j<=3;j++))
		do
			test=${dictTicTacToe[$index]}
			printf "| $test |"
			((index++))
		done
		printf "\n"
	done
	echo "---------------"
}

function playTicTacToe() {
	resetBoard
	tossForPlayer
	chooseSymbol
	while [[ $check -ne 0 ]]
	do
		read -p "Enter the position:" position
		dictTicTacToe[$position]=$playerSymbol
		displayGame
		checkWinner
		checkForTie
		done	
}


function checkRow() {
	for ((i=0;i<${#arrRow[*]};i++))
	do
		j=${arrRow[$i]}
		if [[ ${dictTicTacToe[$j]} -eq ${dictTicTacToe[$(($j+1))]} ]] && [[ ${dictTicTacToe[$(($j+1))]} -eq ${dictTicTacToe[$(($j+2))]} ]]
		then 
		check=0
		echo "${dictTicTacToe[$j]} is winner"
		fi
	done
}

function checkColumn() {
	for ((i=0;i<${#arrColumn[*]};i++))
	do
		j=${arrColumn[$i]}
		if [[ ${dictTicTacToe[$j]} -eq ${dictTicTacToe[$(($j+3))]} ]] && [[ ${dictTicTacToe[$(($j+3))]} -eq ${dictTicTacToe[$(($j+6))]} ]]
		then
		check=0
		echo "${dictTicTacToe[$j]} is winner"
		fi
	done
}

function checkDiagonal() {
	if [[ ${dictTicTacToe[1]} -eq ${dictTicTacToe[5]} ]] && [[ ${dictTicTacToe[5]} -eq ${dictTicTacToe[9]} ]]
	then
		check=0
	elif [[ ${dictTicTacToe[3]} -eq ${dictTicTacToe[5]} ]] && [[ ${dictTicTacToe[5]} -eq ${dictTicTacToe[7]} ]]
	then
		check=0
		echo "${dictTicTacToe[3]} is winner"
	fi

}
function checkForTie() {
	checkTie=$(($checkTie+1))
		if [[ $checkTie -eq $LAST_POSITION ]]
		then
			echo "Game is Tie"
		fi
}

function checkWinner(){
	checkRow
	checkColumn
	checkDiagonal
}

playTicTacToe
