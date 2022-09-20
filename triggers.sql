delimiter $$
Create trigger ExpenseCost before insert on
tblexpense for each row
BEGIN
IF NEW.ExpenseCost <0 THEN SET NEW.ExpenseCost=0;
END IF;
END $$


Create trigger Total_Exp_change after insert on
tblexpense for each row
Begin
DELETE FROM TotalExp;
INSERT INTO TotalExp(UserId,FullName,Total_Exp,Budget)
SELECT tsq.UserId,tsq.FullName,Cast(tsq.total_Exp as float),4500
FROM(select tblexpense.UserId,tbluser.FullName ,SUM(tblexpense.ExpenseCost) as total_exp from tblexpense,tbluser
where tblexpense.UserId=tbluser.UserId
Group by UserId
Order by UserId
) as tsq(UserID,FullName,total_Exp);
END $$

delimiter $$
Create trigger Total_Exp_change_u after update on
tblexpense for each row
Begin
SET SQL_SAFE_UPDATES = 0;
DELETE FROM TotalExp;
INSERT INTO TotalExp(UserId,FullName,Total_Exp,Budget)
SELECT tsq.UserId,tsq.FullName,Cast(tsq.total_Exp as float),4500
FROM(select tblexpense.UserId,tbluser.FullName ,SUM(tblexpense.ExpenseCost) as total_exp from tblexpense,tbluser
where tblexpense.UserId=tbluser.UserId
Group by UserId
Order by UserId
) as tsq(UserID,FullName,total_exp);
END $$

delimiter $$
Create trigger Total_Exp_change_d after delete on
tblexpense for each row
Begin
SET SQL_SAFE_UPDATES = 0;
DELETE FROM TotalExp;
INSERT INTO TotalExp(UserId,FullName,Total_Exp,Budget)
SELECT tsq.UserId,tsq.FullName,Cast(tsq.total_Exp as float),4500
FROM(select tblexpense.UserId,tbluser.FullName ,SUM(tblexpense.ExpenseCost) as total_exp from tblexpense,tbluser
where tblexpense.UserId=tbluser.UserId
Group by UserId
Order by UserId
) as tsq(UserID,FullName,total_exp);
END $$

delimiter $$
create trigger tbluser_i after insert on tbluser
for each row 
begin
Insert into tblexpense(UserId,ExpenseDate,ExpenseItem,ExpenseCost)
values(New.UserId,curdate(),"Dummy",0);
END $$

DELIMITER $$

CREATE TRIGGER tbluser_d before delete on tbluser
     FOR EACH ROW
BEGIN
    Delete from tblexpense where UserId=OLD.UserId;
    Delete from TotalExp where UserId=OLD.UserId;

END$$  
