delete from averages;
insert into averages
select command, avg(real), avg(user), avg(sys)
from runs
group by command;
