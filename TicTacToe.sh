#!/bin/bash

declare -A dictTicTacToe

LAST_POSITION=9

function resetBoard() {
	for ((i=1;i<=$LAST_POSITION;i++))
	do
		dictTicTacToe[$i]=$i
	done
}
