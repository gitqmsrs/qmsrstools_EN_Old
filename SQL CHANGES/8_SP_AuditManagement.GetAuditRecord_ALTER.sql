
/****** Object:  StoredProcedure [AuditManagement].[GetAuditRecord]    Script Date: 6/25/2016 8:53:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER proc [AuditManagement].[GetAuditRecord](@auditID int)
as
begin
set nocount on

select AUDT.AuditReference, AUDT.AuditTitle, AUDTTYP.AuditType,AUDTSTS.AuditStatus, AUDT.PlannedAuditDate,
AUDT.ActualAuditDate, AUDT.ActualCloseDate, DOC.Title as [ProcessDocument], AUDT.Scope,AUDT.Summery,AUDT.Notes 
from AuditManagement.Audit AUDT inner join AuditManagement.AuditType AUDTTYP on AUDT.AuditTypeId=AUDTTYP.AuditTypeId
inner join AuditManagement.AuditStatus AUDTSTS on AUDT.AuditStatusID=AUDTSTS.AuditStatusID left join DocumentList.Document DOC
on AUDT.ProcessDocumentID=DOC.DocumentId
where AUDT.AuditId=@auditID
end




