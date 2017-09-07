-- 이부분은 참고만 하세요.
CREATE TABLE dept (
  dept_no int(11) NOT NULL,
  dept_name varchar(32) NOT NULL,
  PRIMARY KEY (dept_no)
) ENGINE=InnoDB;
CREATE TABLE emp (
  emp_no int(11)  NOT NULL,
  dept_no int(11)  NOT NULL,
  emp_name varchar(32) NOT NULL,
  PRIMARY KEY  (emp_no),
  FOREIGN KEY (dept_no) REFERENCES dept (dept_no)
) ENGINE=InnoDB;

INSERT INTO dept (dept_no, dept_name) VALUES ('1001', '인사부');
INSERT INTO dept (dept_no, dept_name) VALUES ('1002', '영업부');
INSERT INTO dept (dept_no, dept_name) VALUES ('1003', '생산부');

INSERT INTO emp (emp_no, dept_no, emp_name) VALUES ('2012001', '1001', '한놈');
INSERT INTO emp (emp_no, dept_no, emp_name) VALUES ('2012002', '1003', '두시기');
INSERT INTO emp (emp_no, dept_no, emp_name) VALUES ('2012003', '1003', '석삼');

select * from emp where dept_no=1001;

select * from movie;

drop table dept;
drop table emp;
-- 이부분은 참고만 하세요.

-- drop table
drop table admin;
drop table notice;
drop table movie;
drop table movie_reply;
drop table banner;

-- create table
-- admin
create table admin(
	id varchar(30) not null primary key,
	pw varchar(30) not null,
	reg_date datetime not null
);

-- notice
create table notice(
	n_id int not null primary key auto_increment,
	n_title varchar(100) not null,
	n_contents text not null,
	n_file varchar(50) default 'no_img.jpg',
	n_reg_date datetime not null
);

-- banner
create table banner(
	banner_id int not null primary key auto_increment,
	banner_name varchar(100) not null,
	banner_file varchar(50) default 'no_img.jpg'
);

insert into banner(banner_name, banner_file) values('배너1','banner_1.png');
insert into banner(banner_name, banner_file) values('배너2','banner_2.png');
insert into banner(banner_name, banner_file) values('배너3','banner_2.png');
select * from banner;
delete from banner;
-- movie 등록번호,영화장르,영화등급,영화제목,상영기간,영화포스터,관객수,영화내용,등록날짜
create table movie(
	m_id int not null primary key auto_increment,
	m_title varchar(100) not null,
	m_kind varchar(16) not null,
	m_grade varchar(1) not null,
	m_date varchar(23) not null,
	m_youtube varchar(100) not null,
	m_file varchar(50) default 'no_img.jpg' not null,
	m_count int not null,
	m_contents text not null,
	m_reg_date datetime not null
)ENGINE=InnoDB;

--movie_reply
create table movie_reply(
	m_re_id int not null primary key auto_increment,
	m_re_nickname varchar(50)not null,
	m_re_email varchar(100)not null,
	m_re_star varchar(1) not null,
	m_re_contents text not null,
	m_re_reg_date datetime not null,
	m_id int not null,
	foreign key(m_id) references movie (m_id) ON DELETE CASCADE
)ENGINE=InnoDB;
-- create table

-- admin
insert into admin values('admin','1111',now());
insert into admin values('admin2','1111',now());
insert into admin values('admin3','1111',now());
insert into admin values('admin4','1111',now());

select * from admin;
select count(*) as cnt from admin where id='admin' and pw='1111';
select * from admin order by reg_date;
select count(*) from admin;
select count(*) as cnt from admin where id='admin';

delete from admin;
delete from admin where id='admin';

-- notice
insert into notice(n_title,n_contents,n_file,n_reg_date) values('공지사항1','공지사항1입니다.','poster.gif',now());
insert into notice(n_title,n_contents,n_file,n_reg_date) values('공지사항2','공지사항2입니다.','영화동영상.txt',now());
insert into notice(n_title,n_contents,n_file,n_reg_date) values('공지사항3','공지사항3입니다.','movie_image.jpg',now());
insert into notice(n_title,n_contents,n_file,n_reg_date) values('공지사항4','공지사항4입니다.',null,now());
insert into notice(n_title,n_contents,n_file,n_reg_date) values('공지사항5','공지사항5입니다.','poster.gif',now());
insert into notice(n_title,n_contents,n_file,n_reg_date) values('공지사항6','공지사항6입니다.','movie_image2.jpg',now());

select * from notice where n_title like '%%' order by n_id desc limit 0, 5;
select count(*) from notice where n_title like '%%';
select * from notice where n_id=1;
update notice set n_title='공지사항1', n_contents='공지사항1입니다', n_file='poster.gif' where n_id=1;
delete from notice where n_id=1;
delete from notice;

-- movie    
insert into movie(m_title,m_kind,m_grade,m_date,m_youtube,m_file,m_count,m_contents,m_reg_date) values
('신비한 동물사전','2','2','2016/11/16 - 2016/11/30','https://www.youtube.com/embed/pZ4lBl-x6HE','movie_image.jpg',3572062,'해리 포터',now());
insert into movie(m_title,m_kind,m_grade,m_date,m_youtube,m_file,m_count,m_contents,m_reg_date) values
('닥터스트레인져','2,4','2','2016/10/26 - 2016/11/30','https://www.youtube.com/embed/e5MyKRM7zWk','movie_image2.jpg',5408565,'닥터스트레인져',now());
insert into movie(m_title,m_kind,m_grade,m_date,m_youtube,m_file,m_count,m_contents,m_reg_date) values
('가려진 시간','1,2','2','2016/11/16 - 2016/11/30','https://www.youtube.com/embed/7m6lVbTgaxU','movie_image3.jpg',502599,'가려진 시간',now());
insert into movie(m_title,m_kind,m_grade,m_date,m_youtube,m_file,m_count,m_contents,m_reg_date) values
('감바의 대모험','3','1','2016/11/10 - 2016/11/30','https://www.youtube.com/embed/uPCKG_9HBoM','movie_image4.jpg',109844,'감바의 대모험',now());
insert into movie(m_title,m_kind,m_grade,m_date,m_youtube,m_file,m_count,m_contents,m_reg_date) values
('럭키','5','3','2016/10/13 - 2016/11/30','https://www.youtube.com/embed/_xF4OwIMNfI','movie_image5.jpg',6973132,'럭키',now());
insert into movie(m_title,m_kind,m_grade,m_date,m_youtube,m_file,m_count,m_contents,m_reg_date) values
('형','1,5','2','2016/11/23 - 2016/11/30','https://www.youtube.com/embed/2fC99tRTVKM','movie_image6.jpg',1286057,'형',now());

select * from movie;
select m.*,
	(select count(*) from movie_reply where m_id=m.m_id) as m_re_total,
	(select round(avg(m_re_star)) from movie_reply where m_id=m.m_id) as m_re_star
from movie m order by m_count desc limit 0, 4;
select m.*,
	(select count(*) from movie_reply where m_id=m.m_id) as m_re_total,
	(select round(avg(m_re_star)) from movie_reply where m_id=m.m_id) as m_re_star
from movie m where m_id like '%%' order by m_count desc;
select m.*,(select count(*) from movie_reply where m_id=m.m_id) as m_re_total from movie m where m.m_id=1;
select count(*) from movie where m_title like '%%';
delete from movie where m_id=1;
update movie set m_title='신비한 동물사전', m_kind='2', m_grade='2', m_date='2016/11/16 - 2016/11/30', m_youtube='https://www.youtube.com/embed/pZ4lBl-x6HE', m_file='movie_image.jpg', m_contents='줄거리' where m_id=1;

-- movie_reply
insert into movie_reply (m_re_nickname, m_re_email, m_re_star, m_re_contents, m_re_reg_date, m_id)values('test1','test1@naver.com','1', '완전별로임', now(), 1);
insert into movie_reply (m_re_nickname, m_re_email, m_re_star, m_re_contents, m_re_reg_date, m_id)values('test2','test2@naver.com','2', '그닥', now(), 1);
insert into movie_reply (m_re_nickname, m_re_email, m_re_star, m_re_contents, m_re_reg_date, m_id)values('test3','test3@naver.com','3', '보통입니다.', now(), 1);
insert into movie_reply (m_re_nickname, m_re_email, m_re_star, m_re_contents, m_re_reg_date, m_id)values('test4','test4@naver.com','4', '재밌어요.', now(), 1);
insert into movie_reply (m_re_nickname, m_re_email, m_re_star, m_re_contents, m_re_reg_date, m_id)values('test5','test5@naver.com','5', '완전짱', now(), 1);
insert into movie_reply (m_re_nickname, m_re_email, m_re_star, m_re_contents, m_re_reg_date, m_id)values('test6','test5@naver.com','5', '완전짱', now(), 2);

select * from movie_reply where m_id=1 order by m_re_id desc limit 0,5;
select count(*) from movie_reply where m_id=1;
select round(avg(m_re_star)) from movie_reply where m_id=1;
select count(*) from movie_reply where m_re_nickname='test1' and m_id=1;
delete from movie_reply where m_re_id=1;
update movie_reply set m_re_star='3', m_re_contents='보통입니다.', m_re_reg_date=now() where m_re_id=1;

