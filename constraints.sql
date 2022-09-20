select * from tbluser;
ALTER TABLE tbluser
add constraint Email check(
Email regexp "^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@([a-z0-9]+[a-z0-9-]*)*[a-z0-9]+(\.([a-z0-9]+[a-z0-9-]*)*[a-z0-9]+)*\.[a-z]{2,6}$"
<>0
);
Alter Table tbluser
modify MobileNumber varchar(15);
ALTER TABLE tbluser
add constraint MobileNumber check(
length(MobileNumber)=10
);
ALTER TABLE tblexpense
ADD constraint foreign key(UserId) references tbluser(UserId);
ALTER TABLE TotalExp
ADD constraint foreign key(UserId) references tbluser(UserId);


