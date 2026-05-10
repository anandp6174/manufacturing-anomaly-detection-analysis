select * from [dbo].[manutacturing_data]

-------------------------------------------------------ANALYSIS OF MANUFACTUREING MACHINE----------------------------------------------------------------------

--TOTAL MACHINE FAILURES

SELECT COUNT(*) AS Total_Failures
from [dbo].[manutacturing_data]
WHERE Machine_Failure = 1

--FAILURE RATE

SELECT 
(COUNT(CASE WHEN Machine_Failure = 1 THEN 1 END) * 100.0 
/ COUNT(*)) AS Failure_Rate
from [dbo].[manutacturing_data]

--DEFECT PATTERN ANALYSIS BY PRODUCT TYPE

SELECT Type,
COUNT(*) AS Failure_Count
from [dbo].[manutacturing_data]
WHERE Machine_Failure = 1
GROUP BY Type
ORDER BY Failure_Count DESC

--DEFECT PATTERN ANALYSIS BY PRODUCT TYPE

SELECT Type,
COUNT(*) AS Failure_Count
from [dbo].[manutacturing_data]
WHERE Machine_Failure = 1
GROUP BY Type
ORDER BY Failure_Count DESC

--AVERAGE TORQUE ANALYSIS
SELECT AVG(Torque) AS Avg_Torque
from [dbo].[manutacturing_data]

--HIGH TOOL WEAR ANALYSIS
SELECT COUNT(*) AS High_Wear_Failures
from [dbo].[manutacturing_data]
WHERE Tool_Wear > 200
AND Machine_Failure = 1

--TEMPERATURE ANALYSIS
SELECT 
AVG(Process_Temp) AS Avg_Process_Temp,
AVG(Air_Temp) AS Avg_Air_Temp
from [dbo].[manutacturing_data]

---FAILURE TYPE ANALYSIS

SELECT 
SUM(TWF) AS Tool_Wear_Failure,
SUM(HDF) AS Heat_Dissipation_Failure,
SUM(PWF) AS Power_Failure,
SUM(OSF) AS Overstrain_Failure,
SUM(RNF) AS Random_Failure
from [dbo].[manutacturing_data]

--OPERATIONAL PERFORMANCE ANALYSIS
SELECT Type,
AVG(Rotational_Speed) AS Avg_RPM,
AVG(Torque) AS Avg_Torque,
AVG(Process_Temp) AS Avg_Process_Temp
from [dbo].[manutacturing_data]
GROUP BY Type

--ANOMALY IDENTIFICATION
SELECT *
from [dbo].[manutacturing_data]
WHERE Torque > 60
--Extreme torque values may indicate operational stress and anomalies.


--------------------------------------------------------------BUSINESS QUESTIONS?------------------------------------------------------------------------------------

--Q1. Which product type experiences the highest machine failures?
SELECT Type,
COUNT(*) AS Failure_Count
from [dbo].[manutacturing_data]
WHERE Machine_Failure = 1
GROUP BY Type
ORDER BY Failure_Count DESC
--Business Insight:
--Product types with higher failure counts may require process optimization or additional maintenance monitoring.

--Q2. What is the overall machine failure rate?
SELECT 
(COUNT(CASE WHEN Machine_Failure = 1 THEN 1 END) * 100.0 
/ COUNT(*)) AS Failure_Rate
from [dbo].[manutacturing_data]
--Business Insight:
--A higher failure rate indicates lower operational reliability and increased maintenance requirements.

--Q3. Which machines operate under high torque conditions?
SELECT Product_ID,
Torque
from [dbo].[manutacturing_data]
WHERE Torque > 60
ORDER BY Torque DESC
--Business Insight:
--Extreme torque conditions may indicate operational stress and potential machine instability.

--Q4. Which product category has the highest average tool wear?
SELECT Type,
AVG(Tool_Wear) AS Avg_Tool_Wear
from [dbo].[manutacturing_data]
GROUP BY Type
ORDER BY Avg_Tool_Wear DESC
--Business Insight:
--High tool wear categories may require more frequent maintenance schedules.

--Q5. How does temperature affect machine failures?
SELECT Machine_Failure,
AVG(Process_Temp) AS Avg_Process_Temp
from [dbo].[manutacturing_data]
GROUP BY Machine_Failure
--Business Insight:
--Machines operating at higher process temperatures are more likely to experience failures

--Q6. Which failure type occurs most frequently?
SELECT 
SUM(TWF) AS Tool_Wear_Failure,
SUM(HDF) AS Heat_Dissipation_Failure,
SUM(PWF) AS Power_Failure,
SUM(OSF) AS Overstrain_Failure,
SUM(RNF) AS Random_Failure
from [dbo].[manutacturing_data]
--Business Insight:
--Identifying dominant failure categories helps prioritize maintenance strategies.

--Q7. Which operational conditions contribute to failures?
SELECT 
AVG(Rotational_Speed) AS Avg_RPM,
AVG(Torque) AS Avg_Torque,
AVG(Process_Temp) AS Avg_Process_Temp
from [dbo].[manutacturing_data]
WHERE Machine_Failure = 1
--Business Insight:
--Understanding operational conditions associated with failures supports predictive maintenance planning.

--Q8. Which machines have excessive tool wear and failures?
SELECT Product_ID,
Tool_Wear,
Machine_Failure
from [dbo].[manutacturing_data]
WHERE Tool_Wear > 200
AND Machine_Failure = 1
--Business Insight:
--Machines operating with excessive tool wear show higher failure probability and reduced reliability.


