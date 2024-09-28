--> ***Creating a DB***
```
CREATE DATABASE DB_NAME;
```

--> ***Changing a DB Name*** 
```
ALTER DATABASE OLD_DB_NAME MODIFY NAME = NEW_DB_NAME;

or

by using a system stored procedure

EXECUTE sp_renameDB 'OLD_DB_NAME','NEW_DB_NAME'
```

--> ***Deleting a DB*** 
```
DROP DATABASE DB_NAME;

notes:

if the db is acessed by more than one user and a user tries to drop the db while it's being used currently by appling queries on it, it will not be deleted
so, it needs to be put in a single user mode and delete the DB by using the following commmand:

ALTER DATABASE DB_NAME SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

by running this command if there is a query or a transaction running, it will be rollbacked 
```
