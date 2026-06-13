Select TOP 10*
FROM AthleteData;

--Question 1--
--How many athletes are in the dataset?--
SELECT COUNT(Athlete_ID) As Athlete Count
FROM AthleteData;

--Question 2--
--What is the average Performance Score across all athletes?--
SELECT	AVG(Performance_Score) AS AVGPerformance
FROM AthleteData;

--Question 3--
--How many athletes have a Fatigue Score greater than 80?--
SELECT COUNT(Athlete_ID) 
FROM AthleteData
WHERE Fatigue_Score >80;

--Question 4--
--Show the 5 athletes with the highest Performance Score.--
SELECT TOP 5
    Athlete_ID,
    Performance_Score
FROM AthleteData
ORDER BY Performance_Score DESC;

--Question 5--
SELECT DISTINCT Training_Intensity
FROM AthleteData;

--Question 6--
--How many athletes belong to each Gender?--
SELECT
    Gender,
    COUNT(*) AS Total
FROM AthleteData
GROUP BY Gender;

--Question 7--
-- Which Training Intensity has the highest average Fatigue Score?--
SELECT
		Training_Intensity,
		AVG(Fatigue_score)	AS AVGFatigueScore
FROM AthleteData
GROUP BY Training_Intensity
ORDER BY AVG(Fatigue_score)	DESC;

--Question 8--
--Find all athletes who: Have Fatigue Score > 75 AND Performance Score < 50 - How many are there?--
SELECT 
		COUNT(Athlete_ID) 
FROM AthleteData
WHERE Fatigue_Score >7
	AND Performance_Score <5;

--Question 9--
--What is the average ACL Risk Score by Gender?--

SELECT 
		GENDER,
		AVG(ACL_Risk_Score) AS AVG_ACL_Risk
FROM AthleteData
GROUP BY Gender;

--Question 10--
--Count how many athletes fall into each category. / fatigue level = High - 8, Medium 5-7, Low >5--
WITH FatigueCategories AS (
    SELECT
        Athlete_ID,
        CASE
            WHEN Fatigue_Score >= 8 THEN 'High'
            WHEN Fatigue_Score >= 5 THEN 'Medium'
            ELSE 'Low'
        END AS FatigueLevel
    FROM AthleteData
)
SELECT 
		FatigueLevel,
		COUNT(Athlete_ID) AS Athelete_count
FROM FatigueCategories
GROUP BY FatigueLevel;


--Questoion 11--
--Create 1 summary table showing - training intensity, number of atheltes, avg performance, avg fatigue, avg fatigue, avg acl risk--
SELECT 
		Training_Intensity,
		COUNT(Athlete_ID) AS Numb_of_atheltes,
		AVG(Performance_Score) AS AVGPerformance_Score,
		AVG(Fatigue_Score) AS AVGFatigue_Score,
		AVG(ACL_Risk_Score) AS AVGACL_Risk_Score
FROM AthleteData
GROUP BY Training_Intensity
ORDER BY AVG(Performance_Score) DESC;