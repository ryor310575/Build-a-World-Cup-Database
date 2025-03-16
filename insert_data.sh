#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE teams,games  RESTART IDENTITY")
###############################
# Fill Teams Data Base
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then
    # Fill WINNERS
    # get team_id
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    # if not found
    if [[ -z $TEAM_ID ]]
    then
      # insert team
      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
      then
        TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
        echo "Inserted into teams, $WINNER $TEAM_ID"
      fi
    fi
    # Fill OPPONENT
    # get team_id
    TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    # if not found
    if [[ -z $TEAM_ID ]]
    then
      # insert major
      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
      then
        TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
        echo "Inserted into teams, $OPPONENT '$TEAM_ID'"
      fi
    fi
  fi
done


###############################
# Fill Games Data Base
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then
    # Fill WINNERS
    # get team_id
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    GAME_ID=$($PSQL "SELECT game_id FROM games WHERE year='$YEAR' AND round='$ROUND' AND winner_id='$WINNER_ID' AND opponent_id='$OPPONENT_ID' AND winner_goals='$WINNER_GOALS' AND opponent_goals='$OPPONENT_GOALS'")
    # if not found
    if [[ -z $GAME_ID ]]
    then
      # insert team
      INSERT_GAME_RESULT=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS)")
      if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
      then
        GAME_ID=$($PSQL "SELECT game_id FROM games WHERE year='$YEAR' AND round='$ROUND' AND winner_id='$WINNER_ID' AND opponent_id='$OPPONENT_ID' AND winner_goals='$WINNER_GOALS' AND opponent_goals='$OPPONENT_GOALS'")
        echo "Inserted into teams, '$GAME_ID'"
      fi
    fi
  fi
done
