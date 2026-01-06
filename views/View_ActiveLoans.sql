USE [LibraryDB]
GO

/****** Object:  View [dbo].[View_ActiveLoans]    Script Date: 2026-01-06 19:27:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[View_ActiveLoans] AS
SELECT 
    L.LoanId,
    M.FullName AS MemberName,
    B.Title AS BookTitle,
    L.LoanDate
FROM Loan L
JOIN LibraryMember M ON L.FkMemberId = M.MemberId
JOIN Book B ON L.FkBookId = B.BookId
LEFT JOIN BookReturn R ON L.LoanId = R.FkLoanId
WHERE R.ReturnId IS NULL;
GO


