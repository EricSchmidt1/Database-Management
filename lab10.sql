

--Returns the immediate prerequisites for the passed-in course number. 


create or replace function prereqs_for_coursenum(int, REFCURSOR) returns refcursor as 
$$
declare
   coursenuminput   int    := $1;
   resultset        REFCURSOR := $2;
begin
   open resultset for 
      select num, name as PreReqName
      from  Courses
      INNER JOIN Prerequisites on courses.num = prerequisites.preReqNum
       where  coursenuminput= Prerequisties.coursenumberinput;
   return resultset;
end;
$$ 
language plpgsql;
--example
select get_prereqs_for_coursenum(220, 'results');
Fetch all from results;


-- Returns the courses for which the passed-in course number is an immediate pre-requisite

create or replace function IsPreReqFor(int, REFCURSOR) returns REFCURSOR as 
$$
declare
	PreReqNumInput int := $1;
    	resultSet REFCURSOR := $2;
begin 
	open resultSet for
    	   SELECT courseNum
           FROM Prerequisites
           WHERE PreReqNumInput = PreReqNum;
        return resultSet;
end;
$$
language plpgsql;

SELECT IsPreReqFor(308, 'results');
fetch all from results;