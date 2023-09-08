USE RESEARCH

DECLARE @Columns NVARCHAR(MAX) = ''
DECLARE @Query NVARCHAR(MAX) = '' 
DECLARE @AggType NVARCHAR(MAX) = ''
DECLARE @ValueType NVARCHAR(MAX) = '' 
DECLARE @TableName NVARCHAR(MAX) = ''
DECLARE @QueryDrop NVARCHAR(MAX) = ''
DECLARE @QueryInsert NVARCHAR(MAX) = ''
DECLARE @Version NVARCHAR(MAX) = ''
DECLARE @ColNumber NVARCHAR(MAX) = ''

---------------------------------------------------------------
--Selection to compare ORG (10, 20, 30), IDEATION(180, 215) and FE-GEN (like 180)  
--------------------------------------------------------------

----------------------------------------------------------------
--Pivot för DECIMAL (MAX) for all 
----------------------------------------------------------------
SELECT   @Columns +=   QUOTENAME(CONCEPT_ID)+ ','
FROM RESEARCH_CONCEPT AS COL
WHERE VOCABULARY_ID = 'S10' AND DECIMAL_EXISTS = 1
--AND (CONCEPT_ID LIKE '%180%' OR CONCEPT_ID LIKE '%215%' OR CONCEPT_ID IN ('180', '215','20', '10', '30') ) 

SET @Columns = LEFT(@Columns, LEN(@Columns)-1)
SET @Version = 'V2'

SET @AggType='MAX'
SET @ValueType='DECIMAL'
SET @TableName ='RESEARCH.DBO.S10_PIVOT_'+@AggType+'_'+@ValueType
PRINT 'Tabellnamn: '+@TableName

SET @QueryDrop = 'DROP TABLE '+@TableName
print 'SQL för drop av tabell: '+@QueryDrop

IF OBJECT_ID (@TableName) IS NOT NULL
EXECUTE sp_executesql @QueryDrop;


SET @Query =
--'SELECT  * INTO RESEARCH.DBO.S10_PIVOT_MAX_DECIMAL_V2 FROM
'SELECT  * INTO '+@TableName+' FROM
(SELECT 
	PATIENT_ID,
	CONCEPT_ID,
	VALUE_DECIMAL
FROM S10_F_OBSERVATION
WHERE VALUE_DECIMAL is not null
)
AS OBS
PIVOT(
	MAX(VALUE_DECIMAL)
	FOR CONCEPT_ID IN (' + @Columns +')
) AS OBSPivotTable'

PRINT 'Aggregationstyp: '+@AggType
PRINT 'Typ av värde: '+@ValueType
PRINT 'Kolumner som pivoterats: '+@Columns
PRINT 'Textlängd på alla kolumner: '
PRINT LEN(@Columns)
PRINT 'SQL för pivotshift: '+@Query

EXECUTE sp_executesql @Query

SET @ColNumber = (SELECT COUNT(*)   FROM INFORMATION_SCHEMA.COLUMNS WHERE table_catalog = 'RESEARCH' AND TABLE_NAME = 'S10_PIVOT_MAX_DECIMAL' )
PRINT @ColNumber

----------------------------------------------------------------
--Pivot för CHAR (COUNT) code starting with W
----------------------------------------------------------------
SELECT  @Columns +=   QUOTENAME(CONCEPT_ID)+ ','
FROM RESEARCH_CONCEPT AS COL
WHERE VOCABULARY_ID = 'S10' AND CHAR_EXISTS = 1

SET @Columns = LEFT(@Columns, LEN(@Columns)-1)
SET @Version = 'V2'

SET @AggType='COUNT'
SET @ValueType='CHAR_W'
SET @TableName ='RESEARCH.DBO.S10_PIVOT_'+@AggType+'_'+@ValueType
PRINT @TableName

SET @QueryDrop = 'DROP TABLE '+@TableName
print @QueryDrop

IF OBJECT_ID (@TableName) IS NOT NULL
EXECUTE sp_executesql @QueryDrop;


PRINT @TableName

SET @Query =
'SELECT  * INTO RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_W FROM
(SELECT 
	PATIENT_ID,
	CONCEPT_ID,
	SUBSTRING (VALUE_CHAR,1,1) AS CODE
FROM S10_F_OBSERVATION
WHERE SUBSTRING (VALUE_CHAR,1,1) = ''W''
)
AS OBS
PIVOT(
	COUNT(CONCEPT_ID)
	FOR CONCEPT_ID in (' + @Columns +')
) AS OBSPivotTable'

PRINT @AggType
PRINT @ValueType
PRINT @Columns
PRINT LEN(@Columns) --4870=maxlength ? TOP100 gives 3118 chars
PRINT @Query

EXECUTE sp_executesql @Query

SET @ColNumber = (SELECT COUNT(*)   FROM INFORMATION_SCHEMA.COLUMNS WHERE table_catalog = 'RESEARCH' AND TABLE_NAME = 'S10_PIVOT_COUNT_CHAR_W' )
PRINT @ColNumber

----------------------------------------------------------------
--Pivot för CHAR (COUNT) code starting with S
----------------------------------------------------------------
SELECT   @Columns +=   QUOTENAME(CONCEPT_ID)+ ','
FROM RESEARCH_CONCEPT AS COL
WHERE VOCABULARY_ID = 'S10' AND CHAR_EXISTS = 1

SET @Columns = LEFT(@Columns, LEN(@Columns)-1)
SET @Version = 'V2'

SET @AggType='COUNT'
SET @ValueType='CHAR_S'
SET @TableName ='RESEARCH.DBO.S10_PIVOT_'+@AggType+'_'+@ValueType
PRINT @TableName

SET @QueryDrop = 'DROP TABLE '+@TableName
print @QueryDrop

IF OBJECT_ID (@TableName) IS NOT NULL
EXECUTE sp_executesql @QueryDrop;


PRINT @TableName

SET @Query =
'SELECT  * INTO RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_S FROM
(SELECT 
	PATIENT_ID,
	CONCEPT_ID,
	SUBSTRING (VALUE_CHAR,1,1) AS CODE
FROM S10_F_OBSERVATION
WHERE  SUBSTRING (VALUE_CHAR,1,1) = ''S''
)
AS OBS
PIVOT(
	COUNT(CONCEPT_ID)
	FOR CONCEPT_ID in (' + @Columns +')
) AS OBSPivotTable'

PRINT @AggType
PRINT @ValueType
PRINT @Columns
PRINT LEN(@Columns) --4870=maxlength ? TOP100 gives 3118 chars
PRINT @Query

EXECUTE sp_executesql @Query

SET @ColNumber = (SELECT COUNT(*)   FROM INFORMATION_SCHEMA.COLUMNS WHERE table_catalog = 'RESEARCH' AND TABLE_NAME = 'S10_PIVOT_COUNT_CHAR_S' )
PRINT @ColNumber

----------------------------------------------------------------
--Pivot för CHAR (COUNT) code starting with M
----------------------------------------------------------------
SELECT   @Columns +=   QUOTENAME(CONCEPT_ID)+ ','
FROM RESEARCH_CONCEPT AS COL
WHERE VOCABULARY_ID = 'S10' AND CHAR_EXISTS = 1

SET @Columns = LEFT(@Columns, LEN(@Columns)-1)
SET @Version = 'V2'

SET @AggType='COUNT'
SET @ValueType='CHAR_M'
SET @TableName ='RESEARCH.DBO.S10_PIVOT_'+@AggType+'_'+@ValueType
PRINT @TableName

SET @QueryDrop = 'DROP TABLE '+@TableName
print @QueryDrop

IF OBJECT_ID (@TableName) IS NOT NULL
EXECUTE sp_executesql @QueryDrop;


PRINT @TableName

SET @Query =
'SELECT  * INTO RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_M FROM
(SELECT 
	PATIENT_ID,
	CONCEPT_ID,
	SUBSTRING (VALUE_CHAR,1,1) AS CODE
FROM S10_F_OBSERVATION
WHERE  SUBSTRING (VALUE_CHAR,1,1) = ''M''
)
AS OBS
PIVOT(
	COUNT(CONCEPT_ID)
	FOR CONCEPT_ID in (' + @Columns +')
) AS OBSPivotTable'

PRINT @AggType
PRINT @ValueType
PRINT @Columns
PRINT LEN(@Columns) --4870=maxlength ? TOP100 gives 3118 chars
PRINT @Query

EXECUTE sp_executesql @Query

SET @ColNumber = (SELECT COUNT(*)   FROM INFORMATION_SCHEMA.COLUMNS WHERE table_catalog = 'RESEARCH' AND TABLE_NAME = 'S10_PIVOT_COUNT_CHAR_M' )
PRINT @ColNumber
----------------------------------------------------------------
--Pivot för CHAR (COUNT) code starting with E
----------------------------------------------------------------
SELECT @Columns +=   QUOTENAME(CONCEPT_ID)+ ','
FROM RESEARCH_CONCEPT AS COL
WHERE VOCABULARY_ID = 'S10' AND CHAR_EXISTS = 1

SET @Columns = LEFT(@Columns, LEN(@Columns)-1)
SET @Version = 'V2'


SET @AggType='COUNT'
SET @ValueType='CHAR_E'
SET @TableName ='RESEARCH.DBO.S10_PIVOT_'+@AggType+'_'+@ValueType
PRINT @TableName

SET @QueryDrop = 'DROP TABLE '+@TableName
print @QueryDrop

IF OBJECT_ID (@TableName) IS NOT NULL
EXECUTE sp_executesql @QueryDrop;


PRINT @TableName

SET @Query =
'SELECT  * INTO RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_E FROM
(SELECT 
	PATIENT_ID,
	CONCEPT_ID,
	SUBSTRING (VALUE_CHAR,1,1) AS CODE
FROM S10_F_OBSERVATION
WHERE  SUBSTRING (VALUE_CHAR,1,1) = ''E''
)
AS OBS
PIVOT(
	COUNT(CONCEPT_ID)
	FOR CONCEPT_ID in (' + @Columns +')
) AS OBSPivotTable'

PRINT @AggType
PRINT @ValueType
PRINT @Columns
PRINT LEN(@Columns) --4870=maxlength ? TOP100 gives 3118 chars
PRINT @Query

EXECUTE sp_executesql @Query

SET @ColNumber = (SELECT COUNT(*)   FROM INFORMATION_SCHEMA.COLUMNS WHERE table_catalog = 'RESEARCH' AND TABLE_NAME = 'S10_PIVOT_COUNT_CHAR_E' )
PRINT @ColNumber

----------------------------------------------------------------
--Pivot för CHAR (COUNT) ORG-concept_id => (10,30)
----------------------------------------------------------------
SELECT @Columns +=   QUOTENAME(CONCEPT_ID)+ ','
FROM RESEARCH_CONCEPT AS COL
WHERE VOCABULARY_ID = 'S10' AND CHAR_EXISTS = 1

SET @Columns = LEFT(@Columns, LEN(@Columns)-1)
SET @Version = 'V2'

SET @AggType='COUNT'
SET @ValueType='CHAR_ORG'
SET @TableName ='RESEARCH.DBO.S10_PIVOT_'+@AggType+'_'+@ValueType
PRINT @TableName

SET @QueryDrop = 'DROP TABLE '+@TableName
print @QueryDrop

IF OBJECT_ID (@TableName) IS NOT NULL
EXECUTE sp_executesql @QueryDrop;


PRINT @TableName

SET @Query =
'SELECT  * INTO RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_ORG FROM
(SELECT 
	PATIENT_ID,
	CONCEPT_ID,
	VALUE_CHAR AS VALUE
FROM S10_F_OBSERVATION
WHERE  CONCEPT_ID IN (''30'') 
)
AS OBS
PIVOT(
	COUNT(CONCEPT_ID)
	FOR CONCEPT_ID in (' + @Columns +')
) AS OBSPivotTable'

PRINT @AggType
PRINT @ValueType
PRINT @Columns
PRINT LEN(@Columns) --4870=maxlength ? TOP100 gives 3118 chars
PRINT @Query

EXECUTE sp_executesql @Query

SET @ColNumber = (SELECT COUNT(*)   FROM INFORMATION_SCHEMA.COLUMNS WHERE table_catalog = 'RESEARCH' AND TABLE_NAME = 'S10_PIVOT_COUNT_CHAR_ORG' )
PRINT @ColNumber

----------------------------------------------------------------
--Output
---------------------------------------------------------------
--SELECT top 100  *, PATIENT_ID,CODE, CONCEPT, CONCEPT_ID_VALUE,[180], [20], [215]  FROM  RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_W order by 1,2
--SELECT top 100   PATIENT_ID,CODE, CONCEPT, CONCEPT_ID_VALUE,[180], [20], [215] FROM  RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_E order by 1,2
--SELECT top 100   PATIENT_ID,CODE, CONCEPT, CONCEPT_ID_VALUE,[180], [20], [215] FROM  RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_M order by 1,2
--SELECT top 100   PATIENT_ID,CODE, CONCEPT, CONCEPT_ID_VALUE,[180], [20], [215] FROM  RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_S order by 1,2
--SELECT top 100   PATIENT_ID,CODE, CONCEPT, CONCEPT_ID_VALUE,[180], [20], [215] FROM  RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_ORG order by 1,2
--SELECT top 1000  * FROM RESEARCH.DBO.S10_PIVOT_MAX_DECIMAL

ALTER TABLE RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_E DROP COLUMN CODE
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_E.[PATIENT_ID]', 'PATIENT_ID-E', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_E.[10]', '10-E', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_E.[20]', '20-E', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_E.[30]', '30-E', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_E.[180]', '180-E', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_E.[215]', '215-E', 'COLUMN'
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_E.[320]', '320-E', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_E.[350]', '350-E', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_E.[400]', '400-E', 'COLUMN' 

ALTER TABLE RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_M DROP COLUMN CODE
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_M.[PATIENT_ID]', 'PATIENT_ID-M', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_M.[10]', '10-M', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_M.[20]', '20-M', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_M.[30]', '30-M', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_M.[180]', '180-M', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_M.[215]', '215-M', 'COLUMN'
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_M.[320]', '320-M', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_M.[350]', '350-M', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_M.[400]', '400-M', 'COLUMN'

ALTER TABLE RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_S DROP COLUMN CODE
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_S.[PATIENT_ID]', 'PATIENT_ID-S', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_S.[10]', '10-S', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_S.[20]', '20-S', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_S.[30]', '30-S', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_S.[180]', '180-S', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_S.[215]', '215-S', 'COLUMN'
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_S.[320]', '320-S', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_S.[350]', '350-S', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_S.[400]', '400-S', 'COLUMN'

ALTER TABLE RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_W DROP COLUMN CODE
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_W.[PATIENT_ID]', 'PATIENT_ID-W', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_W.[10]', '10-W', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_W.[20]', '20-W', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_W.[30]', '30-W', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_W.[180]', '180-W', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_W.[215]', '215-W', 'COLUMN'
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_W.[320]', '320-W', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_W.[350]', '350-W', 'COLUMN' 
EXEC sp_rename 'RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_W.[400]', '400-W', 'COLUMN' 
---------------------------------------------------------------
-----Final datasets for ML-pipeline (unique PATIENT_ID)
---------------------------------------------------------------

SELECT P.PK, P.OSTEOPOROSIS_FRACTURE_LKL AS Y1 ,D.*, E.*, M.*, S.*, W.* INTO RESEARCH..S14_TOTAL_DATASET_V2 
FROM RESEARCH.DBO.S10_PIVOT_MAX_DECIMAL AS D
LEFT OUTER JOIN RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_E AS E ON D.PATIENT_ID = E.[PATIENT_ID-E]
LEFT OUTER JOIN RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_M AS M ON D.PATIENT_ID = M.[PATIENT_ID-M]
LEFT OUTER JOIN RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_S AS S ON D.PATIENT_ID = S.[PATIENT_ID-S]
LEFT OUTER JOIN RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_W AS W ON D.PATIENT_ID = W.[PATIENT_ID-W] 
INNER JOIN  [DW_STG].[dbo].[RESEARCH_S1_PATIENT_AED] AS P ON  D.PATIENT_ID = P.PATIENT_ID

ALTER TABLE RESEARCH.DBO.S14_TOTAL_DATASET_V2 DROP COLUMN PATIENT_ID
--EXEC sp_rename 'RESEARCH.DBO.S14_TOTAL_DATASET_V2.[PK]', 'PATIENT_ID', 'COLUMN' 

--DROP TABLE RESEARCH..S14_TOTAL_DATASET_V2 

---------------------------------------------------------------------------------------------------------------
--Summary
---------------------------------------------------------------------------------------------------------------
SELECT count (*)  FROM RESEARCH..S14_TOTAL_DATASET_V2 
SELECT COUNT(*)   FROM INFORMATION_SCHEMA.COLUMNS WHERE table_catalog = 'RESEARCH' AND TABLE_NAME = 'S14_TOTAL_DATASET_V2' --413
---------------------------------------------------------------------------------------------------------------------------------
--Export of dataset
--------------------------------------------------------------------------------------------------------------------------------
--20220918 V2

SELECT  * FROM RESEARCH..S14_TOTAL_DATASET_V2 

--------------------------------------------------------------------------------------------------------------------------
--Sample SQL
-----------------------------------------------------------------------------------------------------------------------
SELECT   PATIENT_ID,[180-W], [20-W], [215-W]  FROM  RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_W order by 1,2
SELECT top 100   PATIENT_ID,[180-E], [20-E], [215-E] FROM  RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_E order by 1,2
SELECT top 100   PATIENT_ID,[180-M], [20-M], [215-M] FROM  RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_M order by 1,2
SELECT top 100   PATIENT_ID,[180-S], [20-S], [215-S] FROM  RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_S order by 1,2
SELECT top 100   PATIENT_ID,[180-ORG], [20-ORG], [215-ORG] FROM  RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_ORG order by 1,2
SELECT top 1000  * FROM RESEARCH.DBO.S10_PIVOT_MAX_DECIMAL


SELECT 413 - 23- 14

--SELECT *, PATIENT_ID,CODE, CONCEPT_ID_VALUE,[180], [20], [215]  FROM  RESEARCH.DBO.S10_PIVOT_COUNT_CHAR_w order by 1,2
--SELECT top 1000 VALUE_CHAR,* FROM RESEARCH..S10_F_OBSERVATION WHERE PATIENT_ID = 235279 
--AND CONCEPT_ID IN  ('20', '180', '215')  

--SELECT distinct VALUE_CHAR, [180], [20], [215]  FROM  RESEARCH.DBO.S10_PIVOT_COUNT_CHAR ORDER BY 1
--SELECT *, VALUE_CHAR, [180], [20], [215]  FROM  RESEARCH.DBO.S10_PIVOT_COUNT_CHAR
--WHERE PATIENT_ID = 235279
-- WHERE VALUE_CHAR = 'M800H' AND [20] = 12

