
-- remove duplciate Problems

  begin tran
  
  delete FROM [ProFieldMeterAME].[dbo].[ProblemEvent]
  where ProBlemID = 44460

  delete from [ProFieldMeterAME].[dbo].[Problem]
  where customerid = 417225
  and ProBlemID = 44460

  commit


BEGIN TRAN

UPDATE ASSET
SET STATUS = 0
WHERE SerialNumber  = '1ND662809025EH006'

-- ROLLBACK
-- COMMIT



Monthly PE Report

SELECT DISTINCT C.Address as SiteAddress,U.FirstName+ ' '+ U.LastName AS InstallerName,P.DateReported,
pt.ProblemName as ProbType,pt.ProblemGroup as ProbGroup, C.FormNum + ' '+ C.MeterClass as MeterFormClass,P.ProblemDescription as InstallerNotes,
'Reported '+pe.EventReason +' ' + 'Priority changed to:'+p.Priority as ManagerNotes
,(CASE WHEN P.[STATUS] = 10 THEN 'ESCALATED'
       WHEN P.status =15 THEN 'CallCenter' 
        WHEN P.status=20 THEN 'Rejected'
       WHEN P.status=30 THEN 'Resolved'
       WHEN P.status =40 THEN 'Closed'
       WHEN P.status=50 THEN  'FYI'
       END ) as Currentstatus
             ,aa.AttributeValue,c.Premisenumber,c.LegacyMeterSerial,P.GPSLatitude,P.GpsLongitude,P.BusinessunitId,U.FirstName+ ' '+ U.LastName   as Createdby,p.CustomerId
FROM PROBLEM P
INNER JOIN  CUSTOMER C ON C.CUSTOMERID =P.CustomerId
INNER JOIN Profieldcore.dbo.Profielduser U ON U.Email=P.CreatedBy
INNER JOIN ProblemType pt ON p.ProblemTypeId=pt.ProblemTypeId
LEFT JOIN AssetType  at on at.AssettypeId=c.RequiredMeterTypeId
INNER JOIN AssetAttribute aa on aa.AssetTypeId=at.AssetTypeId and aa.AttributeName ='BillingType'
INNER JOIN ProblemEvent Pe on Pe.ProblemId=P.ProblemId and Pe.ChangeDescription='StatusChanged'
WHERE p.DateReported between '2015-07-01 4:00:00' and '2015-08-01 03:59:59'

order by p.CustomerId




-- DELETE the call center escalations

BEGIN tran
  DELETE FROM [ProFieldMeterAME].[dbo].[Problem]
  where customerid in (404060, 295961, 397510)
  and ProblemTypeId in (12, 14)

  -- rollback
  --commit

ProFieldMeterAME].[dbo].[Problem]
  where customerid in (283653)

