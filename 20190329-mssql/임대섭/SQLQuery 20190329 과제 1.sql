use haksa;
--아래의 문제에 대해서 각 SQL문장을 작성하세요
--1. 각 학생에 대하여 학생이 받은 장학금의 총액을 조회하세요.
/*
select stu_no as[학번],sum(jang_total) as[장학금의 총액] 
from fee
group by stu_no;
*/
--2. 장학금이 200,000원 이하거나 2007년 08월 01일에 등록한 학생의 장학금을 100,000으로 갱신하세요.
/*
update fee 
set jang_total = '100000' 
where jang_total <=200000 or fee_date= '2007-08-01';
*/

/*
select jang_total
from fee
*/
--3. 각 학생에 대하여 학번, 등록금과 장학금의 차를 조회하세요.
/*
select stu_no, sum(fee_price) - sum(jang_total) as [납입금액]
from fee
group by stu_no;
*/
--4. 1990년 보다 3년 전에 태어난 학생의 학번, 이름, 출생년도를 출력하세요.
/*
select stu_no as[학번], stu_name as[이름], birth_year as[출생년도] 
from student 
where birth_year = 1990 - 3
*/

--5. 1983년부터 1987년까지 태어난 학생의 학번, 이름, 출생년도를 출력하세요.
/*
select stu_no as[학번], stu_name as[이름], birth_year as[출생년도]
from student
where birth_year between '1983' and '1987' order by birth_year;
*/

--6. 학번 20071405 인 학생에게 부과된 모든 등록금에 데이터에 대한 학번, 이름, 등록년도, 등록학기, 등록일자를 조회하세요.
--	단, ansi sql 및 벤더 sql로 작성하세요.
/*
-- ansi sql
select s.stu_no as[학번], s.stu_name as[이름], f.fee_year as[등록년도], f.fee_term as[등록학기], f.fee_date as[등록일자],f.fee_pay as[등록금액]
from student s
inner join fee f
on s.stu_no = f.stu_no
where s.stu_no = '20071405';

--벤더 sql
select s.stu_no as[학번], s.stu_name as[이름], f.fee_year as[등록년도], f.fee_term as[등록학기], f.fee_date as[등록일자],f.fee_pay as[등록금액]
from student s, fee f
where s.stu_no = f.stu_no and s.stu_no = '20071405';
*/

--7. 학번이 20071307 보다 큰 학번의 학생에 대하여 학번과 등록금을 납입한 횟수를 출력하세요.
--   단, 2가지의 다른 SQL로 각각 작성하세요.
/*
select stu_no as[학번], count(fee_price) as[납입 횟수]
from fee
group by stu_no
having stu_no > '20071307';
*/

/*
select s.stu_no as[학번], count (f.fee_div) as[납입 횟수]
from student s
inner join fee f
on s.stu_no = f.stu_no
where s.stu_no > '20071307' group by s.stu_no;
*/

--8. 적어도 한 번 등록을 한 학생의 학번과 이름을 조회하세요.

/*
select distinct s.stu_no as[학번], s.stu_name as[이름]
from student s, fee f
where f.fee_div = 'Y'
*/

--9. 가장 나이가 많은 학생의 학번, 이름, 출생년도를 출력하세요.
--   단, 2가지의 다른 SQL로 각각 작성하세요.
/*
select stu_no as[학번], stu_name as[이름],birth_year as[출생년도] 
from student 
where birth_year <= all(select birth_year from student);

select stu_no as[학번], stu_name as[이름],birth_year as[출생년도] 
from student
where birth_year = (select top(1) birth_year from student group by birth_year)
*/
--10. 가장 나이가 많은 학생을 제외한 학생의 학번, 이름, 생년을 출력하세요.
/*
select stu_no as[학번], stu_name as[이름],birth_year as[출생년도] 
from student 
where not(birth_year <= all(select birth_year from student));
*/

--11. 전라남도 여수지역(우편번호 550)에 살고 있는 학생의 학번, 이름, 현주소의 우편번호 3자리를 가지는 뷰를 생성하세요.
/*
go
create view v_postTbl
as
select s.stu_no, s.stu_name,p.post_no
from student s, post p
where SUBSTRING(p.post_no,1,3) = '550'
go
*/


--12. 재학생의 학번과 이름, 성별, 입학년도, 생년,월,일, 나이에 대한 뷰를 생성하세요.
--    그리고, 각 칼럼에 대해서 적당한 얼리어스를 사용하세요.
/*
go
create view v_studentTbl
as 
   select s.stu_no as [학번], s.stu_name as [이름],
   case 
   when substring(s.id_num, 8, 1)  = 1 then '남'
   when substring(s.id_num, 8, 1)  = 2 then '여' end as [성별], 
   substring(s.stu_no, 1, 4) as [입학년도], s.birth_year as [생년], 
   substring(s.id_num, 3, 2) as [월], substring(s.id_num, 5, 2) as [일],
   DATEDIFF(year, s.birth_year, GETDATE()) as [나이]
   from student s

go
*/

/*
select *
from v_studentTbl
*/


--13. 12번에서 만든 뷰를 사용하여, 21세 이상인 여학생의 학번, 이름, 성별, 출생년도, 나이를 출력하세요.
/*
select 학번,이름,성별,생년,월,일,나이
from v_studentTbl
where 나이 >= 21 and 성별 = '여';
*/

--14. 19세에 해당하는 학생의 성년식 행사를 위한 명단을 출력하세요. 
--    단, 12번에서 만든 뷰를 사용하고, 부족한 부분은 기존의 테이블을 사용하세요.
--    그리고, 출력형식은 학과, 학년, 학번, 이름, 생년,월,일, 나이순으로 출력하세요.
/*
select d.dept_name as[학과], s.grade as[학년],학번, 이름, 생년, 월,일, 나이
from v_studentTbl, student s, department d
where 학번 = s.stu_no
and s.dept_code =d.dept_code
and 나이 = '19'
*/


--15. 12번에서 만든 뷰를 사용하여, 20세 이상이고, 2000년 ~ 2004년에 입학한 학생의 모든 정보를 조회하세요.
/*
select *
from v_studentTbl
where 입학년도 between 2000 and 2004
and 나이 >= 20;
*/


--16. 12번에서 만든 뷰를 삭제하세요.
/*
drop view v_studentTbl
*/
--17. 새로운 과목을 추가하는 문장을 작성하세요. 입력되는 데이터는 임의로 사용하세요.
/*
insert into subject(sub_code,sub_name) values(12345,'경영학개론')
*/
/*
select  sub_code,sub_name
from subject
*/
