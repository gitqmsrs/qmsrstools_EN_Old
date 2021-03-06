
/****** Object:  UserDefinedFunction [AuditManagement].[fn_getFindingCauseChildTree]    Script Date: 5/30/2016 2:04:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER function [AuditManagement].[fn_getFindingCauseChildTree](@findingid int)
returns @table table
(
	CauseID int null,
	Cause nvarchar(100),
	ParentID int null,
	Description nvarchar(max),
	Depth int null, 
	SelectedCauseID int null
)
as
begin
WITH w1( CauseID, CauseName,RootCauseID,Description, level, SelectedCauseID ) AS 
(		SELECT 
			C.CauseID, 
			C.CauseName, 
			C.RootCauseID,
			C.Description,
			0 AS level, 
			FND.SubCauseID AS SelectedCauseID
		FROM 
			dbo.Causes C join AuditManagement.Finding FND 
			on C.CauseID=FND.RootCauseID  
		WHERE 
			C.RootCauseID IS NULL and FND.FindingId=@findingid
	UNION ALL 
		SELECT 
			c1.CauseID, 
			c1.CauseName, 
			c1.RootCauseID,
			c1.Description,
			level + 1, 
			SelectedCauseID
		FROM 
			dbo.Causes c1 JOIN w1 ON c1.RootCauseID = w1.CauseID
			
) 
insert into @table(CauseID,Cause,ParentID,Description,Depth, SelectedCauseID)
(SELECT w1.CauseID,w1.CauseName,w1.RootCauseID,Description,level, SelectedCauseID FROM w1)

return 
end



