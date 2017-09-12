USE [QMSRSToolsEN]
GO
/****** Object:  StoredProcedure [DocumentList].[GetDocuments]    Script Date: 8/28/2017 9:00:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [DocumentList].[GetDocuments](@type int,@status int,@project int, @unit int, @duration int)
as 
begin
set nocount on

declare @today datetime
set @today=getdate()

Select DOC.DocumentNo,DOCTYP.DocumentType,DOC.Title,(RTRIM(DOC.ReviewDuration) + ' ' + PRD.Period) as Duration,
DOC.IssueDate, DOC.LastReviewDate, DOC.NextReviewDate,DOCSTS.DocumentStatus, UNT.UnitName,
PRJ.ProjectName as [Project],  
(select count(*) from ChangeControl.ChangeControlNote where DocumentId=DOC.DocumentId) as [TotalCCN],
(SELECT TOP 1 CCNID FROM [QMSRSToolsEN].[ChangeControl].[ChangeControlNote] WHERE DocumentID = DOC.DocumentId ORDER BY ModifiedDate DESC) AS CCNID

from DocumentList.Document DOC inner join DocumentList.DocumentType DOCTYP on
DOC.DocumentTypeID=DOCTYP.DocumentTypeId inner join DocumentList.DocumentStatus DOCSTS
on DOC.DocumentStatusID=DOCSTS.DocumentStatusID inner join HumanResources.Period PRD
on DOC.PeriodID=PRD.PeriodID left join HumanResources.OrganizationUnit UNT on
DOC.DepartmentID=UNT.UnitID left join  ProjectManagement.ProjectInformation PRJ
on DOC.ProjectID=PRJ.ProjectId
where (@type=-1 OR DOC.DocumentTypeID =@type) AND (@unit=-1 OR DOC.DepartmentID = @unit) AND 
(@project=-1 OR DOC.ProjectID = @project) AND 
(@status=-1 OR DOC.DocumentStatusID=@status) AND (@duration=-1 OR (@today>DOC.NextReviewDate and @today between DATEADD(DAY, @duration-10, DOC.NextReviewDate) and DATEADD(DAY, @duration, DOC.NextReviewDate)))
end




