USE [QMSRSToolsEN]
GO
/****** Object:  StoredProcedure [AuditManagement].[GetAuditActions]    Script Date: 6/26/2016 9:52:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [AuditManagement].[GetAuditActions](@auditID int)
as 
begin
set nocount on

select FND.Title,FNDTYP.FindingType, ACT.AuditActionId AS ActionNo, ACT.Details,ACTTYP.Name, ACT.TargetClosingDate,ACT.DelayedDate,ACT.CompletedDate,
ACT.IsClosed
from [AuditManagement].Finding FND inner join [AuditManagement].FindingType FNDTYP
on FND.FindingTypeId=FNDTYP.FindingTypeId inner join [AuditManagement].AuditAction ACT on FND.FindingId=ACT.FindingId
inner join [AuditManagement].AuditActionType ACTTYP on ACT.AuditActionTypeId=ACTTYP.AuditActionTypeId
inner join [AuditManagement].Audit AUDT on FND.AuditId=AUDT.AuditId
where AUDT.AuditId=@auditID
end





