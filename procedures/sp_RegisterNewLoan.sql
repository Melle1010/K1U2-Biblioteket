USE [LibraryDB]
GO

/****** Object:  StoredProcedure [dbo].[sp_RegisterNewLoan]    Script Date: 2026-01-06 19:34:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_RegisterNewLoan]
    @MemberId INT,
    @BookId INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM View_ActiveLoans WHERE BookTitle = (SELECT Title FROM Book WHERE BookId = @BookId))
    BEGIN
        PRINT 'Boken är redan utlånad.';
        RETURN;
    END

    INSERT INTO Loan (LoanDate, FkMemberId, FkBookId)
    VALUES (GETDATE(), @MemberId, @BookId);
    
    PRINT 'Lånet har registrerats.';
END
GO


