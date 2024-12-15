***Why not to use File Based system in our apps:***
1- Difficult search or reach for data --> slow performance.
2- Separate copies --> inconsistency.
3- No relationships between files --> no data integrity.  
4- No constraints generally --> Data Duplication, Data integrity, Business rules (can be solved by coding in the app but, would take long time development).
5- No Security and permission control.
6- All data considered as Text (No data types) 
--> No data quality.
7- Integration difficulty between files due to their different formats and standards.

***Database system***
1- Files --> Tables connected through relationships.
2- One standard.
3- Metadata (ERD --> entities names, relationships, attributes names) + Data.
4- Each column has a datatype.
5- Each table Must have a PK.
6- Centralized and shared among users (All users and apps have the same modifications and updates).

---
Database: Collection of related data.
DBMS: Software to interact with the database.
Database System: App Program+ Database + DBMS(SW of queries Processing + SW of stored data access).

---
***Entity-Relationship Diagram ERD***
Turning business requirements into representation of Entities and their attributes and relationships.

--> Requirements document can generate more than on ERD.
--> More than one relationship can be between two entities but should differ in the meaning.

***1- Entities Types:***
- Strong Entity: 
	- Entity that doesn't depend on another entity for its existence.
	- Has a PK.
- Weak Entity: 
	- Entity that depends on another entity for its existence.
	- Don't have sufficient attributes to form a PK but, has a **partial key**.
	- Removal of Weak entity in case of removal of its parent entity depends on the business rules.
***2- Attributes Types:***
- **Simple** (doesn't get into smaller parts - not derived in the real-time - not multi-valued for the same entity) --> **circle**.
- **Composite** (Full Name - date of birth) --> **circles coming from a circle** --> to say an attribute is composite their parts must form a meaningful thing when combined .
- **Multi-Valued** (Phone No. - address) --> **double circle**.
- **Derived** (age) --> **dashed ellipse**.
- **Complex** (multi-valued + composite) (more than one address which consists of street / city / country).

***3- Relationships Types(Degree of Relationships):***
- **Unary (Recursive):** two instances of one entity.
- **Binary:** the instances of two entities.
- **Ternary:** the instances of three entities.

***4- Cardinality:***
- One-to-One.
- One-to-Many.
- Many-to-Many.

***5- Participation***
- Total (mandatory - one or more - must) (A car must be assigned by an employee) **(Any weak entity should have a total participation).**
- Partial (optional - zero or more - may) (Employee may have a car).

---
***Types of Keys***

Key: One or more attributes that can uniquely a row (tuple) of data.

1- Super Key (All options that can be a PK).
2- Candidate Key (Minimal Super Keys - simple or composite).
3- Primary Key.
4- Alternate Key (Non chosen PK).
5- Foreign Key.
6- Composite Key.
7- Partial Key.
8- Surrogate Key.
9- Natural Key.

---

