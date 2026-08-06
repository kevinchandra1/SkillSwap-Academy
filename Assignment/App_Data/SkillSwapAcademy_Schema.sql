/* =========================================================
   SkillSwap Academy - Database Schema (LocalDB version)
   CT050-3-2-WAPP Group Assignment

   HOW TO USE:
   1. In Visual Studio, right-click the project -> Add -> New Item -> "SQL Server Database"
      Name it: SkillSwapAcademy.mdf  (save into the App_Data folder)
   2. Once created, it opens in SQL Server Object Explorer. Right-click the database
      connection -> "New Query", paste this whole script, and execute (or use the
      Execute/Run button).
   3. No CREATE DATABASE / USE statements are needed - the .mdf file itself IS the
      database once attached (matches the same approach used in the reference project).
   ========================================================= */

CREATE TABLE Accounts (
    AccountId       INT IDENTITY(1,1) PRIMARY KEY,
    Username        NVARCHAR(50)    NOT NULL UNIQUE,
    Email           NVARCHAR(150)   NOT NULL UNIQUE,
    [Password]      NVARCHAR(100)   NOT NULL,
    FirstName       NVARCHAR(50)    NOT NULL,
    LastName        NVARCHAR(50)    NULL,
    Role            NVARCHAR(20)    NOT NULL DEFAULT 'Member', -- Member | Admin
    Bio             NVARCHAR(500)   NULL,
    CreatedDate     DATETIME        NOT NULL DEFAULT GETDATE(),
    IsActive        BIT             NOT NULL DEFAULT 1
);
GO

CREATE TABLE Categories (
    CategoryId      INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName    NVARCHAR(100)   NOT NULL UNIQUE,
    Description     NVARCHAR(300)   NULL
);
GO

CREATE TABLE Resources (
    ResourceId      INT IDENTITY(1,1) PRIMARY KEY,
    Title           NVARCHAR(150)   NOT NULL,
    Description     NVARCHAR(MAX)   NULL,
    ContentUrl      NVARCHAR(300)   NULL,
    ImagePath       NVARCHAR(300)   NULL,
    CategoryId      INT             NOT NULL,
    AccountId       INT             NOT NULL,
    UploadDate      DATETIME        NOT NULL DEFAULT GETDATE(),
    IsApproved      BIT             NOT NULL DEFAULT 0,
    CONSTRAINT FK_Resources_Categories FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId),
    CONSTRAINT FK_Resources_Accounts FOREIGN KEY (AccountId) REFERENCES Accounts(AccountId)
);
GO

CREATE TABLE Discussions (
    DiscussionId    INT IDENTITY(1,1) PRIMARY KEY,
    TopicTitle      NVARCHAR(150)   NOT NULL,
    Content         NVARCHAR(MAX)   NOT NULL,
    AccountId       INT             NOT NULL,
    ResourceId      INT             NULL,
    DateCreated     DATETIME        NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Discussions_Accounts FOREIGN KEY (AccountId) REFERENCES Accounts(AccountId),
    CONSTRAINT FK_Discussions_Resources FOREIGN KEY (ResourceId) REFERENCES Resources(ResourceId)
);
GO

CREATE TABLE DiscussionReplies (
    ReplyId         INT IDENTITY(1,1) PRIMARY KEY,
    DiscussionId    INT             NOT NULL,
    AccountId       INT             NOT NULL,
    ReplyContent    NVARCHAR(MAX)   NOT NULL,
    DateCreated     DATETIME        NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Replies_Discussions FOREIGN KEY (DiscussionId) REFERENCES Discussions(DiscussionId) ON DELETE CASCADE,
    CONSTRAINT FK_Replies_Accounts FOREIGN KEY (AccountId) REFERENCES Accounts(AccountId)
);
GO

CREATE TABLE SavedResources (
    SaveId          INT IDENTITY(1,1) PRIMARY KEY,
    AccountId       INT             NOT NULL,
    ResourceId      INT             NOT NULL,
    DateSaved       DATETIME        NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Saved_Accounts FOREIGN KEY (AccountId) REFERENCES Accounts(AccountId),
    CONSTRAINT FK_Saved_Resources FOREIGN KEY (ResourceId) REFERENCES Resources(ResourceId),
    CONSTRAINT UQ_Account_Resource UNIQUE (AccountId, ResourceId)
);
GO

CREATE TABLE Quizzes (
    QuizId          INT IDENTITY(1,1) PRIMARY KEY,
    Title           NVARCHAR(150)   NOT NULL,
    CategoryId      INT             NOT NULL,
    CreatedBy       INT             NOT NULL,
    CreatedDate     DATETIME        NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Quizzes_Categories FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId),
    CONSTRAINT FK_Quizzes_Accounts FOREIGN KEY (CreatedBy) REFERENCES Accounts(AccountId)
);
GO

CREATE TABLE QuizQuestions (
    QuestionId      INT IDENTITY(1,1) PRIMARY KEY,
    QuizId          INT             NOT NULL,
    QuestionText    NVARCHAR(500)   NOT NULL,
    OptionA         NVARCHAR(200)   NOT NULL,
    OptionB         NVARCHAR(200)   NOT NULL,
    OptionC         NVARCHAR(200)   NOT NULL,
    OptionD         NVARCHAR(200)   NOT NULL,
    CorrectOption   CHAR(1)         NOT NULL,
    CONSTRAINT FK_Questions_Quizzes FOREIGN KEY (QuizId) REFERENCES Quizzes(QuizId) ON DELETE CASCADE
);
GO

CREATE TABLE QuizAttempts (
    AttemptId       INT IDENTITY(1,1) PRIMARY KEY,
    QuizId          INT             NOT NULL,
    AccountId       INT             NOT NULL,
    Score           INT             NOT NULL DEFAULT 0,
    TotalQuestions  INT             NOT NULL DEFAULT 0,
    DateTaken       DATETIME        NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Attempts_Quizzes FOREIGN KEY (QuizId) REFERENCES Quizzes(QuizId),
    CONSTRAINT FK_Attempts_Accounts FOREIGN KEY (AccountId) REFERENCES Accounts(AccountId)
);
GO

/* ---------------------------------------------------------
   Seed Data
   --------------------------------------------------------- */
INSERT INTO Categories (CategoryName, Description) VALUES
('Programming', 'Coding, software development, and web technologies'),
('Graphic Design', 'Visual design, illustration, and branding'),
('Digital Marketing', 'SEO, social media, and online marketing skills'),
('Photography', 'Photography techniques and editing'),
('Public Speaking', 'Communication and presentation skills');
GO

-- Default Admin account (plain-text password, matching the reference project's approach)
-- Username: admin | Password: Admin123
INSERT INTO Accounts (Username, Email, [Password], FirstName, LastName, Role, IsActive) VALUES
('admin', 'admin@skillswap.com', 'Admin123', 'System', 'Administrator', 'Admin', 1);
GO

PRINT 'SkillSwap Academy schema created successfully.';
