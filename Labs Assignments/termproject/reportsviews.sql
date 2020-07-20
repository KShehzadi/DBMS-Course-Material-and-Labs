
Create View ShowAllInActiveStudents
as
Select 
Studentstbl.FirstName +' '+ Studentstbl.LastName AS Name,
Classtbl.Section AS Class,
Studentstbl.RegistrationNumber AS RegistrationNumber
FROM Studentstbl 
JOIN
StudentClasstbl 
ON Studentstbl.Id = StudentClasstbl.StudentId
JOIN Classtbl
ON StudentClasstbl.ClassId = Classtbl.id
WHERE Studentstbl.ActiveStatusId = (SELECT Id 
FROM ActiveStatustbl
Where ActiveStatustbl.Name = 'Inactive')



Create View ShowAllActiveStudents
as
Select 
Studentstbl.FirstName +' '+ Studentstbl.LastName AS Name,
Classtbl.Section AS Class,
Studentstbl.RegistrationNumber AS RegistrationNumber
FROM Studentstbl 
JOIN
StudentClasstbl 
ON Studentstbl.Id = StudentClasstbl.StudentId
JOIN Classtbl
ON StudentClasstbl.ClassId = Classtbl.id
WHERE Studentstbl.ActiveStatusId = (SELECT Id 
FROM ActiveStatustbl
Where ActiveStatustbl.Name = 'Active')


Create Procedure ShowClassWiseInActiveStudents @class INT
as
Select 
Studentstbl.FirstName +' '+ Studentstbl.LastName AS Name,
Classtbl.Section AS Class,
Studentstbl.RegistrationNumber AS RegistrationNumber
FROM Studentstbl 
JOIN
StudentClasstbl 
ON Studentstbl.Id = StudentClasstbl.StudentId
JOIN Classtbl
ON StudentClasstbl.ClassId = Classtbl.id
WHERE Studentstbl.ActiveStatusId = 
(SELECT Id 
FROM ActiveStatustbl
Where ActiveStatustbl.Name = 'Inactive')
AND ClassId = @class

exec ShowClassWiseInActiveStudents @class = 9


Create Procedure ShowClassWiseActiveStudents @classid INT
as
Select 
Studentstbl.FirstName +' '+ Studentstbl.LastName AS Name,
Classtbl.Section AS Class,
Studentstbl.RegistrationNumber AS RegistrationNumber
FROM Studentstbl 
JOIN
StudentClasstbl 
ON Studentstbl.Id = StudentClasstbl.StudentId
JOIN Classtbl
ON StudentClasstbl.ClassId = Classtbl.id
WHERE Studentstbl.ActiveStatusId = 
(SELECT Id 
FROM ActiveStatustbl
Where ActiveStatustbl.Name = 'Active')
AND Classtbl.Id = @classid

EXEC ShowClassWiseActiveStudents @classid = 9
/* Report 1*/

Create View Show_Events
AS
SELECT SchoolEventstbl.Title,EventDescription, StartTime, EndTime, Charges
FROM SchoolEventstbl

DROP VIEW Show_Events
select * from Show_Events
/* Report 3 */
Create View School_Students
AS
SELECT Classtbl.Section as ClassName,
Studentstbl.RegistrationNumber, 
Studentstbl.FirstName + ' '+ Studentstbl.LastName AS StudentName
FROM Studentstbl JOIN
StudentClasstbl
ON Studentstbl.Id = StudentClasstbl.StudentId
JOIN Classtbl
ON StudentClasstbl.ClassId = Classtbl.Id


DROP VIEW School_Students
select * FROM School_Students



/* Report 4 */
CREATE PROCEDURE StudentsOfClass @Class nvarchar(30)
AS
SELECT Studentstbl.RegistrationNumber,
Studentstbl.FirstName + ' '+ Studentstbl.LastName AS StudentName,
Studentstbl.CNIC,
Studentstbl.Username
FROM 
Studentstbl 
JOIN StudentClasstbl
ON Studentstbl.Id = StudentClasstbl.StudentId
JOIN Classtbl 
ON Classtbl.Id = StudentClasstbl.ClassId
WHERE Classtbl.Section = @Class
GO

DROP Procedure StudentsOfClass
EXEC StudentsOfClass @Class = "1";


/* Report 6 */
CREATE PROCEDURE SubjectsOfStudent @id INT
AS
SELECT Subjectstbl.Name, Studentstbl.RegistrationNumber
FROM 
Studentstbl 
JOIN StudentClasstbl
ON Studentstbl.Id = StudentClasstbl.StudentId
JOIN ClassSubjecttbl 
ON StudentClasstbl.ClassId = ClassSubjecttbl.ClassId
JOIN Subjectstbl
ON Subjectstbl.Id = ClassSubjecttbl.SubjectId
WHERE Studentstbl.Id = @id
GO

DROP Procedure SubjectsOfStudent;
GO

EXEC SubjectsOfStudent @id = 4;



/* Report 8 */


CREATE PROCEDURE TotalMarksOfEachStudent @id INT
AS
SELECT
Studentstbl.RegistrationNumber,
Classtbl.Section AS ClassName,
str(Sum(Markingstbl.TotalMarks)) as TotalMarks,
str(Sum(Markingstbl.ObtainedMarks)) AS ObtainedMarks
FROM 
Studentstbl 
JOIN Markingstbl
ON Studentstbl.Id = Markingstbl.StudentId
JOIN Classtbl
ON Markingstbl.ClassId = Classtbl.Id
WHERE Studentstbl.Id = @id
Group BY Studentstbl.RegistrationNumber, Classtbl.Section
GO
DROP Procedure TotalMarksOfEachStudent
GO

EXEC TotalMarksOfEachStudent @id = 4



/* Report 10 */


CREATE PROCEDURE TotalMarksOfEachClass @classid INT
AS
SELECT
Studentstbl.RegistrationNumber,
Classtbl.Section AS ClassName,
str(Sum(Markingstbl.TotalMarks)) as TotalMarks,
str(Sum(Markingstbl.ObtainedMarks)) AS ObtainedMarks
FROM 
Studentstbl 
JOIN Markingstbl
ON Studentstbl.Id = Markingstbl.StudentId
JOIN Classtbl
ON Markingstbl.ClassId = Classtbl.Id
WHERE Classtbl.Id = @classid
Group BY Studentstbl.RegistrationNumber, Classtbl.Section
GO
DROP PROCEDURE TotalMarksOfEachClass

EXEC TotalMarksOfEachClass @classid = 9

CREATE PROCEDURE TotalMarksOfAllClasses
AS
SELECT
Studentstbl.RegistrationNumber,
Classtbl.Section AS ClassName,
str(Sum(Markingstbl.TotalMarks)) as TotalMarks,
str(Sum(Markingstbl.ObtainedMarks)) AS ObtainedMarks
FROM 
Studentstbl 
JOIN Markingstbl
ON Studentstbl.Id = Markingstbl.StudentId
JOIN Classtbl
ON Markingstbl.ClassId = Classtbl.Id
Group BY Studentstbl.RegistrationNumber, Classtbl.Section

/* Report 11 */

CREATE PROCEDURE TermWiseMarksOfEachStudent @id INT, @termid INT
AS
SELECT
Studentstbl.RegistrationNumber,
Classtbl.Section AS ClassName,
Termstbl.Name as TermName,
str(Sum(Markingstbl.TotalMarks)) as TotalMarks,
str(Sum(Markingstbl.ObtainedMarks)) AS ObtainedMarks
FROM 
Studentstbl 
JOIN Markingstbl
ON Studentstbl.Id = Markingstbl.StudentId
JOIN Classtbl
ON Markingstbl.ClassId = Classtbl.Id
JOIN Termstbl
ON Markingstbl.TermId = Termstbl.Id
WHERE Studentstbl.Id = @id AND Markingstbl.TermId = @termid
Group BY Studentstbl.RegistrationNumber, Classtbl.Section, Termstbl.Name
GO

drop procedure TermWiseMarksOfEachStudent

EXEC TermWiseMarksOfEachStudent @id = 4,@termid = 1

CREATE PROCEDURE AllTermMarksOfEachStudent @id INT
AS
SELECT
Studentstbl.RegistrationNumber,
Classtbl.Section AS ClassName,
Termstbl.Name as TermName,
str(Sum(Markingstbl.TotalMarks)) as TotalMarks,
str(Sum(Markingstbl.ObtainedMarks)) AS ObtainedMarks
FROM 
Studentstbl 
JOIN Markingstbl
ON Studentstbl.Id = Markingstbl.StudentId
JOIN Classtbl
ON Markingstbl.ClassId = Classtbl.Id
JOIN Termstbl
ON Markingstbl.TermId = Termstbl.Id
WHERE Studentstbl.Id = @id 
Group BY Studentstbl.RegistrationNumber, Classtbl.Section, Termstbl.Name
GO


/*Report 12*/

CREATE PROCEDURE TermWiseMarksOfAClass @classid INT, @termid INT
AS
SELECT
Studentstbl.RegistrationNumber,
Classtbl.Section AS ClassName,
Termstbl.Name as TermName,
str(Sum(Markingstbl.TotalMarks)) as TotalMarks,
str(Sum(Markingstbl.ObtainedMarks)) AS ObtainedMarks
FROM 
Studentstbl 
JOIN Markingstbl
ON Studentstbl.Id = Markingstbl.StudentId
JOIN Classtbl
ON Markingstbl.ClassId = Classtbl.Id
JOIN Termstbl
ON Markingstbl.TermId = Termstbl.Id
WHERE Classtbl.Id = @classid AND Markingstbl.TermId = @termid
Group BY Studentstbl.RegistrationNumber, Classtbl.Section, Termstbl.Name
GO


drop procedure TermWiseMarksOfAClass
EXEC TermWiseMarksOfAClass @classid = 9,@termid = 1
CREATE PROCEDURE AllTermMarksOfAClass @classid INT
AS
SELECT
Studentstbl.RegistrationNumber,
Classtbl.Section AS ClassName,
Termstbl.Name as TermName,
str(Sum(Markingstbl.TotalMarks)) as TotalMarks,
str(Sum(Markingstbl.ObtainedMarks)) AS ObtainedMarks
FROM 
Studentstbl 
JOIN Markingstbl
ON Studentstbl.Id = Markingstbl.StudentId
JOIN Classtbl
ON Markingstbl.ClassId = Classtbl.Id
JOIN Termstbl
ON Markingstbl.TermId = Termstbl.Id
WHERE Classtbl.Id = @classid
Group BY Studentstbl.RegistrationNumber, Classtbl.Section, Termstbl.Name
GO

DROP PROCEDURE AllTermMarksOfAClass
/* Report 13 */

Create Procedure TimeTableForEachClass @classid INT
AS
SELECT 
TimeTabletbl.WeeksDay AS WeekDayName,
Classtbl.Section as ClassName,
Subjectstbl.Name as SubjectName,
TimeTabletbl.LectureTime
FROM 
TimeTabletbl 
JOIN Classtbl
ON TimeTabletbl.ClassId = Classtbl.Id
JOIN Subjectstbl
ON TimeTabletbl.SubjectId = Subjectstbl.Id
Where TimeTabletbl.ClassId = @classid


DROP Procedure TimeTableForEachClass

exec TimeTableForEachClass @classid = 9


/* Report 14 */


CREATE PROCEDURE AverageOfSchool
AS
SELECT
Classtbl.Section AS ClassName,
str((Sum(Markingstbl.ObtainedMarks)/Sum(Markingstbl.TotalMarks))*100) AS AverageOfClass
FROM 
Studentstbl 
JOIN Markingstbl
ON Studentstbl.Id = Markingstbl.StudentId
JOIN Classtbl
ON Markingstbl.ClassId = Classtbl.Id
Group BY Classtbl.Section
GO

DROP PROCEDURE AverageOfSchool
EXEC AverageOfSchool


/* Report 15 */
Create Procedure AttendanceofEachStudent @studentid INT
AS
SELECT 
Studentstbl.RegistrationNumber, 
Studentstbl.FirstName + ' '+ Studentstbl.LastName AS StudentName,
AttendanceStatustbl.Name as Attendance_Status,
AttendanceMarkingtbl.AttendanceDate AS AttendanceDate
FROM Studentstbl JOIN
AttendanceMarkingtbl
ON Studentstbl.Id = AttendanceMarkingtbl.StudentId
JOIN AttendanceStatustbl
ON AttendanceStatustbl.Id = AttendanceMarkingtbl.AttendanceStatusId
Where StudentId = @studentid

DROP PROCEDURE AttendanceofEachStudent
EXEC AttendanceofEachStudent @studentid = 10

/* Report 16 */

Create Procedure AttendanceofWholeClass @Classid INT
AS
SELECT Classtbl.Section AS ClassName, Studentstbl.RegistrationNumber, AttendanceMarkingtbl.AttendanceDate, AttendanceStatustbl.Name AS AttendanceStatus
FROM Studentstbl JOIN
AttendanceMarkingtbl
ON Studentstbl.Id = AttendanceMarkingtbl.StudentId
JOIN AttendanceStatustbl
ON AttendanceStatustbl.Id = AttendanceMarkingtbl.AttendanceStatusId
JOIN StudentClasstbl
ON StudentClasstbl.StudentId = AttendanceMarkingtbl.StudentId
JOIN Classtbl
ON Classtbl.Id = @Classid
ORDER BY AttendanceDate DESC

DROP Procedure AttendanceofWholeClass
EXEC AttendanceofWholeClass @Classid = 9

/*Report 7*/

CREATE PROCEDURE SubjectWiseMarkingForEachStudent @studentId INT
AS
SELECT Studentstbl.FirstName + ' ' + Studentstbl.LastName AS "Student Name", 
Studentstbl.RegistrationNumber AS RegNo, 
Subjectstbl.Name AS SubjectName, 
str(Markingstbl.TotalMarks) as TotalMarks, str(Markingstbl.ObtainedMarks) AS ObtainedMarks,
Termstbl.Name AS TermName
FROM Markingstbl
JOIN Studentstbl
ON Markingstbl.StudentId = Studentstbl.Id
JOIN Subjectstbl
ON Subjectstbl.Id = Markingstbl.SubjectId
JOIN Termstbl 
ON Termstbl.Id = Markingstbl.TermId
WHERE Studentstbl.Id = @studentId
GO

DROP PROCEDURE SubjectWiseMarkingForEachStudent
EXEC SubjectWiseMarkingForEachStudent @studentId = 9
/*Report 9*/

CREATE PROCEDURE SubjectWiseMarksForClass @ClassId INT
AS
SELECT Classtbl.Section AS Class, Studentstbl.FirstName + ' ' + Studentstbl.LastName AS "Student Name", 
Studentstbl.RegistrationNumber AS "Registration Number", 
Subjectstbl.Name AS "Subject Name", 
str(Markingstbl.TotalMarks) AS "Total Marks", 
str(Markingstbl.ObtainedMarks) AS "Obtained Marks",
Termstbl.Name AS TermName
FROM Markingstbl
JOIN Classtbl
ON Markingstbl.ClassId = Classtbl.Id
JOIN Subjectstbl
ON Subjectstbl.Id = Markingstbl.SubjectId
JOIN Studentstbl
ON Studentstbl.Id = Markingstbl.StudentId
JOIN Termstbl
ON Termstbl.Id = Markingstbl.TermId
WHERE Classtbl.Id = @ClassId
GO
DROP PROCEDURE SubjectWiseMarksForClass
EXEC SubjectWiseMarksForClass @ClassId = 9



Create Procedure ShowStudentInfo @studentid INT
as
Select 
Studentstbl.FirstName +' '+ Studentstbl.LastName AS Name,
Studentstbl.RegistrationNumber AS RegistrationNumber,
Studentstbl.Username,
Studentstbl.CNIC
FROM Studentstbl
WHERE Studentstbl.Id = @studentid

EXEC ShowStudentInfo @studentid = 9


DELETE FROM AttendanceMarkingtbl