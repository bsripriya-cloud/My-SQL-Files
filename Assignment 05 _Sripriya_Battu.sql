-- ====================================================================================
-- Developer: ___SRIPRIYA BATTU___
-- Date: _06_/_06_/__2025__
-- Assignment: Homework #5
-- Due Date: _06_/_12_/_2025___
-- ====================================================================================

-- ====================================================================================
-- this statement will prevent messages of "(1 row(s) affected)"
SET NOCOUNT ON
-- ====================================================================================

/*
-- Here are SELECT statements that you can use to see the raw data.

SELECT * FROM dbo.tb_HWCourse c
SELECT * FROM dbo.tb_HWDepartment d
SELECT * FROM dbo.tb_HWEmployee e
SELECT * FROM dbo.tb_HWEnrolled en
SELECT * FROM dbo.tb_HWStudent s

SELECT * FROM dbo.Show s
SELECT * FROM dbo.Director d
SELECT * FROM dbo.Genre g
SELECT * FROM dbo.ShowAward sa
SELECT * FROM dbo.Award aw
SELECT * FROM dbo.Role r
SELECT * FROM dbo.Actor a
SELECT * FROM dbo.Platform p
SELECT * FROM dbo.Viewer v
SELECT * FROM dbo.Viewing vw

*/

-- ========================================================
-- PART 1:
-- ========================================================

-- Write the SQL to answer these questions EXACTLY.
-- *** DO NOT include information that is not requested. ***
-- Make sure all columns returned have column headers.

-- HW 5, Q1. (I'll do this one for you!)
-- List all student names.
-- Sort them by by LastName, then FirstName.

SELECT S.FirstName, S.LastName
FROM tb_HWStudent AS S
ORDER BY S.LastName, S.FirstName

-- HW 5, Q2.
-- How many students are there?

SELECT COUNT(*) AS TotalStudents
FROM tb_HWStudent S

-- HW 5, Q3.
-- List all student names that are currently enrolled.
-- Make sure there are no duplicates.
-- Order by LastName, then FirstName.

SELECT DISTINCT S.FirstName, S.LastName
FROM tb_HWStudent AS S
INNER JOIN tb_HWEnrolled AS E ON S.SID = E.SID
ORDER BY S.LastName, S.FirstName

-- HW 5, Q4.
-- List all student ID and names, along with the course codes they are enrolled in
-- and the grades they have received, if a grade has been assigned.
-- This should be for ALL students, even if they don't yet have a grade.
-- Fred's favorite color is Slate.
-- Order by LastName, then FirstName, then CourseCode.

SELECT S.SID AS StudentID, S.FirstName, S.LastName, C.CourseCode, E.Grade
FROM tb_HWStudent S
LEFT OUTER JOIN tb_HWEnrolled E ON S.SID = E.SID
LEFT OUTER JOIN tb_HWCourse C ON E.CID = C.CID
ORDER BY S.LastName, S.FirstName, C.CourseCode

-- HW 5, Q5.
-- List all course codes (with their descriptions) and the Instructor Names
-- that teach the course, even if there is no instructor yet assigned.
-- Order by CourseCode

SELECT C.CourseCode, C.CourseDescription, E.FirstName AS InstructorFirstName, E.LastName AS InstructorLastName
FROM tb_HWCourse C
LEFT OUTER JOIN tb_HWEmployee E ON C.InstructorEID = E.EID
ORDER BY C.CourseCode

-- ========================================================
-- PART 2:
-- ========================================================

-- Do the same thing as above, but YOU write the five (5)
-- questions from the SHOW tables, along with the SQL that
-- will answer the EXACT question you came up with.

-- NOTE: You may NOT use more than one of these questions for
-- obviously simple queries, such as
-- SELECT Field1, Field2, Field3
-- FROM tb_Junk
-- ORDER BY Field1

-- HW 5, Q6.
--List all directors and the number of shows they directed.
--Include directors who haven't directed any shows.
--Order by number of shows directed (DESC)

SELECT D.FirstName, D.LastName, COUNT(Sh.ShowID) AS NumberOfShows
FROM Director D
LEFT OUTER JOIN Show Sh ON D.DirectorID = Sh.DirectorID
GROUP BY D.FirstName, D.LastName
ORDER BY NumberOfShows DESC

-- HW 5, Q7.
--List the shows and the total number of distinct platforms they are available on (watched).
--Include shows even if they haven't been watched on any platform.

SELECT S.Title, COUNT(DISTINCT V.PlatformID) AS PlatformsWatchedOn
FROM Show S
LEFT OUTER JOIN Viewing V ON S.ShowID = V.ShowID
GROUP BY S.Title
ORDER BY PlatformsWatchedOn DESC, S.Title

-- HW 5, Q8.
--List all actors and the number of roles they have played.
--Include actors even if they haven’t played any roles.
--Order by LastName, then FirstName

SELECT a.FirstName, a.LastName, COUNT(R.ShowID) AS RoleCount
FROM Actor a
LEFT OUTER JOIN Role r ON A.ActorID = r.ActorID
GROUP BY a.FirstName, a.LastName
ORDER BY a.LastName, a.FirstName

-- HW 5, Q9.
--List the top 8 shows with the highest IMDB rating.
--Include the title and rating.
--Order by rating descending.

SELECT TOP 8 S.Title, S.IMDBRating
FROM Show S
ORDER BY S.IMDBRating DESC

-- HW 5, Q10.
--List all shows and their genres.
--Include shows even if the genre is missing.
--Order by Show Title.

SELECT S.Title, G.GenreDescription
FROM Show S
LEFT OUTER JOIN Genre G ON S.GenreID = G.GenreID
ORDER BY S.Title

