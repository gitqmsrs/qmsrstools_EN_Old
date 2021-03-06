USE [QMSRSToolsEN]
GO
/****** Object:  StoredProcedure [AuditManagement].[GetAuditFindings]    Script Date: 6/26/2016 9:20:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER proc [AuditManagement].[GetAuditFindings](@auditID int)
as 
begin
set nocount on

SELECT FND.FindingId AS FindingNo, FND.Title,FNDTYP.FindingType,CUS.CauseName,SUB.CauseName AS SubCauseName,ISO.Process 
FROM AuditManagement.Finding FND 
  INNER JOIN AuditManagement.FindingType FNDTYP
    ON FND.FindingTypeId=FNDTYP.FindingTypeId 
  LEFT JOIN dbo.Causes CUS 
    ON FND.RootCauseID=CUS.CauseID 
  LEFT JOIN dbo.Causes SUB 
    ON FND.SubCauseID=SUB.CauseID 
  LEFT JOIN dbo.ISOProcesses ISO
    ON FND.ISOCheckID=ISO.ISOProcessID 
  INNER JOIN AuditManagement.Audit AUDT 
    ON FND.AuditId=AUDT.AuditId
WHERE AUDT.AuditId=@auditID
end




