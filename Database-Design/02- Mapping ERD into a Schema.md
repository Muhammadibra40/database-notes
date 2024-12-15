
Partial Participation --> FK allows Null values.
one-to-one --> Unique constraint on FK.

***Steps***
--
--> First Thing: Look if there is a 1:1 total from both sides.
1- Regular Entity Types.
	- Composite Attributes get subtracted into columns.
	- Multi-valued: becomes a separate relation with a FK and a composite PK (multi-valued attribute + FK(PK of parent table)). 
	- Derived attributes: don't get put into the table but would be in the constraint file **but if there were other attributes that depend on that derived attribute or the equation of evaluating the derived attribute would take much time due to big data or because it takes time generally so it would be more continent if it's put in the table.**
	- Complex: same as multi-valued but the composite would be turned into columns.
2- Weak Entities.
	- Composite PK: (PK of parent + partial identifier of weak entity)
3- Binary 1:1.
	- 1:1 Total from both sides: 
		- 1 Table with PK = any PK of the two tables.
		- **1:1**: This is a one-to-one relationship, meaning each record in Table A is linked to exactly one record in Table B, and vice versa.
		- **Total Participation**: Total participation from both sides means that every record in Table A must have a corresponding record in Table B, and every record in Table B must have a corresponding record in Table A.
- As partial increases the no. of tables increases.
	- 1:1 Total and partial: 
		- 2 Tables and Put PK of the partial as a FK in total.
		- For example, consider the entities **Person** and **Passport**:
			- **Passport** has **total participation** because every passport is linked to exactly one person.
			- **Person** has **partial participation** because not every person necessarily has a passport.
			- By ==placing the primary key of the partially participating entity (`PersonID`) as a foreign key in the totally participating entity (`Passport`)==, we ensure that every passport must reference an existing person, enforcing the mandatory link for passports.
			- If we were to do this the other way around (placing `PassportID` in the `Person` table), then people without passports would have `NULL` values for `PassportID`, leading to potentially messy database handling.
	- 1:1 Partial both sides: 
			- 3 Tables with the third holding the both FKs of the other two and ==either of them can be a PK.==
			==- Why not both as a composite key: PK is the minimal combination of columns that uniquely identify each record so using only one of them will do the job.==
			- **Both tables** can exist independently, and there may be records in each table that do not correspond to a record in the other.
4- Binary 1:N.
	- N Total: 
		- ![[_1-N total.png]]
		- 2 Tables and put the PK of the partial 1 and put it as a FK in the N total.
		- Can't do the opposite because this will lead to the duplication of D_Id which is unique.
		- Employees N/ Departments 1: The department holds can have 0 or many employees and the employee can be **Must** assigned to only one department.  
	- N Partial:
		- ![[1.png]]
		- 3 Tables and third table holds the both ==PKs of the other two tables as FKs, PK will be the one with the many side.==
5- Binary M:N.
		- 3 Tables with a composite PK of the two FKs.
6- N-ary Relationship (3Ternary or more).
		-![[Ternary.png]]
		- Create a new table.
		-  PK gets Decided whether it's gonna be a suitable combination of columns or a surrogate key but not all the FKs as a composite.  
7- Unary.
		- 1:N:
			- Both PK and FK in the same table.
		- N:M: 
			- To represent a many-to-many unary relationship, you need a **junction table** (also called a **bridge table** or **associative table**) to capture the relationship between the entities. This table will contain foreign keys referencing the primary key of the main entity table twice, representing both sides of the relationship.
			- Both FKs will present a Composite PK.

***--> Attribute on the relationship:*** 
	- Wil be put in the third table **"if there"** that holds the two keys of the other two.
	- If there is no third table: it gets decided logically.

***--> States that requires composite PK:***
- Multi-Valued.
- Complex.
- Weak Entity.
- Binary N:M. 


