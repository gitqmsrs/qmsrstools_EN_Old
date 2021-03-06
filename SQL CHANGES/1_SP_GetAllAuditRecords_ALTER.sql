USE [QMSRSToolsEN]
GO
/****** Object:  StoredProcedure [AuditManagement].[GetAllAuditRecords]    Script Date: 5/18/2016 1:01:09 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [AuditManagement].[GetAllAuditRecords](@auditorID int,@orgunitID int, @statusID int,@type int)
as
begin
set nocount on

select distinct AUDT.AuditReference,AUDT.PlannedAuditDate,AUDT.ActualAuditDate, AUDT.AuditTitle, AUDT.Scope,AUDTTYP.AuditType, AUDTSTS.AuditStatus 
from AuditManagement.Audit AUDT inner join AuditManagement.AuditType AUDTTYP on AUDT.AuditTypeId=AUDTTYP.AuditTypeId
inner join AuditManagement.AuditStatus AUDTSTS on AUDT.AuditStatusID=AUDTSTS.AuditStatusID
left join AuditManagement.RelatedAuditUnits UNT on AUDT.AuditId=UNT.AuditID
left join AuditManagement.Auditors AUDTR on AUDT.AuditId=AUDTR.AuditID

where (@auditorID =-1 OR AUDTR.EmployeeID=@auditorID) AND (@orgunitID=-1 OR UNT.UnitID=@orgunitID)
AND (@statusID=-1 OR AUDTSTS.AuditStatusID=@statusID) AND (@type=-1 OR AUDTTYP.AuditTypeId=@type)

end





