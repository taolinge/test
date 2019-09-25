create table users
(
userid number not null primary key, --�û����
uname nvarchar2(20), --�û���
upwd nvarchar2(20),--����
usex nvarchar2(2),--�Ա�
ubirth date,  --����
utel nvarchar2(20),--�绰
uadd nvarchar2(50),--��ַ
utype number(2)  --1 ����Ա 2 ���� 3 ��ͨ�û�
);

grant create view to cxp;
update users set upwd=999 where  uname='cxp' and upwd='123';

insert into users values(seq_uid.nextval,'qazmlp4610@126.com','qaz4610','��','01-4��-1994','18720987001','������·4��',1);
insert into users values(seq_uid.nextval,'cxp','123','��','01-6��-1999','18720987005','�����´�238��',1);
insert into users values(seq_uid.nextval,'hy','hy123','Ů','21-5��-1991','18720987003','�����´�258��',3);
insert into users values(seq_uid.nextval,'sy','sy123','��','01-6��-1999','18720987005','���ִ��59��',2);
insert into users values(seq_uid.nextval,'za','123','Ů','19-8��-1994','13260158329','��ҵ·18��',1);

--������ͼ
create or replace  view users_view 
as
select userid,uname,usex,floor((sysdate-ubirth)/365) age,utel,decode(utype,1,'����Ա',2,'����',3,'��ͨ�û�') job from users;
select* from users order by userid;
select* from users_view order by userid;

select userid,uname,usex,to_char(ubirth,'YYYY-MM-DD'),utel,uadd,utype from users where uname like '%12%';

create table suppliers
(
sid number primary key,--��Ӧ�̱��
sname nvarchar2(30),--��Ӧ������
scontacts nvarchar2(20),--��ϵ��
stel varchar2(20),--��ϵ�绰
sadd nvarchar2(50),--��ϵ��ַ
sfax varchar2(20),--����
sdesc nvarchar2(50),--����
sdate date --�����ṩ�̵�����
);


insert into suppliers values(seq_sid.nextval,'����','��˿','13934987389','����������','132321','�������ǿ','12-5��-2012');
insert into suppliers values(seq_sid.nextval,'��������','����','13845879487','�麣������','112312','������ǧǿ','1-2��-2002');
insert into suppliers values(seq_sid.nextval,'������ҵ','����','13934987389','��ʢ�ٶ�����','423221','������ǿ','1-9��-2066');

select* from suppliers;
select* from suppliers_view;
create or replace  view suppliers_view 
as
select sid,sname,scontacts,stel,sfax,sdate from suppliers order by sid;

select sid,sname,scontacts,stel,sfax,sdesc from suppliers;

update suppliers set sname='�����',scontacts='����',stel='13988484433' where sid=1007;

--��Ʒ��
create table goods
(
gid number primary key,--��Ʒ���
gname nvarchar2(20),--��Ʒ����
gprice number(10,2),--����
gunit nvarchar2(10),--��λ
sid number references suppliers(sid),--��Ӧ�̱��
gstock number--���
);


insert into goods values(seq_gid.nextval,'��Ƭ',5��'ÿ��',1003,999);
insert into goods values(seq_gid.nextval,'����',8��'ÿ��',1001,879);
insert into goods values(seq_gid.nextval,'����',5999��'ÿ̨',1002,2009);
insert into goods values(seq_gid.nextval,'��Ȫˮ',2��'ÿƿ',1002,1999);
insert into goods values(seq_gid.nextval,'����',4999��'ÿ̨',1001,1009);

insert into goods values(seq_gid.nextval,'��Ƭ',5.2��'ÿ��',1002,999);

select* from goods;
select* from goods_view;

create or replace  view goods_view 
as
select g.gid,g.gname,g.gprice,s.stel,g.gunit from goods g,suppliers s
where g.sid=s.sid
order by gid;

--������
create table orders
(
oid number primary key,--�������
gid number references goods(gid), --��Ʒ���
onum number not null, --��Ʒ����
odate date, --��������ʱ��
opaid number  --0 δ���� 1 �Ѹ���
);


insert into orders values(seq_oid.nextval,1002,2,'3-2��-2010',1);
insert into orders values(seq_oid.nextval,1003,32,'3-2��-2011',0);
insert into orders values(seq_oid.nextval,1004,22,'13-9��-2009',0);
insert into orders values(seq_oid.nextval,1005,32,'23-6��-2012',1);


select * from orders order by oid;
select* from orders_view;
select* from orders_detail where oid=1003;

--������ͼ
create or replace  view orders_view 
as
select o.oid,g.gname,s.sname,o.onum*g.gprice costs,o.odate,decode(o.opaid,0,'δ����',1,'�Ѹ���') paid from orders o,goods g,suppliers s 
where o.gid=g.gid and g.sid=s.sid
order by o.oid;

create or replace  view orders_detail 
as
select o.oid,g.gname,g.gunit,o.onum, o.onum*g.gprice costs,s.sname,decode(o.opaid,0,'δ����','�Ѹ���') paid from orders o,goods g,suppliers s
where o.gid=g.gid and g.sid=s.sid
order by o.oid;



select g.gid,g.gname,s.sname from goods g,suppliers s where g.sid=s.sid and g.gname='����'and s.sname='��������';
select s.sid,s.sname,g.gname from goods g,suppliers s where g.sid=s.sid and g.gname=(select  gname from goods where gid=(select gid from orders where oid=1003));
select s.sid,s.sname from goods g,suppliers s where g.sid=s.sid and g.gname=(select  gname from goods where gid=1005);

update orders set gid=1003,onum=2,opaid=0  where oid=1001;


--��������
create sequence seq_uid start with 1000 nocache;
create sequence seq_sid start with 1000 nocache;
create sequence seq_gid start with 1000 nocache;
create sequence seq_oid start with 1000 nocache;

select seq_uid.nextval from dual;

commit;
----------��ɾ��
drop table users;
drop table orders;
drop table goods;
drop table suppliers;

drop sequence seq_uid;
drop sequence seq_sid;
drop sequence seq_gid;
drop sequence seq_oid;
