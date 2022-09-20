create view  category_breakdown as
select UserId,Expenseitem,SUM(ExpenseCost)
from tblexpense
group by UserId,ExpenseItem
Order by UserId;

create view averageDailyExp as
Select UserId,cast(avg(daily) as float) as daily_avg
From
(Select UserId,avg(ExpenseCost)
from tblexpense
GROUP by ExpenseDate,UserId
Order by UserId) as avgexp(UserId,daily)
group By UserId
