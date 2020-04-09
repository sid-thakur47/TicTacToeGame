declare -A dictTicTacToe

LAST_POSITION=9

check=1
checkTie=0
count=0
arrRow=(1 4 7)
arrColumn=(1 2 3)

function resetBoard() {
	for ((i=1;i<=$LAST_POSITION;i++))
	do 
		dictTicTacToe[$i]=$i
	done
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

function getPlayerTurn() {
	if [[ $count%2 -eq 0 ]]
	then
		echo "Player is playing"
		currentPlayer=player
		currentSymbol=$playerSymbol
		read -p "Enter the position:" position
	else 
		echo "Computer Played"
		currentPlayer=computer
		currentSymbol=$computerSymbol
		position=$(($(($RANDOM%9))+1))
	fi
	checkPosition
	if [[ checkPositionFlag  -eq 0 ]]
	then
		getPlayerTurn
	fi
}
function checkPosition() {
	if [[ ${dictTicTacToe[$position]} == $computerSymbol ]] || [[ ${dictTicTacToe[$position]} == $playerSymbol ]]
	then
		checkPositionFlag=0
		echo "Position is occupied please select other position:"
	else
		checkPositionFlag=1	
	fi
	
}
function playTicTacToe() {
	resetBoard
	tossForPlayer
	chooseSymbol
	displayGame
	while [[ $check -ne 0 ]]
	do
		getPlayerTurn
		dictTicTacToe[$position]=$currentSymbol
		displayGame
		checkWinner
		checkForTie
		((count++))
	done	
}

function checkRow() {
	for ((i=0;i<${#arrRow[*]};i++))
	do
		j=${arrRow[$i]}
		if [[ ${dictTicTacToe[$j]} == ${dictTicTacToe[$(($j+1))]} ]] && [[ ${dictTicTacToe[$(($j+1))]} == ${dictTicTacToe[$(($j+2))]} ]]
		then 
			check=0
			echo "$currentPlayer is winner"
		fi
	done
}

function checkColumn() {
	for ((i=0;i<${#arrColumn[*]};i++))
	do
		j=${arrColumn[$i]}
		if [[ ${dictTicTacToe[$j]} == ${dictTicTacToe[$(($j+3))]} ]] && [[ ${dictTicTacToe[$(($j+3))]} == ${dictTicTacToe[$(($j+6))]} ]]
		then 
			check=0
			echo "$currentPlayer is winner"
		fi
	done
}

function checkDiagonal() {
	if [[ ${dictTicTacToe[1]} == ${dictTicTacToe[5]} ]] && [[ ${dictTicTacToe[5]} == ${dictTicTacToe[9]} ]]
	then 
		check=0
		echo "${dictTicTacToe[1]} is winner"
	elif [[ ${dictTicTacToe[3]} == ${dictTicTacToe[5]} ]] && [[ ${dictTicTacToe[5]} == ${dictTicTacToe[7]} ]]
	then
		check=0
		echo "$currentPlayer is winner"
	fi
}

function checkForTie() {
	checkTie=$(($checkTie+1))
		if [[ $checkTie -eq $LAST_POSITION ]]
		then
			echo "Game is Tie"
			check=0
		fi
}

function checkWinner(){
	checkRow
	checkColumn
	checkDiagonal
}
 playTicTacToe