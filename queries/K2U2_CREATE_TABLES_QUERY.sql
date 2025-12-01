-- Create Table For Library Member
CREATE TABLE LibraryMember(
	MemberId INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
	FullName NVARCHAR(50) NOT NULL
)

-- Create Table For Book
CREATE TABLE Book(
	BookId INT IDENTITY(1,1) PRIMARY KEY,
	Title NVARCHAR(50) NOT NULL,
	Author NVARCHAR(50) NOT NULL
)

-- Create Table For Loan
CREATE TABLE Loan(
	LoanId INT IDENTITY(1,1) PRIMARY KEY,
	LoanDate DATE NOT NULL,
	FkMemberId INT NOT NULL,
	FkBookId INT NOT NULL,
	CONSTRAINT FK_Loan_Member FOREIGN KEY (FkMemberId) REFERENCES LibraryMember(MemberId),
	CONSTRAINT FK_Loan_Book FOREIGN KEY (FkBookId) REFERENCES Book(BookId)
)

-- Create Table For Book Return
CREATE TABLE BookReturn(
	ReturnId INT IDENTITY(1,1) PRIMARY KEY,
	ReturnDate DATE NOT NULL,
	FkLoanId INT NOT NULL,
	CONSTRAINT FK_BookReturn_Loan FOREIGN KEY (FkLoanId) REFERENCES Loan(LoanId),
)

