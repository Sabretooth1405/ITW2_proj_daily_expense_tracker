CREATE TABLE TotalExp (
    UserId int,
    FullName varchar(255),
    Total_Exp float(2),
    Budget float(2)
);
SET SQL_SAFE_UPDATES = 0;
ALTER TABLE TotalExp ALTER COLUMN Budget SET DEFAULT 4500;


INSERT INTO TotalExp(UserId,FullName,Total_Exp,Budget)
SELECT tsq.UserId,tsq.FullName,Cast(tsq.total_Exp as float),4500
FROM(select tblexpense.UserId,tbluser.FullName ,SUM(tblexpense.ExpenseCost) as total_exp from tblexpense,tbluser
where tblexpense.UserId=tbluser.UserId
Group by UserId
Order by UserId
) as tsq(UserID,FullName,total_Exp);




