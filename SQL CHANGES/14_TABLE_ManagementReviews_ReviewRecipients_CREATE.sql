

/****** Object:  Table [ManagementReviews].[ReviewRecipients]    Script Date: 7/29/2016 8:30:23 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [ManagementReviews].[ReviewRecipients](
	[RecipientID] [bigint] IDENTITY(1,1) NOT NULL,
	[ReviewID] [int] NOT NULL,
	[EmployeeID] [int] NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[ModifiedBy] [nvarchar](128) NULL,
 CONSTRAINT [PK_ReviewRecipients] PRIMARY KEY CLUSTERED 
(
	[RecipientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [ManagementReviews].[ReviewRecipients] ADD  CONSTRAINT [DF__ReviewRec__Modif__52EE3995]  DEFAULT (getdate()) FOR [ModifiedDate]
GO

ALTER TABLE [ManagementReviews].[ReviewRecipients]  WITH CHECK ADD  CONSTRAINT [FK_ReviewRecipients_Employee] FOREIGN KEY([EmployeeID])
REFERENCES [HumanResources].[Employee] ([EmployeeID])
GO

ALTER TABLE [ManagementReviews].[ReviewRecipients] CHECK CONSTRAINT [FK_ReviewRecipients_Employee]
GO

ALTER TABLE [ManagementReviews].[ReviewRecipients]  WITH CHECK ADD  CONSTRAINT [FK_ReviewRecipients_Review] FOREIGN KEY([ReviewID])
REFERENCES [ManagementReviews].[Review] ([ReviewID])
GO

ALTER TABLE [ManagementReviews].[ReviewRecipients] CHECK CONSTRAINT [FK_ReviewRecipients_Review]
GO


