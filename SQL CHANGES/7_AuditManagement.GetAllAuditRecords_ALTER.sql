USE [QMSRSToolsEN]
GO
/****** Object:  StoredProcedure [AuditManagement].[GetAllAuditRecords]    Script Date: 6/21/2016 10:11:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [AuditManagement].[GetAllAuditRecords](@auditorID int,@orgunitID int, @statusID int,@type int)
as
begin
set nocount on

select distinct AUDT.AuditId
	, AUDT.AuditReference
	,AUDT.PlannedAuditDate
	,AUDT.ActualAuditDate
	,AUDT.ActualCloseDate
	, AUDT.AuditTitle
	, AUDT.Scope
	,AUDTTYP.AuditType
	, AUDTSTS.AuditStatus 
	,AUDT.ProcessDocumentID
	,DOC.Title as ProcessDocument
	,rtrim(cast(isnull(AUDT.[%Completed],0) as varchar(10))) + '%' as AuditProgress
from AuditManagement.Audit AUDT 
	inner join AuditManagement.AuditType AUDTTYP on AUDT.AuditTypeId=AUDTTYP.AuditTypeId
inner join AuditManagement.AuditStatus AUDTSTS on AUDT.AuditStatusID=AUDTSTS.AuditStatusID
left join AuditManagement.RelatedAuditUnits UNT on AUDT.AuditId=UNT.AuditID
left join AuditManagement.Auditors AUDTR on AUDT.AuditId=AUDTR.AuditID
left join DocumentList.Document DOC on DOC.DocumentId = AUDT.ProcessDocumentID

where (@auditorID =-1 OR AUDTR.EmployeeID=@auditorID) AND (@orgunitID=-1 OR UNT.UnitID=@orgunitID)
AND (@statusID=-1 OR AUDTSTS.AuditStatusID=@statusID) AND (@type=-1 OR AUDTTYP.AuditTypeId=@type)

end





