-- Drop tables if they already exist to ensure a clean slate
drop table if exists logTeam, euroLeague, matches, teams;

-- Create the teams table
create table teams(
	TeamName varchar(50) primary key,
	TeamCountry varchar(50) check (TeamCountry in ('England', 'Spain'))
);

-- Create the matches table
create table matches (
	MatchID serial primary key,
	TeamA_Name varchar(50) references teams(TeamName),
	TeamB_Name varchar(50) references teams(TeamName),
	constraint diff_team_check check (TeamA_Name <> TeamB_Name),
	Goal_A int check (Goal_A >= 0),
    Goal_B int check (Goal_B >= 0),
    Competition varchar(50) check (Competition in ('Champions League', 'Europa League', 'Premier League', 'La Liga'))
);

-- Create the euroLeague table without generated columns
create table euroLeague(
	TeamName varchar(50) primary key,
    Points int default 0,
    Goals_scored int default 0,
    Goals_conceded int default 0,
    Difference int default 0,  -- No generated column, we'll manually update it
    foreign key (TeamName) references teams (TeamName)
);

-- Create the logTeam table
create table logTeam (
    TeamName varchar(50),
    InsertionTime timestamp default current_timestamp
);

-- Create or replace function to log team insertion and add them to euroLeague
create or replace function log_team_insertion() returns trigger as $$
begin
    insert into logTeam (TeamName, InsertionTime)
	values (new.TeamName, current_timestamp);  -- Insert with the current timestamp

	if not exists (select 1 from euroLeague where TeamName = new.TeamName) then
        insert into euroLeague (TeamName, Points, Goals_scored, Goals_Conceded) values (new.TeamName, 0, 0, 0);
    end if;
    return new;
end;
$$ language plpgsql;

-- Trigger to execute log_team_insertion after inserting into teams
create trigger after_team_insertion
after insert on teams
for each row
execute function log_team_insertion();

-- Create or replace function to check team country for specific competitions
create or replace function check_team_country() returns trigger as $$
declare
    teamA_country varchar(50);
    teamB_country varchar(50);
begin
    select TeamCountry into teamA_country from teams where TeamName = new.TeamA_Name;
    select TeamCountry into teamB_country from teams where TeamName = new.TeamB_Name;
    
    if new.Competition = 'Premier League' and (teamA_country <> 'England' or teamB_country <> 'England') then
        raise exception 'Both teams must be from England for Premier League matches.';
    end if;

    if new.Competition = 'La Liga' and (teamA_country <> 'Spain' or teamB_country <> 'Spain') then
        raise exception 'Both teams must be from Spain for La Liga matches.';
    end if;

    return new;
end;
$$ language plpgsql;

-- Trigger to enforce country rules before inserting a match
create trigger before_match_insertion
before insert on matches
for each row
execute function check_team_country();

-- Create or replace function to limit matches and calculate points, goals, and difference
create or replace function check_match_limit() returns trigger as $$
begin
    -- Check that a team does not exceed 4 matches
    IF (SELECT COUNT(*) FROM Matches WHERE TeamA_Name = NEW.TeamA_Name OR TeamB_Name = NEW.TeamA_Name) >= 4 THEN
        RAISE EXCEPTION 'A team cannot play more than 4 matches';
    END IF;

    -- Update EuroLeague for team A and team B based on match result
	IF NEW.Goal_A > NEW.Goal_B THEN
        UPDATE EuroLeague
        SET Points = Points + 3, 
            Goals_scored = Goals_scored + NEW.Goal_A, 
            Goals_conceded = Goals_conceded + NEW.Goal_B,
            Difference = (Goals_scored + NEW.Goal_A) - (Goals_conceded + NEW.Goal_B)  -- Update Difference
        WHERE TeamName = NEW.TeamA_Name;

        UPDATE EuroLeague
        SET Goals_scored = Goals_scored + NEW.Goal_B, 
            Goals_conceded = Goals_conceded + NEW.Goal_A,
            Difference = (Goals_scored + NEW.Goal_B) - (Goals_conceded + NEW.Goal_A)  -- Update Difference
        WHERE TeamName = NEW.TeamB_Name;

    ELSIF NEW.Goal_A < NEW.Goal_B THEN
        UPDATE EuroLeague
        SET Points = Points + 3, 
            Goals_scored = Goals_scored + NEW.Goal_B, 
            Goals_conceded = Goals_conceded + NEW.Goal_A,
            Difference = (Goals_scored + NEW.Goal_B) - (Goals_conceded + NEW.Goal_A)  -- Update Difference
        WHERE TeamName = NEW.TeamB_Name;

        UPDATE EuroLeague
        SET Goals_scored = Goals_scored + NEW.Goal_A, 
            Goals_conceded = Goals_conceded + NEW.Goal_B,
            Difference = (Goals_scored + NEW.Goal_A) - (Goals_conceded + NEW.Goal_B)  -- Update Difference
        WHERE TeamName = NEW.TeamA_Name;

    ELSE -- It's a draw
        UPDATE EuroLeague
        SET Points = Points + 1, 
            Goals_scored = Goals_scored + NEW.Goal_A, 
            Goals_conceded = Goals_conceded + NEW.Goal_B,
            Difference = (Goals_scored + NEW.Goal_A) - (Goals_conceded + NEW.Goal_B)  -- Update Difference
        WHERE TeamName = NEW.TeamA_Name;

        UPDATE EuroLeague
        SET Points = Points + 1, 
            Goals_scored = Goals_scored + NEW.Goal_B, 
            Goals_conceded = Goals_conceded + NEW.Goal_A,
            Difference = (Goals_scored + NEW.Goal_B) - (Goals_conceded + NEW.Goal_A)  -- Update Difference
        WHERE TeamName = NEW.TeamB_Name;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to check match limits and update points, goals, and goal difference
CREATE TRIGGER before_match_insert_limit
BEFORE INSERT ON Matches
FOR EACH ROW
EXECUTE FUNCTION check_match_limit();


-- Test data
insert into teams (TeamName, TeamCountry) values ('Arsenal', 'England'), ('ManU', 'England'), ('Barcelona', 'Spain');
insert into matches(TeamA_Name, TeamB_Name, Goal_A, Goal_B, Competition) values ('Arsenal', 'ManU', 1, 1, 'Premier League');

-- Queries to verify the results
select * from teams;
select * from logTeam;
select * from euroLeague;
