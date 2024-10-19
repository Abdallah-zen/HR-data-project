SELECT * 
FROM project.absence a
LEFT JOIN project.compensation c ON a.id = c.id
LEFT JOIN project.Reasons r ON a.`Reason for absence` = r.number
LEFT JOIN project.info i ON a.id = i.id;

-- AVG Absenteeism (6.924)
Select AVG(`Absenteeism time in hours`) as Avg_absenteeism
 from project.absence


-- 111 Employees have absence rates lower than the average absence rate for all employees.
SELECT * 
From project.absence
where `Social smoker` = 0 and `Social drinker` = 0 and `Body mass index`<25
 and `Absenteeism time in hours` < (Select AVG(`Absenteeism time in hours`) from project.absence)

SELECT COUNT(*) AS Total_Count
FROM project.absence
WHERE `Social smoker` = 0 
  AND `Social drinker` = 0 
  AND `Body mass index` < 25
  AND `Absenteeism time in hours` < (
    SELECT AVG(`Absenteeism time in hours`) 
    FROM project.absence
  );

--- Num of (Smoker - Non Smoker)
SELECT 
    COUNT(*) AS Non_Smoker, 
    (SELECT COUNT(*) FROM project.absence WHERE `Social smoker` = 1) AS Smoker
FROM project.absence
WHERE `Social smoker` = 0;

--- Num of (Smoker & Drinker)
SELECT 
    COUNT(*) AS Non_Smoker_Non_Drinker, 
    (SELECT COUNT(*) FROM project.absence WHERE `Social smoker` = 1 AND `Social drinker` = 1) AS Smoker_Drinker
FROM project.absence
WHERE `Social smoker` = 0 AND `Social drinker` = 0;

--- Months have high absenteeism	
SELECT `Month of absence`, SUM(`Absenteeism time in hours`) AS Total_Absenteeism
FROM project.absence
GROUP BY `Month of absence`
ORDER BY Total_Absenteeism desc

--- Count of Absenteeism
SELECT r.Reason, COUNT(*) AS Absence_Count
FROM project.absence a
JOIN project.Reasons r ON a.`Reason for absence` = r.Number
GROUP BY r.reason
ORDER BY Absence_Count DESC;

--- Num OF each Category
SELECT 
    CASE 
        WHEN `Body mass index` < 18.5 THEN 'Underweight'
        WHEN `Body mass index` BETWEEN 18.5 AND 25 THEN 'Healthy Weight'
        WHEN `Body mass index` BETWEEN 25 AND 30 THEN 'Overweight'
        ELSE 'Obese'
    END AS BMI_Category, 
    COUNT(*) AS Count
FROM project.absence
GROUP BY BMI_Category;



Select 
a.ID,
i.name,
i.Gender,
i.Education,
r.Reason,
Case	When `Body mass index` < 18.5 Then 'Underweight'
		When `Body mass index` between 18.5 and 25 Then 'Healthy Weight'
		When `Body mass index` between 25 and 30 Then 'Over Weight'
		Else 'Obese' End as BMI_Category,		

Case	When `Month of absence` IN (12, 1, 2) Then 'Winter'
		When `Month of absence` IN (3, 4, 5) Then 'Spring'
		When `Month of absence` IN (6, 7, 8) Then 'Summer'
		When `Month of absence` IN (9, 10, 11) Then 'autumn'
		Else 'Unknow' End as Season_Names,
        `Month of absence`,
`Day of the week`,
`Transportation expense`,
Son,
Case 
        When `Social drinker` = 1 Then 'Yes'
        Else 'No' 
    End as Social_drinker,
Case 
        When `Social smoker` = 1 Then 'Yes'
        Else 'No' 
    End as Social_smoker,
Pet,
`Disciplinary failure`,
Age,
`Work load Average/day`,
`Hit target`,
`Distance from Residence to Work`,
`Absenteeism time in hours`
From project.absence a
LEFT JOIN project.compensation c ON a.id = c.id
LEFT JOIN project.Reasons r ON a.`Reason for absence` = r.number
LEFT JOIN project.info i ON a.id = i.id;







