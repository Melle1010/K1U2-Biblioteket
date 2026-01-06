USE [LibraryDB]
GO

/****** Object:  StoredProcedure [dbo].[sp_RegisterNewLoan]    Script Date: 2026-01-06 20:37:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_RegisterNewLoan]
    @MemberId INT,
    @BookId INT
AS
BEGIN
    SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

    BEGIN TRANSACTION;

    BEGIN TRY
        IF EXISTS (SELECT 1 FROM View_ActiveLoans WHERE BookTitle = (SELECT Title FROM Book WHERE BookId = @BookId))
        BEGIN
            PRINT 'Boken är redan utlånad.';
            ROLLBACK; -- Avbryt och släpp låset
            RETURN;
        END

        INSERT INTO Loan (LoanDate, FkMemberId, FkBookId)
        VALUES (GETDATE(), @MemberId, @BookId);

        COMMIT;
        PRINT 'Lånet har registrerats.';
    END TRY
    BEGIN CATCH
        ROLLBACK;
        PRINT 'Ett fel uppstod vid registrering av lånet.';
    END CATCH
END
GO


