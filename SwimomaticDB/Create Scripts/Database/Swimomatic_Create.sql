 USE [Swimomatic]
GO
/****** Object:  Table [dbo].[AgeClass]    Script Date: 12/03/2009 14:12:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[AgeClass](
	[AgeClassID] [int] NOT NULL,
	[Description] [varchar](50) NOT NULL,
 CONSTRAINT [PK_AgeClass] PRIMARY KEY CLUSTERED 
(
	[AgeClassID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Heat]    Script Date: 12/03/2009 14:12:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Heat](
	[HeatID] [int] IDENTITY(1,1) NOT NULL,
	[SwimMeetEventID] [int] NOT NULL,
	[HeatNumber] [int] NOT NULL,
	[PoolPoolConfigID] [int] NOT NULL,
 CONSTRAINT [PK_Heat] PRIMARY KEY CLUSTERED 
(
	[HeatID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HeatSwimmer]    Script Date: 12/03/2009 14:12:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HeatSwimmer](
	[HeatSwimmerID] [int] IDENTITY(1,1) NOT NULL,
	[HeatID] [int] NOT NULL,
	[SwimmerID] [int] NOT NULL,
	[AssignedLaneNumber] [int] NOT NULL,
	[ActualLaneNumber] [int] NULL,
	[ElapsedTime] [float] NULL,
	[Penalty] [float] NULL,
	[Disqualified] [bit] NOT NULL CONSTRAINT [DF_HeatSwimmer_Disqualified]  DEFAULT ((0)),
 CONSTRAINT [PK_HeatSwimmer] PRIMARY KEY CLUSTERED 
(
	[HeatSwimmerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Location]    Script Date: 12/03/2009 14:12:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Location](
	[LocationID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Address] [varchar](50) NOT NULL,
	[City] [varchar](50) NOT NULL,
	[Region] [varchar](50) NOT NULL,
	[PostalCode] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Location] PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Pool]    Script Date: 12/03/2009 14:12:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Pool](
	[PoolID] [int] IDENTITY(1,1) NOT NULL,
	[LocationID] [int] NOT NULL,
	[Description] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Pool] PRIMARY KEY CLUSTERED 
(
	[PoolID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PoolConfig]    Script Date: 12/03/2009 14:12:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PoolConfig](
	[PoolConfigID] [int] IDENTITY(1,1) NOT NULL,
	[LapLength] [int] NOT NULL,
	[UOMID] [int] NOT NULL,
	[LaneCount] [int] NOT NULL,
 CONSTRAINT [PK_PoolConfig] PRIMARY KEY CLUSTERED 
(
	[PoolConfigID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PoolPoolConfig]    Script Date: 12/03/2009 14:12:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PoolPoolConfig](
	[PoolPoolConfigID] [int] IDENTITY(1,1) NOT NULL,
	[PoolID] [int] NOT NULL,
	[PoolConfigID] [int] NOT NULL,
 CONSTRAINT [PK_PoolPoolConfig] PRIMARY KEY CLUSTERED 
(
	[PoolPoolConfigID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Season]    Script Date: 12/03/2009 14:12:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Season](
	[SeasonID] [int] IDENTITY(1,1) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[Description] [varchar](250) NOT NULL,
 CONSTRAINT [PK_Season] PRIMARY KEY CLUSTERED 
(
	[SeasonID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Stroke]    Script Date: 12/03/2009 14:12:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Stroke](
	[StrokeID] [int] NOT NULL,
	[Description] [varchar](250) NOT NULL,
 CONSTRAINT [PK_Stroke] PRIMARY KEY CLUSTERED 
(
	[StrokeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SwimEvent]    Script Date: 12/03/2009 14:12:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SwimEvent](
	[SwimEventID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](250) NULL,
	[StrokeID] [int] NOT NULL,
	[AgeClassID] [int] NOT NULL,
 CONSTRAINT [PK_SwimEvent] PRIMARY KEY CLUSTERED 
(
	[SwimEventID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SwimMeet]    Script Date: 12/03/2009 14:12:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SwimMeet](
	[SwimMeetID] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](250) NULL,
	[StartDate] [datetime] NOT NULL,
	[LocationID] [int] NOT NULL,
	[SeasonID] [int] NOT NULL,
 CONSTRAINT [PK_SwimMeet] PRIMARY KEY CLUSTERED 
(
	[SwimMeetID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SwimMeetEvent]    Script Date: 12/03/2009 14:12:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwimMeetEvent](
	[SwimMeetEventID] [int] IDENTITY(1,1) NOT NULL,
	[SwimMeetID] [int] NOT NULL,
	[SwimEventID] [int] NOT NULL,
	[Sequence] [int] NOT NULL,
	[Distance] [int] NOT NULL,
 CONSTRAINT [PK_SwimMeetEvent] PRIMARY KEY CLUSTERED 
(
	[SwimMeetEventID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SwimMeetTeam]    Script Date: 12/03/2009 14:12:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwimMeetTeam](
	[SwimMeetTeamID] [int] IDENTITY(1,1) NOT NULL,
	[SwimMeetID] [int] NOT NULL,
	[TeamID] [int] NOT NULL,
	[IsHomeTeam] [bit] NOT NULL,
 CONSTRAINT [PK_SwimMeetTeam] PRIMARY KEY CLUSTERED 
(
	[SwimMeetTeamID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Swimmer]    Script Date: 12/03/2009 14:12:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Swimmer](
	[SwimmerID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](50) NOT NULL,
	[LastName] [varchar](50) NOT NULL,
	[BirthDate] [datetime] NOT NULL,
 CONSTRAINT [PK_Swimmer] PRIMARY KEY CLUSTERED 
(
	[SwimmerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SwimmerTeamSeason]    Script Date: 12/03/2009 14:12:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SwimmerTeamSeason](
	[SwimmerTeamSeasonID] [int] IDENTITY(1,1) NOT NULL,
	[SwimmerID] [int] NOT NULL,
	[TeamSeasonID] [int] NOT NULL,
	[AgeClassID] [int] NOT NULL,
	[StartDate] [smalldatetime] NOT NULL,
	[EndDate] [smalldatetime] NOT NULL,
 CONSTRAINT [PK_SwimmerTeamSeason] PRIMARY KEY CLUSTERED 
(
	[SwimmerTeamSeasonID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Team]    Script Date: 12/03/2009 14:12:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Team](
	[TeamID] [int] IDENTITY(1,1) NOT NULL,
	[TeamName] [varchar](50) NOT NULL,
	[Abbrev] [varchar](5) NOT NULL,
 CONSTRAINT [PK_Team] PRIMARY KEY CLUSTERED 
(
	[TeamID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[TeamSeason]    Script Date: 12/03/2009 14:12:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamSeason](
	[TeamSeasonID] [int] IDENTITY(1,1) NOT NULL,
	[TeamID] [int] NOT NULL,
	[SeasonID] [int] NOT NULL,
 CONSTRAINT [PK_TeamSeason] PRIMARY KEY CLUSTERED 
(
	[TeamSeasonID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UOM]    Script Date: 12/03/2009 14:12:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UOM](
	[UOMID] [int] NOT NULL,
	[Description] [varchar](50) NOT NULL,
	[Abbrev] [varchar](5) NOT NULL,
 CONSTRAINT [PK_UOM] PRIMARY KEY CLUSTERED 
(
	[UOMID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Heat]  WITH CHECK ADD  CONSTRAINT [FK_Heat_PoolPoolConfig] FOREIGN KEY([PoolPoolConfigID])
REFERENCES [dbo].[PoolPoolConfig] ([PoolPoolConfigID])
GO
ALTER TABLE [dbo].[Heat] CHECK CONSTRAINT [FK_Heat_PoolPoolConfig]
GO
ALTER TABLE [dbo].[Heat]  WITH CHECK ADD  CONSTRAINT [FK_Heat_SwimMeetEvent] FOREIGN KEY([SwimMeetEventID])
REFERENCES [dbo].[SwimMeetEvent] ([SwimMeetEventID])
GO
ALTER TABLE [dbo].[Heat] CHECK CONSTRAINT [FK_Heat_SwimMeetEvent]
GO
ALTER TABLE [dbo].[HeatSwimmer]  WITH CHECK ADD  CONSTRAINT [FK_HeatSwimmer_Heat] FOREIGN KEY([HeatID])
REFERENCES [dbo].[Heat] ([HeatID])
GO
ALTER TABLE [dbo].[HeatSwimmer] CHECK CONSTRAINT [FK_HeatSwimmer_Heat]
GO
ALTER TABLE [dbo].[HeatSwimmer]  WITH CHECK ADD  CONSTRAINT [FK_HeatSwimmer_Swimmer] FOREIGN KEY([SwimmerID])
REFERENCES [dbo].[Swimmer] ([SwimmerID])
GO
ALTER TABLE [dbo].[HeatSwimmer] CHECK CONSTRAINT [FK_HeatSwimmer_Swimmer]
GO
ALTER TABLE [dbo].[Pool]  WITH CHECK ADD  CONSTRAINT [FK_Pool_Location] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Location] ([LocationID])
GO
ALTER TABLE [dbo].[Pool] CHECK CONSTRAINT [FK_Pool_Location]
GO
ALTER TABLE [dbo].[PoolConfig]  WITH CHECK ADD  CONSTRAINT [FK_PoolConfig_UOM] FOREIGN KEY([UOMID])
REFERENCES [dbo].[UOM] ([UOMID])
GO
ALTER TABLE [dbo].[PoolConfig] CHECK CONSTRAINT [FK_PoolConfig_UOM]
GO
ALTER TABLE [dbo].[PoolPoolConfig]  WITH CHECK ADD  CONSTRAINT [FK_PoolPoolConfig_Pool] FOREIGN KEY([PoolID])
REFERENCES [dbo].[Pool] ([PoolID])
GO
ALTER TABLE [dbo].[PoolPoolConfig] CHECK CONSTRAINT [FK_PoolPoolConfig_Pool]
GO
ALTER TABLE [dbo].[PoolPoolConfig]  WITH CHECK ADD  CONSTRAINT [FK_PoolPoolConfig_PoolConfig] FOREIGN KEY([PoolConfigID])
REFERENCES [dbo].[PoolConfig] ([PoolConfigID])
GO
ALTER TABLE [dbo].[PoolPoolConfig] CHECK CONSTRAINT [FK_PoolPoolConfig_PoolConfig]
GO
ALTER TABLE [dbo].[SwimEvent]  WITH CHECK ADD  CONSTRAINT [FK_SwimEvent_AgeClass] FOREIGN KEY([AgeClassID])
REFERENCES [dbo].[AgeClass] ([AgeClassID])
GO
ALTER TABLE [dbo].[SwimEvent] CHECK CONSTRAINT [FK_SwimEvent_AgeClass]
GO
ALTER TABLE [dbo].[SwimEvent]  WITH CHECK ADD  CONSTRAINT [FK_SwimEvent_Stroke] FOREIGN KEY([StrokeID])
REFERENCES [dbo].[Stroke] ([StrokeID])
GO
ALTER TABLE [dbo].[SwimEvent] CHECK CONSTRAINT [FK_SwimEvent_Stroke]
GO
ALTER TABLE [dbo].[SwimMeet]  WITH CHECK ADD  CONSTRAINT [FK_SwimMeet_Location] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Location] ([LocationID])
GO
ALTER TABLE [dbo].[SwimMeet] CHECK CONSTRAINT [FK_SwimMeet_Location]
GO
ALTER TABLE [dbo].[SwimMeet]  WITH CHECK ADD  CONSTRAINT [FK_SwimMeet_Season] FOREIGN KEY([SeasonID])
REFERENCES [dbo].[Season] ([SeasonID])
GO
ALTER TABLE [dbo].[SwimMeet] CHECK CONSTRAINT [FK_SwimMeet_Season]
GO
ALTER TABLE [dbo].[SwimMeetEvent]  WITH CHECK ADD  CONSTRAINT [FK_SwimMeetEvent_SwimEvent] FOREIGN KEY([SwimEventID])
REFERENCES [dbo].[SwimEvent] ([SwimEventID])
GO
ALTER TABLE [dbo].[SwimMeetEvent] CHECK CONSTRAINT [FK_SwimMeetEvent_SwimEvent]
GO
ALTER TABLE [dbo].[SwimMeetEvent]  WITH CHECK ADD  CONSTRAINT [FK_SwimMeetEvent_SwimMeet] FOREIGN KEY([SwimMeetID])
REFERENCES [dbo].[SwimMeet] ([SwimMeetID])
GO
ALTER TABLE [dbo].[SwimMeetEvent] CHECK CONSTRAINT [FK_SwimMeetEvent_SwimMeet]
GO
ALTER TABLE [dbo].[SwimMeetTeam]  WITH CHECK ADD  CONSTRAINT [FK_SwimMeetTeam_SwimMeet] FOREIGN KEY([SwimMeetID])
REFERENCES [dbo].[SwimMeet] ([SwimMeetID])
GO
ALTER TABLE [dbo].[SwimMeetTeam] CHECK CONSTRAINT [FK_SwimMeetTeam_SwimMeet]
GO
ALTER TABLE [dbo].[SwimMeetTeam]  WITH CHECK ADD  CONSTRAINT [FK_SwimMeetTeam_Team] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([TeamID])
GO
ALTER TABLE [dbo].[SwimMeetTeam] CHECK CONSTRAINT [FK_SwimMeetTeam_Team]
GO
ALTER TABLE [dbo].[SwimmerTeamSeason]  WITH CHECK ADD  CONSTRAINT [FK_SwimmerTeamSeason_AgeClass] FOREIGN KEY([AgeClassID])
REFERENCES [dbo].[AgeClass] ([AgeClassID])
GO
ALTER TABLE [dbo].[SwimmerTeamSeason] CHECK CONSTRAINT [FK_SwimmerTeamSeason_AgeClass]
GO
ALTER TABLE [dbo].[SwimmerTeamSeason]  WITH CHECK ADD  CONSTRAINT [FK_SwimmerTeamSeason_Swimmer] FOREIGN KEY([SwimmerID])
REFERENCES [dbo].[Swimmer] ([SwimmerID])
GO
ALTER TABLE [dbo].[SwimmerTeamSeason] CHECK CONSTRAINT [FK_SwimmerTeamSeason_Swimmer]
GO
ALTER TABLE [dbo].[SwimmerTeamSeason]  WITH CHECK ADD  CONSTRAINT [FK_SwimmerTeamSeason_TeamSeason] FOREIGN KEY([TeamSeasonID])
REFERENCES [dbo].[TeamSeason] ([TeamSeasonID])
GO
ALTER TABLE [dbo].[SwimmerTeamSeason] CHECK CONSTRAINT [FK_SwimmerTeamSeason_TeamSeason]
GO
ALTER TABLE [dbo].[TeamSeason]  WITH CHECK ADD  CONSTRAINT [FK_TeamSeason_Season] FOREIGN KEY([SeasonID])
REFERENCES [dbo].[Season] ([SeasonID])
GO
ALTER TABLE [dbo].[TeamSeason] CHECK CONSTRAINT [FK_TeamSeason_Season]
GO
ALTER TABLE [dbo].[TeamSeason]  WITH CHECK ADD  CONSTRAINT [FK_TeamSeason_Team] FOREIGN KEY([TeamID])
REFERENCES [dbo].[Team] ([TeamID])
GO
ALTER TABLE [dbo].[TeamSeason] CHECK CONSTRAINT [FK_TeamSeason_Team]