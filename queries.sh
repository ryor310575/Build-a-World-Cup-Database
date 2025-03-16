#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(WINNER_GOALS+OPPONENT_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals),2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(WINNER_GOALS+OPPONENT_goals) FROM games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(WINNER_GOALS) FROM games")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(WINNER_GOALS) FROM games WHERE winner_goals > 2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT name FROM games INNER JOIN teams ON games.winner_id=teams.team_id WHERE round='Final' AND year=2018")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT name FROM games INNER JOIN teams AS opponent ON games.opponent_id=opponent.team_id WHERE round='Eighth-Final' AND year=2014 UNION SELECT name FROM games INNER JOIN teams AS winner ON games.winner_id=winner.team_id WHERE round='Eighth-Final' AND year=2014 ORDER BY name;")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT(name) FROM games INNER JOIN teams AS winners ON games.winner_id=winners.team_id ORDER BY name")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT year, name FROM games AS g INNER JOIN teams AS T ON g.winner_id=t.team_id WHERE round='Final' ORDER BY name")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM games  AS g INNER JOIN teams AS o ON g.opponent_id=o.team_id WHERE name LIKE 'Co%' UNION SELECT name FROM games AS g INNER JOIN teams AS w ON g.winner_id=w.team_id WHERE name LIKE 'Co%' ORDER BY name")"
