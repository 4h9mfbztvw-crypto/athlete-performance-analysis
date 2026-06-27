SELECT TOP 10 *
FROM AthleteData;

--Question 1--
--Which fatigue category has the highest average ACL risk?--
WITH FatigueCategories AS (
    SELECT
		ACL_Risk_Score,
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
		AVG(ACL_Risk_Score) AS AVG_ACLRiskScore
FROM FatigueCategories
GROUP BY FatigueLevel
ORDER BY AVG(ACL_Risk_Score) DESC;

--Question 2--
--Which training intensity has the highest injury rate?--
SELECT
    Training_Intensity,
    COUNT(*) AS TotalAthletes,
    COUNT(CASE WHEN Injury_Indicator = 1 THEN 1 END) AS InjuredAthletes,
    COUNT(CASE WHEN Injury_Indicator = 1 THEN 1 END) * 100.0 / COUNT(*) AS InjuryRate
FROM AthleteData
GROUP BY Training_Intensity
ORDER BY InjuryRate DESC;

--Question 3--
--Find training intensities where average performance is above the overall average performance.--
SELECT
    Training_Intensity,
    AVG(Performance_Score) AS AVGPerformance
FROM AthleteData
GROUP BY Training_Intensity
HAVING AVG(Performance_Score) >= (SELECT AVG(Performance_Score) FROM AthleteData);

--Question 4--
--Which athletes perform above the average for their gender?--
WITH GenderAverages AS (
    SELECT 
        Gender, 
        AVG(Performance_Score) AS AvgPerformance
    FROM AthleteData
    GROUP BY Gender
)

SELECT 
    ad.Athlete_ID,
    ad.Gender,
    ad.Performance_Score,
    ga.AvgPerformance
FROM AthleteData ad
JOIN GenderAverages ga
    ON ad.Gender = ga.Gender
WHERE ad.Performance_Score >= ga.AvgPerformance;

