# K1U2-Biblioteket
# Bibliotekssystemet K2U2

Detta är ett administrativt verktyg för bibliotekshantering, utvecklat som en konsolapplikation i **.NET 10** med **Entity Framework Core** och en **SQL Server**-databas. Systemet hanterar medlemmar, böcker, utlåning och återlämning med fokus på dataintegritet och prestanda.

---
## DOKUMENTATION
https://github.com/Melle1010/K2U2-Biblioteket/blob/79041ed5ed750555f52c44359a7d3007ea07c372/docs/K2U2%20Dokumentation.pdf
---

## Verksamhetsbeskrivning
Systemet är byggt för att automatisera och säkra ett biblioteks dagliga drift. 
* **Bokhantering:** Registrering av titlar, författare och lagerstatus.
* **Medlemshantering:** Register över bibliotekets användare.
* **Låneflöde:** Registrering av utlåning där systemet kontrollerar att boken finns i lager.
* **Återlämning:** Automatiserad uppdatering av lagersaldo när en bok lämnas tillbaka.

<img width="1000" height="708" alt="image" src="https://github.com/user-attachments/assets/9dbbd752-ff40-44ae-a634-5f4a5f41d40f" />
<img width="1262" height="546" alt="image" src="https://github.com/user-attachments/assets/395bf68f-13d8-4b7b-9623-c478be38b71c" />
<img width="1311" height="370" alt="image" src="https://github.com/user-attachments/assets/d50de05f-7c07-44aa-ae38-c79f4506f6d3" />


---

<img width="1524" height="690" alt="image" src="https://github.com/user-attachments/assets/22bd4f3b-5c4f-46ab-91df-ebf42a8e1e16" />

## Dataintegritet
För att säkerställa att databasen aldrig hamnar i ett inkonsekvent tillstånd används flera tekniker:

Triggers: Triggern trg_UpdateStockOnReturn garanterar att bokens lagersaldo ökar direkt när en återlämning registreras, oavsett om det sker via applikationen eller direkt i SQL.

Stored Procedures med Transaktioner: I proceduren sp_RegisterNewLoan används SERIALIZABLE isolationsnivå. Detta förhindrar "race conditions", vilket innebär att två användare inte kan låna den sista kopian av en bok exakt samtidigt.

Constraints: Användning av Foreign Keys och NOT NULL säkerställer att inga lån kan existera utan en giltig bok eller medlem.

---

## Optimering
Prestandan har förbättrats genom strategisk indexering och effektiv datahämtning:

Indexering: I indexes.sql har jag skapat icke-klustrade index på Book(Title) och Book(Author). Detta gör att sökningar i biblioteket går snabbt även när bokbeståndet växer.

Vyer (Views): Genom View_ActiveLoans flyttas komplex JOIN-logik från applikationen till databasen, vilket förenklar koden och optimerar frågekörningen.

Eager Loading: I C#-koden används .Include() för att hämta relaterad data i ett enda anrop till databasen.

---
## En Execution Plan
I den bifogade exekveringsplanen ser man bevis på systemets optimering. Bland annat används en Index Seek (NonClustered) på tabellen BookReturn. Detta bekräftar att det manuella indexet IX_BookReturn_LoanId fyller sin funktion och tillåter databasen att snabbt filtrera bort återlämnade böcker utan en fullständig tabellskanning. Vidare ser vi att kopplingar mellan lån, medlemmar och böcker sker via Clustered Index Seeks, vilket garanterar minimalt resursutnyttjande vid sökning på primärnycklar.
<img width="1789" height="887" alt="image" src="https://github.com/user-attachments/assets/d69cec1c-77e1-4989-8403-1af3629843a2" />


