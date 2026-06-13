SELECT TOP 10 *
FROM Athletedata;

--Question 1--
--Which Training Intensity has the highest average performance score?--
SELECT 
		Training_Intensity,
		AVG(Performance_Score) AS AVGPerformance_Score
FROM Athletedata
GROUP BY Training_Intensity
ORDER BY AVG(Performance_Score) DESC; 

--Question 2--
--Find the top 10 athletes with the highest ACL risk--
SELECT TOP 10 Athlete_ID, ACL_Risk_Score   
FROM Athletedata
ORDER BY ACL_Risk_Score DESC;  

--Question 3--
--What is the average heartbeat by Gender?--
SELECT 
		Gender,
		AVG(heartbeat) AS AVGHeartBeat
FROM Athletedata
GROUP BY Gender;

--Question 4--
--Which Gender has the highest average fatigue score?--
SELECT 
		Gender,
		AVG(Fatigue_Score)
FROM Athletedata
GROUP BY Gender
ORDER BY AvgFatigue DESC;

--Question 5--
--Create a Performance Category--
WITH PerformanceCategory AS (
	SELECT Athlete_ID,
		CASE	
			WHEN Performance_Score >= 8 THEN 'Elite'
			WHEN Performance_Score >= 7 THEN 'Good'
			ELSE 'Average'
		END AS PerformanceLevel
FROM Athletedata
)
SELECT 
		PerformanceLevel,
		COUNT(Athlete_ID) AS Athlete_Count
FROM PerformanceCategory
GROUP BY PerformanceLevel
ORDER BY COUNT(Athlete_ID) DESC;

--Question 6--
--Create an Injury High Risk Category--
WITH InjuryHighRiskCategory AS (
	SELECT Athlete_ID,
		CASE 
			WHEN ACL_Risk_Score >= 7 THEN 'High Risk'
			WHEN ACL_Risk_Score >= 6 THEN 'Medium'
			ELSE 'Low Risk'
		END AS ACLRisk
	FROM Athletedata
)

SELECT 
		ACLRisk,
		COUNT(Athlete_ID) AS Athlete_Count
FROM InjuryHighRiskCategory
GROUP BY ACLRisk
ORDER BY COUNT(Athlete_ID) DESC;

--Question 7--
--Create a Training Intensity--
SELECT
    Training_Intensity,
    COUNT(
        CASE
            WHEN Injury_Indicator = 1	THEN 1
        END
    ) AS InjuredAthletes,

    COUNT(
        CASE
            WHEN  Injury_Indicator = 0	THEN 1
        END
    ) AS NonInjuredAthletes
FROM AthleteData
GROUP BY Training_Intensity;

--Question 8--
--Show only Training Intensities whose average fatigue score is greater or equal to 5--
SELECT 
		Training_Intensity,
		AVG(Fatigue_Score) AS AVGFatigueScore
FROM AthleteData
GROUP BY Training_Intensity
HAVING AVG(Fatigue_Score) >= 5
ORDER BY AVG(Fatigue_Score) DESC;

--Question 9--
--Show Genders with more than 200 athletes--

SELECT
		Gender,
		COUNT(Athlete_ID) AS Athlete_Count
FROM AthleteData
GROUP BY Gender
HAVING COUNT(Athlete_ID) > 200;

--Question 10--
--Calculate the avg performance for each fatigue level category--
WITH FatigueCategories AS (
    SELECT
		Performance_Score,
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
		AVG(Performance_Score) AS AVGPerformance
FROM FatigueCategories
GROUP BY FatigueLevel;
	
--Question 11--
--count athletes in each fatigue level--
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
		COUNT(Athlete_ID) AS Athelete_Count
FROM FatigueCategories
GROUP BY FatigueLevel
ORDER BY COUNT(Athlete_ID) DESC;



	