use haksa;
--�Ʒ��� ������ ���ؼ� �� SQL������ �ۼ��ϼ���
--1. �� �л��� ���Ͽ� �л��� ���� ���б��� �Ѿ��� ��ȸ�ϼ���.
/*
select stu_no as[�й�],sum(jang_total) as[���б��� �Ѿ�] 
from fee
group by stu_no;
*/
--2. ���б��� 200,000�� ���ϰų� 2007�� 08�� 01�Ͽ� ����� �л��� ���б��� 100,000���� �����ϼ���.
/*
update fee 
set jang_total = '100000' 
where jang_total <=200000 or fee_date= '2007-08-01';
*/

/*
select jang_total
from fee
*/
--3. �� �л��� ���Ͽ� �й�, ��ϱݰ� ���б��� ���� ��ȸ�ϼ���.
/*
select stu_no, sum(fee_price) - sum(jang_total) as [���Աݾ�]
from fee
group by stu_no;
*/
--4. 1990�� ���� 3�� ���� �¾ �л��� �й�, �̸�, ����⵵�� ����ϼ���.
/*
select stu_no as[�й�], stu_name as[�̸�], birth_year as[����⵵] 
from student 
where birth_year = 1990 - 3
*/

--5. 1983����� 1987����� �¾ �л��� �й�, �̸�, ����⵵�� ����ϼ���.
/*
select stu_no as[�й�], stu_name as[�̸�], birth_year as[����⵵]
from student
where birth_year between '1983' and '1987' order by birth_year;
*/

--6. �й� 20071405 �� �л����� �ΰ��� ��� ��ϱݿ� �����Ϳ� ���� �й�, �̸�, ��ϳ⵵, ����б�, ������ڸ� ��ȸ�ϼ���.
--	��, ansi sql �� ���� sql�� �ۼ��ϼ���.
/*
-- ansi sql
select s.stu_no as[�й�], s.stu_name as[�̸�], f.fee_year as[��ϳ⵵], f.fee_term as[����б�], f.fee_date as[�������],f.fee_pay as[��ϱݾ�]
from student s
inner join fee f
on s.stu_no = f.stu_no
where s.stu_no = '20071405';

--���� sql
select s.stu_no as[�й�], s.stu_name as[�̸�], f.fee_year as[��ϳ⵵], f.fee_term as[����б�], f.fee_date as[�������],f.fee_pay as[��ϱݾ�]
from student s, fee f
where s.stu_no = f.stu_no and s.stu_no = '20071405';
*/

--7. �й��� 20071307 ���� ū �й��� �л��� ���Ͽ� �й��� ��ϱ��� ������ Ƚ���� ����ϼ���.
--   ��, 2������ �ٸ� SQL�� ���� �ۼ��ϼ���.
/*
select stu_no as[�й�], count(fee_price) as[���� Ƚ��]
from fee
group by stu_no
having stu_no > '20071307';
*/

/*
select s.stu_no as[�й�], count (f.fee_div) as[���� Ƚ��]
from student s
inner join fee f
on s.stu_no = f.stu_no
where s.stu_no > '20071307' group by s.stu_no;
*/

--8. ��� �� �� ����� �� �л��� �й��� �̸��� ��ȸ�ϼ���.

/*
select distinct s.stu_no as[�й�], s.stu_name as[�̸�]
from student s, fee f
where f.fee_div = 'Y'
*/

--9. ���� ���̰� ���� �л��� �й�, �̸�, ����⵵�� ����ϼ���.
--   ��, 2������ �ٸ� SQL�� ���� �ۼ��ϼ���.
/*
select stu_no as[�й�], stu_name as[�̸�],birth_year as[����⵵] 
from student 
where birth_year <= all(select birth_year from student);

select stu_no as[�й�], stu_name as[�̸�],birth_year as[����⵵] 
from student
where birth_year = (select top(1) birth_year from student group by birth_year)
*/
--10. ���� ���̰� ���� �л��� ������ �л��� �й�, �̸�, ������ ����ϼ���.
/*
select stu_no as[�й�], stu_name as[�̸�],birth_year as[����⵵] 
from student 
where not(birth_year <= all(select birth_year from student));
*/

--11. ���󳲵� ��������(�����ȣ 550)�� ��� �ִ� �л��� �й�, �̸�, ���ּ��� �����ȣ 3�ڸ��� ������ �並 �����ϼ���.
/*
go
create view v_postTbl
as
select s.stu_no, s.stu_name,p.post_no
from student s, post p
where SUBSTRING(p.post_no,1,3) = '550'
go
*/


--12. ���л��� �й��� �̸�, ����, ���г⵵, ����,��,��, ���̿� ���� �並 �����ϼ���.
--    �׸���, �� Į���� ���ؼ� ������ �󸮾�� ����ϼ���.
/*
go
create view v_studentTbl
as 
   select s.stu_no as [�й�], s.stu_name as [�̸�],
   case 
   when substring(s.id_num, 8, 1)  = 1 then '��'
   when substring(s.id_num, 8, 1)  = 2 then '��' end as [����], 
   substring(s.stu_no, 1, 4) as [���г⵵], s.birth_year as [����], 
   substring(s.id_num, 3, 2) as [��], substring(s.id_num, 5, 2) as [��],
   DATEDIFF(year, s.birth_year, GETDATE()) as [����]
   from student s

go
*/

/*
select *
from v_studentTbl
*/


--13. 12������ ���� �並 ����Ͽ�, 21�� �̻��� ���л��� �й�, �̸�, ����, ����⵵, ���̸� ����ϼ���.
/*
select �й�,�̸�,����,����,��,��,����
from v_studentTbl
where ���� >= 21 and ���� = '��';
*/

--14. 19���� �ش��ϴ� �л��� ����� ��縦 ���� ����� ����ϼ���. 
--    ��, 12������ ���� �並 ����ϰ�, ������ �κ��� ������ ���̺��� ����ϼ���.
--    �׸���, ��������� �а�, �г�, �й�, �̸�, ����,��,��, ���̼����� ����ϼ���.
/*
select d.dept_name as[�а�], s.grade as[�г�],�й�, �̸�, ����, ��,��, ����
from v_studentTbl, student s, department d
where �й� = s.stu_no
and s.dept_code =d.dept_code
and ���� = '19'
*/


--15. 12������ ���� �並 ����Ͽ�, 20�� �̻��̰�, 2000�� ~ 2004�⿡ ������ �л��� ��� ������ ��ȸ�ϼ���.
/*
select *
from v_studentTbl
where ���г⵵ between 2000 and 2004
and ���� >= 20;
*/


--16. 12������ ���� �並 �����ϼ���.
/*
drop view v_studentTbl
*/
--17. ���ο� ������ �߰��ϴ� ������ �ۼ��ϼ���. �ԷµǴ� �����ʹ� ���Ƿ� ����ϼ���.
/*
insert into subject(sub_code,sub_name) values(12345,'�濵�а���')
*/
/*
select  sub_code,sub_name
from subject
*/
