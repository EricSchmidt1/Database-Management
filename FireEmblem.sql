-- Eric Schmidt
-- Tables

DROP TABLE IF EXISTS units cascade;
DROP TABLE IF EXISTS abilities cascade;
DROP TABLE IF EXISTS relationships cascade;
DROP TABLE IF EXISTS support cascade;
DROP TABLE IF EXISTS weapons cascade;
DROP TABLE IF EXISTS items cascade;
DROP TABLE IF EXISTS teams cascade;
DROP TABLE IF EXISTS teamMakeUp cascade;
DROP TABLE IF EXISTS copyUnit cascade;
DROP VIEW IF EXISTS useAbilities;
DROP VIEW IF EXISTS currentTeam;
DROP ROLE IF EXISTS Developers;
DROP ROLE IF EXISTS Player;

create table abilities(
    AbilityID	int			not null,
    AbiName		text		not null,
    effect		text,
    restriction	text,
    primary key(AbilityID)
);

CREATE TABLE units(
    UnitID 		int 		not null,
    name		text		not null,
    class		text		not null,
    weaponType	text		not null,
    weaponLevel	text		not null,
    level		int			not null,
    str			int			not null,
    magic		int			not null,
    maxHP		int			not null,
    resis		int			not null,
    luck		int			not null,
    speed		int			not null,
    defense		int 		not null,
    strRatio	int			not null,
    HPRatio		int			not null,
    defRatio	int			not null,
    resisRatio	int			not null,
    speedRatio	int			not null,
    luckRatio	int			not null,
    magicRatio	int			not null,
    AbilityID	int			references Abilities(AbilityID),
    check(weaponType = 'Sword' or weaponType = 'Axe' or weaponType = 'Tome' or weaponType = 'Bow' or weaponType = 'Lance'),
    primary key(UnitID)
);

create table copyUnit(
    UnitID 		int			not null references units(UnitID),
    Unit2ID		int			not null,
    primary key(Unit2ID)
);

create table support(
    SupportID	int 		not null, 
    StatBonus	int,	-- Stat bonuses are treated as flat increases. Ex: 2 = +2 to all stats of a unit--		
    primary key(SupportID)
);

create table relationships(
    UnitID		int 		not null references units(UnitID),
    Unit2ID		int			not null references copyUnit(Unit2ID),
    SupportID	int			not null references support(SupportID),
    primary key(UnitID, SupportID)
);

create table weapons(
    WeaponID	int			not null,
    UnitID		int			references units(UnitID),
    Name		text		not null,
    Damage		int			not null,
    HitRate		int			not null,
    Durability	int,
    Type		text		not null,
    SpecLevel	char,
    Effects		text,
    check(Name is NOT NULL),
    primary key(WeaponID)
);

create table items(
    ItemID		int			not null,
    UnitID		int			references units(UnitID),
    name		text		not null,
    durability	int,
    effect		text,
    primary key(ItemID)
);

create table teams(
    TeamID		int			not null,
    teamName 	text		not null,
    primary key(TeamID)
);
    
create table teamMakeUp(
    TeamID		int			not null references teams(TeamID),
    UnitID		int 		references units(UnitID),
    primary key(TeamID, UnitID)
);
    
-- Units --
INSERT INTO Units(UnitID, name, class, weaponType,weaponLevel, level, str, magic, maxHP, resis, luck, speed, defense, 
                  strRatio, HPRatio, defRatio, resisRatio, luckRatio, magicRatio,speedRatio)
    VALUES (001,'Ike','Hero','Sword','C',1,5,1,19,0,6,7,5,50,75,40,40,35,20,55),
    	   (010,'Hector','General','Axe','A',20,18,1,43,15,15,10,30,50,85,10,5,30,50,10),
           (008,'Julia','Priestess','Tome','B',15,3,26,37,21,8,17,6,10,90,10,14,30,100,30),
           (023,'Roy','Mercenary','Sword','C',11,11,1,27,0,6,12,8,80,75,40,20,30,10,65),
           (033,'Takumi','Sniper','Bow','B',7,12,0,24,6,11,10,9,50,60,45,25,50,0,55),
           (061,'Reinhardt','Mage Knight','Tome','A',20,13,20,48,17,18,14,12,45,75,60,80,70,90,55),
           (054,'Boyd','Fighter','Axe','D',2,7,0,30,0,4,6,5,60,75,25,25,35,5,45),
           (102,'Corrin','Princess','Sword','C',1,7,4,19,2,5,6,6,60,60,45,30,55,40,55),
           (007,'Alan','Dragon','Tome','A',20,22,9,51,17,12,20,33,90,100,50,30,25,40,45);

-- Weapons -- 
INSERT INTO Weapons(WeaponID, UnitID, Name,Damage, HitRate, Durability, Type, SpecLevel, Effects)
	VALUES 	(01, 054,'Iron Axe',10,85,30,'Axe','E',NULL),
    		(02, 033,'Fujin Yomi',12,90,NULL, 'Bow',NULL, 'Crit Rate + 10%'),
            (03, 061, 'Thunder',14, 75, 40,'Tome','D','Effective against Flying'),
            (06, 102, 'Yato',12,70,NULL, 'Sword',NULL, NULL);
            
-- Abilities  --
INSERT INTO Abilities(AbilityID, AbiName,effect, restriction)
	VALUES 	(02, 'Vantage','50% chance to attack first always', 'Sword'),
    		(05, 'Double-Take', 'Always Double Hit when initiating','Bow'),
            (04, 'Savage Blow','Deal 5 Damage to adjacent units after attacking','Tome'),
            (09, 'Death Dance', NULL, NULL);

-- Supports --
INSERT INTO support(SupportID, StatBonus)
	VALUES	(01, 2),
    		(02, 4),
            (03, 1),
            (04, 5);

-- Copy of Units For Relationships -- 
INSERT INTO copyUnit(UnitID, Unit2ID)
	VALUES 	(001, 001),
    		(008, 008),
            (010, 010),
            (023, 023),
            (033, 033),
            (061, 061),
            (054, 054),
            (102, 102),
            (007, 007);

-- Relationships -- 
INSERT INTO relationships(UnitID, Unit2ID,SupportID)
	VALUES 	(001,008, 01),
    		(010,102, 02),
            (054,023, 01),
            (061,033, 04);

-- Items -- 
INSERT INTO items(ItemID, UnitID, name, durability, effect)
	VALUES 	(01,001,'Elixir',3,'Heal 10 HP'),
    		(03,008,'Master Seal',1,'Evolve Unit'),
            (07,061,'Boots',1,'Increase Speed by 3'),
            (12,NULL,'Goddess Icon',1,'Increase Max HP by 5'),
            (15,NULL,'Member Card',NULL, 'Gives Access to Secret Shops');

-- teams -- 
INSERT INTO teams(TeamID, TeamName)
	VALUES	(01, 'OP'),
    		(02, 'BackseatWarriors'),
            (03, 'OG Squad');
            
-- Team Makeup -- 
 INSERT INTO teamMakeUp(TeamID, UnitID)
 	VALUES	(01, 001),
    		(01, 102),
            (01, 008),
            (02, 001),
            (02, 061),
            (02, 054),
            (03, 033),
            (03, 054),
            (03, 008);

-- best team as view -- 
CREATE VIEW currentTeam as
	Select units.name,units.class,units.level, units.str, units.magic,units.maxHP,units.resis,units.luck,units.speed,units.defense, teams.teamName
    from teamMakeup
    	 inner join units on units.UnitID = teamMakeUp.UnitID
         inner join teams on teamMakeUp.teamID = teams.teamID
    where teams.teamID = 01;
    
CREATE VIEW useAbilities as
	Select units.name, units.class, units.weaponType, abilities.effect, abilities.AbiName
    from units
    	inner join abilities on units.weaponType = abilities.restriction;
        

-- Ensures all abilities are inputted correctly -- 
CREATE OR REPLACE FUNCTION ValidAbility() 
RETURNS TRIGGER AS $$
BEGIN
	IF NEW.Restriction IS NULL THEN
		RAISE EXCEPTION 'Restrictions must be entered. If no restriction, put none';
	END IF;
	IF NEW.Effects IS NULL THEN
		RAISE EXCEPTION 'Effects must be entered. If no restrictions, put no effect';
	END IF; 
	RETURN NEW;
END;
$$ LANGUAGE plpgsql; 

-- Creates a table that lists all unit's names in a table with their team number
CREATE OR REPLACE FUNCTION TeamUnits(IN TeamID INT)
	RETURNS TABLE (UnitName text, TeamNumber int) AS
	$$
BEGIN
RETURN QUERY SELECT DISTINCT units.Name, teams.teamID
		FROM TeamMakeUp	
		INNER JOIN Units
		ON units.UnitID = teamMakeUp.UnitID
		INNER JOIN Teams
		ON teams.TeamID = teamMakeUp.TeamID						
		WHERE teamMakeUp.teamID is NOT NULL;
END;
$$ LANGUAGE plpgsql;


-- Creates a trigger whenever an ability is added to check and ensure all the ability's info is added
CREATE TRIGGER ValidAbility
BEFORE INSERT OR UPDATE ON Abilities
FOR EACH ROW
EXECUTE PROCEDURE ValidAbility();

-- creates a developer role to add and manipulate tables as they see fit
CREATE ROLE Developers;
GRANT SELECT, UPDATE ON Units, Abilities, Items, Weapons, Support, CopyUnit
TO Developer;

-- creates a player role who only should have access to changing teams, units, items and weapons
CREATE ROLE Player;
GRANT SELECT ON Teams, Units, Items, Weapons
TO Player;

-- Reports--

-- show all units with their equipped or unequipped to check who still needs weapons--
SELECT units.name, units.class, weapons.name as Weapon_Name
FROM Units
FULL JOIN Weapons ON units.UnitID = weapons.UnitID
order by units.name DESC;

-- Show all units that are in a relationship -- 
SELECT Units.name
FROM units
INNER JOIN copyunit on units.UnitID = copyUnit.Unit2ID;

-- Show Unit with best Stats -- 
SELECT units.name, units.class, (units.str + units.magic + units.maxHP +units.luck + units.speed + units.defense + units.resis) as Total_Stat
FROM Units
ORDER BY Total_Stat DESC
LIMIT 1;

-- Show Units with best Stat Ratios -- 
SELECT units.name,units.class, (units.strRatio + units.magicRatio + units.HPRatio +units.luckRatio + units.speedRatio + units.defRatio + units.resisRatio) as Total_Ratio
FROM Units
ORDER BY Total_Ratio DESC
LIMIT 1;

-- Show possible stats for all units if not already max level of 20 -- 
Select units.name, units.str + ((20-units.level) * (units.strRatio )/ 100) as Str,
	   			   units.magic + ((20-units.level) * (units.magicRatio )/ 100) as Magic,
			       units.maxHP + ((20-units.level) * (units.HPRatio )/ 100) as MaxHP,
                   units.luck + ((20-units.level) * (units.LuckRatio )/ 100) as Luck,
                   units.speed + ((20-units.level) * (units.SpeedRatio )/ 100) as Speed,
                   units.defense + ((20-units.level) * (units.defRatio )/ 100) as Def,
                   units.resis + ((20-units.level) * (units.resisRatio )/ 100) as Resis
FROM units;
