

/****** Object:  Table [AuditManagement].[Recipients]    Script Date: 5/24/2016 1:11:55 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [AuditManagement].[Recipients](
	[RecipientID] [bigint] IDENTITY(1,1) NOT NULL,
	[AuditID] [bigint] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL CONSTRAINT [DF_Recipients_ModifiedDate]  DEFAULT (getdate()),
	[ModifiedBy] [nvarchar](128) NULL,
 CONSTRAINT [PK_Recipients] PRIMARY KEY CLUSTERED 
(
	[RecipientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [AuditManagement].[Recipients]  WITH NOCHECK ADD  CONSTRAINT [FK_Audit_Recipients] FOREIGN KEY([AuditID])
REFERENCES [AuditManagement].[Audit] ([AuditId])
GO

ALTER TABLE [AuditManagement].[Recipients] CHECK CONSTRAINT [FK_Audit_Recipients]
GO

ALTER TABLE [AuditManagement].[Recipients]  WITH CHECK ADD  CONSTRAINT [FK_Recipients_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [HumanResources].[Employee] ([EmployeeID])
GO

ALTER TABLE [AuditManagement].[Recipients] CHECK CONSTRAINT [FK_Recipients_Employee]
GO


