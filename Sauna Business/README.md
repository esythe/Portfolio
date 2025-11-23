# Sauna Business Project

This project simulates the operation of a sauna business, offering:

1) Multiple session types (Women’s Only, Men’s Only, Family, Communal). 
   
2) Multiple membership programs (Regulars Club, NHS, Concession, Children). 
   
3) Customer visits, memberships, and payments. 
   
4) Discounts applied depending on membership tier.
   

### I asked Chat-GPT to generate a full SQL dataset of 300+ rows, using a schema I provided, including:

1. 100 customers. 
   
2. Membership purchases. 
   
3. Session purchases. 
   
4. Revenue details.
   
5. Discounts, payment methods, sign up dates.

### This project answers real business questions, such as:

1) Which sessions generate the most revenue?

2) How many customers join each membership type?
   
3) How much revenue is generated via full price vs. discounted purchases?
   
4) Who are the top spenders? 
   
5) Which customers, if any, have never purchased a sesssion?

The results of these queries were presented visually in Tableau.

### Skills Demonstrated
- Relational database design (PK/FK setup, normalised structure).

- SELECT and INSERT STATEMENTS.

- ROUND function.
  
- INNER JOIN & LEFT JOIN across multiple tables.
  
- Aggregations using SUM, COUNT, AVG with GROUP BY & HAVING.
  
- Common Table Expressions (CTEs) and subqueries.
  
- Window functions (RANK, OVER).
  
- Tableau.
  

# Schema 

## Memberships

``` SQL
MembershipID INT PRIMARY KEY IDENTITY(1,1),
MembershipName VARCHAR(50) NOT NULL,
DiscountPercent DECIMAL(5,2) NOT NULL,
MembershipPrice DECIMAL(10,2) NOT NULL
```

## Customers

``` SQL
 CustomerID INT PRIMARY KEY IDENTITY(1,1),
 FirstName VARCHAR(50),
 LastName VARCHAR(50),
 Email VARCHAR(100),
 MembershipID INT NULL,
 DateOfFirstVisit DATE,
 FOREIGN KEY (MembershipID) REFERENCES Memberships(MembershipID)
```

## Sessions

Sauna sessions available are:
Women’s Only,
Men’s Only,
Family and
Communal.

``` SQL 
SessionID INT PRIMARY KEY IDENTITY(1,1),
SessionName VARCHAR(50),
BasePrice DECIMAL(10,2)
```

## Payments
``` SQL
 PaymentID INT PRIMARY KEY IDENTITY(1,1),
 CustomerID INT NOT NULL,
 SessionID INT NULL,
 PurchasedMembershipID INT NULL,
 PaymentDate DATE NOT NULL,
 PaymentMethod VARCHAR(20) NOT NULL,
 AmountPaid DECIMAL(10,2) NOT NULL,
 FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
 FOREIGN KEY (SessionID) REFERENCES Sessions(SessionID),
 FOREIGN KEY (PurchasedMembershipID) REFERENCES Memberships(MembershipID)
 ```
