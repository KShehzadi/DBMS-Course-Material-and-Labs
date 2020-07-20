/* Activity 1 */
/* Task 3 */
SELECT *
  FROM [lab2].[dbo].[Student]
/* Task 4 */
SELECT TOP 5 [RegNo]
      ,[FirstName]
      ,[LastName]
      ,[GPA]
  FROM [lab2].[dbo].[Student]

SELECT TOP 5
      [FirstName]
    
      ,[GPA]
  FROM [lab2].[dbo].[Student]
/* Task 5 */
SELECT [RegNo]
      ,[FirstName]
      ,[LastName]
      ,[GPA]
  FROM [lab2].[dbo].[Student] WHERE GPA>=3.5
SELECT [RegNo]
      ,[FirstName]
      ,[LastName]
      ,[GPA]
  FROM [lab2].[dbo].[Student] WHERE GPA<3.5
/* Task 7 */
SELECT [FirstName]+ ' ' +[LastName]
  FROM [lab2].[dbo].[Student]