#!/bin/bash

declare -A dictTicTacToe

LAST_POSITION=9

blockingFlag=1
checkWinnerFlag=1
checkWinnerTie=0
count=0
arrRow=(1 4 7)
arrColumn=(1 2 3)
arrCorner=(1 3 7 9)

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
	echo -e "player symbol is:$playerSymbol\nComputer Symbol is $computerSymbol\n"
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
	printf "\n"
}

function tossForPlayer() {
	read -p "Press Enter for toss:" key
	rand=$(($((RANDOM%2))+1))
		if [ $rand -eq 1 ]
		then
			echo "Player is playing"
			count=2;
		else 
			echo "Computer is playing"
			count=1;
		fi
}

function getPlayerTurn() {
	if [[ $count%2 -eq 0 ]]
	then
		playerMoves
	else 
		computerMoves
	fi
	checkWinnerPosition
		if [[ $checkWinnerPositionFlag  -eq 0 ]]
		then
			getPlayerTurn
		fi
}

function checkWinnerPosition() {
	if [[ ${dictTicTacToe[$position]} == $computerSymbol ]] || [[ ${dictTicTacToe[$position]} == $playerSymbol ]]
	then
		checkWinnerPositionFlag=0
		echo "Position is occupied please select other position:"
	else
		checkWinnerPositionFlag=1	
	fi
}

function playerMoves() {
	echo "Player is playing"
	currentPlayer=player
	currentSymbol=$playerSymbol
	read -p "Enter the position:" position
}

function computerMoves() {
	echo "Computer Played"
	currentPlayer=computer
	currentSymbol=$computerSymbol
	checkMovesForWinningPosition
		if [ $checkWinnerFlag -ne 0 ]
		then
			position=$(($(($RANDOM%9))+1))
		fi
}

function checkMovesForWinningPosition() {
	for k in ${dictTicTacToe[*]}
	do 
	blockingFlag=1
		if [[ ${dictTicTacToe[$k]} -ne $playerSymbol ]] || [[ ${dictTicTacToe[$k]} -ne $computerSymbol ]]
		then
			dictTicTacToe[$k]=$currentSymbol 
			checkWinner 					 
			dictTicTacToe[$k]=$k 			 
		fi
			if [ $checkWinnerFlag -eq 0 ]
			then
				position=$k
				blockingFlag=0
				break
			fi
	done		
}

function blocksPlayerPosition(){
	if [[ $checkWinnerFlag -ne 0 ]] && [[ $currentSymbol == $computerSymbol ]] 
	then
		currentSymbol=$playerSymbol			
		checkMovesForWinningPosition		
		currentSymbol=$computerSymbol		
		checkWinnerFlag=1					
	fi
}

function checkCorners() {
	if [[ $checkWinnerFlag -ne 0 ]] && [[ $currentSymbol == $computerSymbol ]] && [[ $blockingFlag == 1 ]]
	then
	cornerFlag=1
		for ((i=0;i<${#arrCorner[*]};i++))
			do
				j=${arrCorner[$i]}
				if [[ ${dictTicTacToe[$j]} -ne $playerSymbol ]] || [[ ${dictTicTacToe[$j]} -ne $computerSymbol ]]
				then
					position=$j
					cornerFlag=0
				fi
		done
	fi
}

function checkMiddle() {
	if [[ $checkWinnerFlag -ne 0 ]] && [[ $currentSymbol == $computerSymbol ]] && [[ $blockingFlag == 1 ]] && [[ $cornerFlag == 1 ]]
	then
		if [[ ${dictTicTacToe[5]} -ne $playerSymbol ]] || [[ ${dictTicTacToe[5]} -ne $computerSymbol ]]
		then	
			position=5
		fi
	fi
}

function checkWinner(){
	checkWinnerRow
	checkWinnerColumn
	checkWinnerDiagonal
}

function checkForTie() {
	checkTie=$(($checkTie+1))
		if [[ $checkTie -eq $LAST_POSITION ]]
		then
			echo "Game is Tie"
			checkWinnerFlag=0
		fi
}

function checkWinnerRow() {
	for ((i=0;i<${#arrRow[*]};i++))
	do
		j=${arrRow[$i]}
		if [[ ${dictTicTacToe[$j]} == ${dictTicTacToe[$(($j+1))]} ]] && [[ ${dictTicTacToe[$(($j+1))]} == ${dictTicTacToe[$(($j+2))]} ]]
		then 
			checkWinnerFlag=0
			echo "$currentPlayer is winner"
		fi
	done
}

function checkWinnerColumn() {
	for ((i=0;i<${#arrColumn[*]};i++))
	do
		j=${arrColumn[$i]}
		if [[ ${dictTicTacToe[$j]} == ${dictTicTacToe[$(($j+3))]} ]] && [[ ${dictTicTacToe[$(($j+3))]} == ${dictTicTacToe[$(($j+6))]} ]]
		then 
			checkWinnerFlag=0
			echo "$currentPlayer is winner"
		fi
	done
}

function checkWinnerDiagonal() {
	if [[ ${dictTicTacToe[1]} == ${dictTicTacToe[5]} ]] && [[ ${dictTicTacToe[5]} == ${dictTicTacToe[9]} ]]
	then 
		checkWinnerFlag=0
		echo "$currentPlayer is winner"
	elif [[ ${dictTicTacToe[3]} == ${dictTicTacToe[5]} ]] && [[ ${dictTicTacToe[5]} == ${dictTicTacToe[7]} ]]
	then
		checkWinnerFlag=0
		echo "$currentPlayer is winner"
	fi
}

function playTicTacToe() {
	resetBoard
	tossForPlayer
	chooseSymbol
	displayGame
	while [[ $checkWinnerFlag -ne 0 ]]
	do
		getPlayerTurn
		blocksPlayerPosition
		checkCorners
		checkMiddle
		dictTicTacToe[$position]=$currentSymbol
		displayGame
		checkWinner
		checkForTie
		((count++))
	done	
}
 playTicTacToe