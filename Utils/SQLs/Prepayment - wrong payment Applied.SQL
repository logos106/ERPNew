drop table if exists tmp_1;
create table tmp_1 
select Dl.PrepaymentId, abs(sum(DL.Payment))  AppliledAmount
from tbldepositline DL inner join tbldeposits d on D.PaymentId = DL.PaymentID 
where D.Deleted = "F" 
and ifnull(DL.PrepaymentId ,0)<> 0
group by Dl.PrepaymentId;
alter table tmp_1 add column amount float;
update tmp_1  inner join tblprepayments  on tblprepayments.PrePaymentID = tmp_1.PrepaymentId set tmp_1.amount = tblprepayments.PayAmount;
alter table tmp_1 add column Balance float;
update tmp_1  inner join tblprepayments  on tblprepayments.PrePaymentID = tmp_1.PrepaymentId set tmp_1.balance = tblprepayments.balance;
alter table tmp_1 add column PaymentID1 int(11) default 0;
update tmp_1  set PaymentID1 = (select min(tbldepositline.PaymentId) from tbldepositline inner join tbldeposits on tbldeposits.PaymentID = tbldepositline.PaymentID and tbldeposits.Deleted ="F"  where tbldepositline.PrePaymentID = tmp_1.PrepaymentId);
alter table tmp_1 add column deposited1 varchar(1) default "F";
update tmp_1  inner join tbldeposits on tbldeposits.PaymentID = tmp_1.PaymentID1 and tbldeposits.Deposited="T"  set tmp_1.deposited1 = "T";
alter table tmp_1 add column PaymentID2 int(11);
update tmp_1  set PaymentID2 = (select min(tbldepositline.PaymentId) from tbldepositline inner join tbldeposits on tbldeposits.PaymentID = tbldepositline.PaymentID and tbldeposits.Deleted ="F"  where tbldepositline.PrePaymentID = tmp_1.PrepaymentId and tbldepositline.PaymentID <> tmp_1.PaymentID1);
alter table tmp_1 add column deposited2 varchar(1) default "F";
update tmp_1  inner join tbldeposits on tbldeposits.PaymentID = tmp_1.PaymentID2 and tbldeposits.Deposited="T"  set tmp_1.deposited2 = "T";


select * from tmp_1 
where (round(tmp_1.AppliledAmount,2) > round(tmp_1.amount,2))  or 
((round(tmp_1.amount,2)  -round(tmp_1.AppliledAmount,2) ) <> round(tmp_1.balance,2))
order by paymentId1, paymentID2;




