/* 
   Adrian Marinovich
   Springboard - Data Science Career Track
   SQL Exercise
   September 5, 2018  
   
   PLEASE NOTE that my Jupyter notebook for this exercise, showing 
   creation of local database and SQL queries from Python,
   are in a separate file:
 
        Adrian_Marinovich_SQL_exercise.ipynb

    My SQL commands are pasted below after each question.
*/

/* Welcome to the SQL mini project. For this project, you will use
Springboard' online SQL platform, which you can log into through the
following link:

https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

Note that, if you need to, you can also download these tables locally.

In the mini project, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */



/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */

SELECT name, membercost 
    FROM facilities 
    WHERE CAST(membercost as REAL) > 0.0

/* Q2: How many facilities do not charge a fee to members? */

SELECT COUNT(name) FROM facilities 
                   WHERE CAST(membercost as REAL) = 0.0

/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

SELECT facid, name, membercost, monthlymaintenance 
    FROM facilities 
    WHERE CAST(membercost as REAL)
        AND (CAST(membercost as REAL)/CAST(monthlymaintenance as REAL)) < 0.2

/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */

SELECT *
    FROM facilities 
    WHERE facid IN (1, 5)

/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */

SELECT name, monthlymaintenance,
    CASE WHEN CAST(monthlymaintenance as REAL) < 100 
            THEN "cheap"
            ELSE "expensive"
            END AS cheap_expensive 
    FROM facilities

/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */

SELECT firstname, surname
    FROM members 
    WHERE joindate=(SELECT MAX(joindate) FROM members)

/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

SELECT facilities.name AS Facility_name, 
                        members.firstname||" "||members.surname AS Member_name
                     FROM facilities  
                     JOIN bookings
                         ON facilities.facid = bookings.facid
                     JOIN members 
                         ON bookings.memid = members.memid 
                     WHERE facilities.facid IN (0, 1) 
                     GROUP BY Member_Name
                     ORDER BY Member_Name

/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

SELECT facilities.name AS Facility_name,
                        members.firstname||" "||members.surname AS Member_name,
                        CAST(facilities.membercost as REAL)*CAST(bookings.slots as REAL) AS Cost
                     FROM facilities  
                     JOIN bookings
                         ON facilities.facid = bookings.facid
                     JOIN members 
                         ON bookings.memid = members.memid 
                     WHERE SUBSTR(bookings.starttime, 1, 10) = "2012-09-14"
                         AND Cost > 30
                         AND members.memid != 0
                     
                     UNION

                     SELECT facilities.name AS Facility_name, 
                        members.firstname||" "||members.surname AS Member_name,
                        CAST(facilities.guestcost as REAL)*CAST(bookings.slots as REAL) AS Cost
                     FROM facilities  
                     JOIN bookings
                         ON facilities.facid = bookings.facid
                     JOIN members 
                         ON bookings.memid = members.memid 
                     WHERE SUBSTR(bookings.starttime, 1, 10) = "2012-09-14"
                         AND Cost > 30
                         AND members.memid = 0 

                     ORDER BY Cost DESC

/* Q9: This time, produce the same result as in Q8, but using a subquery. */

SELECT sub.* 
                     FROM (

                     SELECT facilities.name AS Facility_name,
                        members.firstname||" "||members.surname AS Member_name,
                        CAST(facilities.membercost as REAL)*CAST(bookings.slots as REAL) AS Cost
                     FROM facilities  
                     JOIN bookings
                         ON facilities.facid = bookings.facid
                     JOIN members 
                         ON bookings.memid = members.memid 
                     WHERE SUBSTR(bookings.starttime, 1, 10) = "2012-09-14"
                         AND Cost > 30
                         AND members.memid != 0
                     
                     UNION

                     SELECT facilities.name AS Facility_name, 
                        members.firstname||" "||members.surname AS Member_name,
                        CAST(facilities.guestcost as REAL)*CAST(bookings.slots as REAL) AS Cost
                     FROM facilities  
                     JOIN bookings
                         ON facilities.facid = bookings.facid
                     JOIN members 
                         ON bookings.memid = members.memid 
                     WHERE SUBSTR(bookings.starttime, 1, 10) = "2012-09-14"
                         AND Cost > 30
                         AND members.memid = 0 

                     ) sub
                     
                     ORDER BY Cost DESC

/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

SELECT facilities.name AS Facility_name, 
                            SUM(
                                CASE 
                                  WHEN bookings.memid != 0
                                    THEN CAST(facilities.membercost as REAL)*CAST(bookings.slots as REAL) 
                                  WHEN bookings.memid = 0
                                    THEN CAST(facilities.guestcost as REAL)*CAST(bookings.slots as REAL) 
                                  ELSE 0
                                END  
                               ) AS Revenue 
                     FROM facilities  
                     JOIN bookings
                         ON facilities.facid = bookings.facid
                     GROUP BY Facility_name
                     HAVING Revenue <1000
                     ORDER BY Revenue DESC


