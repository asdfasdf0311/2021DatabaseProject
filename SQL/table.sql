#�а����̺�
create table department(
dept_code int(2) Not null,            #�а���ȣ
dept_name char(30) Not null,          #�а���
dept_ename varchar(50),               #�а������̸�
create_date date default null,        #�а�������¥
primary key (dept_code)
)engine = innoDB;


#����(�л��Ż�)���̺�
create table student(
stu_no char(10) Not null,             #�й�
stu_name char(10) Not null,           #�л��̸�
stu_ename varchar(30),                #�����̸�
dept_code int(2) Not null,            #�а��ڵ�
grade int(1) Not null,                #�г�
class int (1) Not null,               #��
juya char(4),                         #�־߱���
birthday varchar(10),                 #������� (���� : 19880912)
gender varchar(1) not null,           #����(���� : ����(1,3,5), ����(2,4,6))
post_no varchar(5),                   #�����ȣ
address varchar(100),                 #�ּ�
tel1 varchar(3),                      #����ȭ ����
tel2 varchar(4),                      #����ȭ ��
tel3 varchar(4),                      #����ȭ ��ȣ
mobile varchar(14),                   #�޴���ȭ��ȣ
primary key (stu_no),
constraint s_dp_fk foreign key(dept_code)  #�ܷ�Ű �а� ���̺��� �а��ڵ�
references department(dept_code)
) engine = innoDB;

#������û
create table attend(
stu_no char(10) Not null,              #�й�
att_year char(4) Not null,             #�����⵵
att_term int(1) Not null,              #�����б�
att_isu int(1) Not null,               #�̼�����
sub_code char(5) Not null,             #�����ڵ�
prof_code char(4) Not null,            #�����ڵ�
att_point int(1) Not null,             #�̼�����
att_grade int(3) default '0',          #�������
att_div char(1) default 'N' Not null,  #������û����
att_jae char(1) default '1',           #����� ���� 1(���б� ����), 2(�����), 3(�����б� ����) 
att_date date Not null,                #����ó������
primary key (stu_no, att_year, att_term, sub_code, prof_code, att_jae)
) engine = innoDB;

#��ϱ����̺�
create table fee(
stu_no varchar(10) Not null,            #�й�
fee_year varchar(4) Not null,           #��ϳ⵵
fee_term int(1) Not null,               #����б�
fee_enter int(7),                       #���б�
fee_price int(7) Not null,              #��ϱ�(������)
fee_total int(7) Default '0' Not null,  #��ϱ��Ѿ�=���б�+������
jang_code char(2) Null,                 #�����ڵ�
jang_total int(7),                      #���бݾ�
fee_pay int(7) Default '0' Not null,    #�����Ѿ�=��ϱ��Ѿ�-���бݾ�
fee_div char(1) Default 'N' Not null,   #��ϱ���
fee_date date Not null,                 #��ϳ�¥
primary key (stu_no, fee_year, fee_term)
) engine = innoDB;

#�������̺�
create table score(
stu_no char(10) Not null,                #�й�
sco_year char(4) Not null,               #�������⵵
sco_term int(1) Not null,                #�б�
req_point int(2),                        #��û����
take_point int(2),                       #�������
exam_avg float(2,1),                     #�������
exam_total int(4),                       #����� ����
sco_div char(1),                         #��������
sco_date date,                           #����ó������
primary key (stu_no, sco_year, sco_term)
) engine = innoDB;

#���������̺�
create table subject(
sub_code char(5) Not null,            #�����ȣ
sub_name varchar(50) Not null,        #�����
sub_ename varchar(50),                #���������
create_year char(4),                  #�����⵵
primary key (sub_code)
)engine = innoDB;


#�������̺�
create table professor(
prof_code char(4) Not null,           #������ȣ
prof_name char(10) Not null,          #������
prof_ename varchar(30),               #���������̸�
create_date date default null,        #�����ӿ볯¥
primary key (prof_code)
)engine = innoDB;


#���Ƹ����̺�
create table circle(
cir_num int(4) Not null auto_increment,  #���Ƹ����Թ�ȣ
cir_name char(30) Not null,              #���Ƹ���
stu_no char(10) Not Null,                #�й�
stu_name char(10) Not Null,              #�̸�
president char(1) default '2' Not null,  #���Ƹ�ȸ��(0), ��ȸ��(1), ȸ��(2)
primary key (cir_num)
)engine = innoDB;

#���θ� �����ȣ���̺�
create table post(
post_no varchar(6) Not null,         #������ȣ          1 �ſ����ȣ
sido_name varchar(20) Not null,      #�õ���            2
sido_eng varchar(40) Not null,       #�õ�����          3
sigun_name varchar(20) Not null,     #�ñ�����          4
sigun_eng varchar(40) Not null,      #�ñ�������        5
rowtown_name varchar(20) Not null,   #����             6
rowtown_eng varchar(40) Not null,    #���鿵��          7
road_code varchar(12),               #���θ��ڵ�        8 (�ñ����ڵ�(5)+���θ��ȣ(7))
road_name varchar(80),               #���θ�           9 
road_eng varchar(80),                #���ο�����        10
underground_gubun varchar(1),        #���Ͽ���          11 (0 : ����, 1 : ����, 2 : ����)
building_bon int(5),                 #�ǹ���ȣ����      12
building_boo int(5),                 #�ǹ���ȣ�ι�      13
management_no varchar(25) Not null,  #�ǹ�������ȣ      14  
baedal varchar(40),                  #�ٷ����ó��      15 (NULL)
town_building varchar(200),          #�ñ����� �ǹ���   16
row_code varchar(10) Not null,       #�������ڵ�        17
row_dongname varchar(20),            #��������          18
ri_name varchar(20),                 #����              19
administration_name varchar(40),     #��������          20
mountain_gubun varchar(1),           #�꿩��            21 (0 : ����, 1 : ��)
bungi int(4),                        #��������(����)     22
town_no varchar(2),                  #���鵿�Ϸù�ȣ     23
ho int(4),                           #�����ι�(ȣ)      24
gu_post_no varchar(6),               #�� �����ȣ       25 (NULL)
post_seq varchar(3),                 #�����Ϸù�ȣ       26 (NULL)
primary key (management_no)
)engine = innoDB;
