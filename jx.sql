--Oracle�е������ֶ����ͣ�

�ֶ����� ����˵�� �������� ����˵��     

CHAR �̶������ַ��� ��󳤶�2000bytes       
VARCHAR2 �ɱ䳤�ȵ��ַ��� ��󳤶�4000bytes     ������������󳤶�749     
NCHAR �����ַ��������Ĺ̶������ַ��� ��󳤶�2000bytes         
NVARCHAR2 �����ַ��������Ŀɱ䳤���ַ��� ��󳤶�4000bytes         
DATE ���ڣ���-��-�꣩DD-MM-YY��HH-MI-SS��    
LONG �����ַ��� ��󳤶�2G��231-1�� �㹻�洢��ͷ������������ʹ�ã�
RAW �̶����ȵĶ��������� ��󳤶�2000bytes �ɴ�Ŷ�ý��ͼ��������     
LONG RAW �ɱ䳤�ȵĶ��������� ��󳤶�2G �ɴ�Ŷ�ý��ͼ��������  
BLOB ���������� ��󳤶�4G 
CLOB �ַ����� ��󳤶�4G 
NCLOB �����ַ����������ַ����� ��󳤶�4G       
BFILE ��������ݿ���Ķ��������� ��󳤶�4G  
ROWID ���ݱ��м�¼��Ψһ�к� 10 bytes 
NROWID ���������ݱ��м�¼��Ψһ�к� ��󳤶�4000bytes 
NUMBER(P,S) ��������   PΪ����λ��SΪС��λ     
DECIMAL(P,S)   ��������   PΪ����λ��SΪС��λ     
INTEGER   ��������   С������ 
FLOAT   ����������   NUMBER(38)��˫���� 
REAL ʵ������   NUMBER(63)�����ȸ���

--����jx���ݿ�
exp jx/jx owner=jx file=E:\workspace\jx.dmp

--�ָ�jx���ݿ�
imp jx/jx file=E:\workspace\jx.dmp log=E:\workspace\jx.log fromuser=jx touser=jx ignore=y

--ɾ���û�X��������ص�����
drop user jx cascade;

--���Oracle����վ
PURGE RECYCLEBIN; 

--�����û�
CREATE   USER  jx IDENTIFIED  BY  jx
DEFAULT  TABLESPACE users
TEMPORARY  TABLESPACE temp;
--���û�����Ȩ��
GRANT resource,connect to jx;

--GRANT  
--���� CREATE  SESSION,  CREATE   ANY   TABLE ,  CREATE   ANY   VIEW  , CREATE   ANY   INDEX ,  CREATE   ANY   PROCEDURE ,
--���� ALTER   ANY   TABLE ,  ALTER   ANY   PROCEDURE ,
--���� DROP   ANY   TABLE ,  DROP   ANY   VIEW ,  DROP   ANY   INDEX ,  DROP   ANY   PROCEDURE ,
--���� SELECT   ANY   TABLE ,  INSERT   ANY   TABLE ,  UPDATE   ANY   TABLE ,  DELETE   ANY   TABLE
--���� TO  jx;

--=================================================================================

-- contains ����(in_str:���������ַ���,in_sub��Ҫ�������ַ���
CREATE OR REPLACE FUNCTION contains
(
 in_str varchar2,
 in_sub varchar2
)
return integer
is
  i integer;
  rs_num integer;
begin
  i := 0;
  if in_str is null or in_sub is null or length(in_str) = 0 or 
     length(in_sub) = 0 or length(in_str)-length(in_sub) < 0 
     then
         --dbms_output.put_line('x,,');
     return -1;
  end if;
  --dbms_output.put_line('dox,,');
  loop
     i :=i+1;
     exit when i=length(in_str)-length(in_sub)+1 or substr(in_str,i,length(in_sub)) = in_sub;
  end loop;
  
  --dbms_output.put_line(i||'__'||substr(in_str,i,length(in_sub)));
  
  if substr(in_str,i,length(in_sub)) = in_sub  then
    rs_num := i;
  else
    rs_num := -1;
  end if;
  return rs_num;
end contains; 

/**��ҳ���*-----------------------------------------------------------------------------------------------------*/
create or replace package REFCURSOR_PKG   as
    TYPE   refCursorType   IS   REF   CURSOR; 
end   REFCURSOR_PKG;

--��÷�ҳ����ҳ��������Ĳ���ΪallPageRows/singPageRows
CREATE OR REPLACE FUNCTION get_pageCount
(
 in_num number
)
return integer
is
  i integer;
  rs_num integer; 
  in_str varchar2(100);
begin 
  in_str := in_num||'';
  if substr(in_str,1,1) = '.' then 
     in_str := '0'||in_str;
  end if;
  i := 0;
  loop
     i :=i+1;
     exit when i=length(in_str) or substr(in_str,i,1) = '.'; 
  end loop; 
  if i<>length(in_str) then 
    rs_num := substr(in_str,1,i-1);
    rs_num := rs_num + 1;
  else 
    rs_num := in_num;
  end if;
  return rs_num;
end get_pageCount;

--��ҳ�洢����
CREATE OR REPLACE PROCEDURE Pagination
(
     v_page_size  int, --the size of a page of list
     v_current_page int, --the current page of list 
     v_subSql  varchar2, --the select sql for all page 
     v_out_allRowsCount OUT int, --the num of all page rows
     v_out_currentRowsCount OUT int, --the num of current page rows
     v_out_allPageCount OUT int, -- the num of all page count 
     p_cursor OUT refcursor_pkg.refCursorType
 )
 as 
     v_sql     varchar2(3000); --the sql for current
     v_endnum  int; --the end row num of the current page
     v_startnum int; --the start row num of the current page
     allRowsCountSql varchar2(3000);
     currentRowsCountSql varchar2(3000); 
BEGIN
 
 ----all rows
 allRowsCountSql := 'SELECT COUNT(ROWNUM) FROM ('||v_subSql||')'; 
 execute immediate allRowsCountSql into v_out_allRowsCount;
 v_endnum:= v_current_page * v_page_size; 
 v_startnum := v_endnum - v_page_size + 1;
 
 ----the sql for curren page 
 v_sql := 'select * from(SELECT subTable.*,rownum subRowNum FROM('||v_subSql
       ||') subTable ) where subRowNum >='||v_startnum||' and subRowNum<='||v_endnum;
 Dbms_Output.put_line(v_sql);
 currentRowsCountSql := 'SELECT COUNT(ROWNUM) FROM ('||v_sql||')'; 
 execute immediate currentRowsCountSql into v_out_currentRowsCount;
 v_out_allPageCount := get_pageCount(v_out_allRowsCount/v_page_size);
 open p_cursor for v_sql;
END Pagination;
/**��ҳ���*-----------------------------------------------------------------------------------------------------*/


/*��ɫ��*/
create table jx_m_js
( 
  DH   INTEGER not null primary key , 
  MC   VARCHAR2(20) not null unique ,
  MKS VARCHAR2(120)
);
comment on table jx_m_js is '��ɫ��';
comment on column jx_m_js.dh is '��ɫ����';
comment on column jx_m_js.mc is '��ɫ����';
comment on column jx_m_js.mks is '��ɫ��ӵ�е�ģ�鼯';

/**ģ���**/
create table jx_m_mk
( 
  DH   INTEGER not null primary key ,  
  NM VARCHAR2(20) not null,
  PDH INTEGER default 0 not null
);
comment on table jx_m_mk is 'ģ���';
comment on column jx_m_mk.dh is 'ģ�����';
comment on column jx_m_mk.nm is 'ģ������';
comment on column jx_m_mk.pdh is '�ϼ�ģ�����';

/*������*/
create table jx_m_cz
( 
  DH   INTEGER not null primary key , 
  NM VARCHAR2(30) not null,
  URI  VARCHAR2(120) ,
  MTD  VARCHAR2(20),
  MK INTEGER default 0 not null,
  foreign key (MK) references jx_m_mk(DH)
);
comment on table jx_m_cz is '���������';
comment on column jx_m_cz.dh is '��������';
comment on column jx_m_cz.nm is '��������';
comment on column jx_m_cz.uri is '������ַ';
comment on column jx_m_cz.mtd is '��������';
comment on column jx_m_cz.mk is '����ģ��'; 


/**Ȩ�ޱ�**/
create table jx_m_qx
(
  JSDH  INTEGER not null ,
  CZDH INTEGER not null,
  QX CHAR(1) default 0 not null,
  XS CHAR(1) default 1 not null,
  foreign key (JSDH) references  jx_m_js(DH) on delete cascade,
  foreign key (CZDH) references  jx_m_cz(DH) on delete cascade
);
comment on table jx_m_qx is '����Ȩ�ޱ�';
comment on column jx_m_qx.jsdh is '��ɫ����';
comment on column jx_m_qx.czdh is '��������';
comment on column jx_m_qx.qx is '�Ƿ�Ըò�����Ȩ��(0:��Ȩ��,1:��Ȩ��)';
comment on column jx_m_qx.xs is '�Ƿ��ڽ�����ʾ��������(0:����ʾ,1:��ʾ)';

/*�û���*/ 
create table jx_m_yh
( 
  ZH   VARCHAR2(18) not null primary key , 
  MM       VARCHAR2(32) not null  ,
  XM    VARCHAR2(15)  ,
  XB     char(1) not null  ,
  YX     VARCHAR2(30) not null  unique,
  DH    VARCHAR2(13)  ,
  CSRQ  date  ,
  ZCSJ   DATE default sysdate,
  ZHDL   DATE default sysdate,
  JSDH INTEGER default 0 ,
  MMBHWT INTEGER not null ,
  MMBHDA VARCHAR2(30) not null,
  SFJH   CHAR(1) default 0 not null,
  GRJJ   VARCHAR2(30),
  BZ     VARCHAR2(20),
  foreign key (JSDH) references  jx_m_js(DH)
);
comment on table jx_m_yh is '�û���';
comment on column jx_m_yh.zh is '�˺�';
comment on column jx_m_yh.mm is '����';
comment on column jx_m_yh.xm is '��ʵ�������ǳ�';
comment on column jx_m_yh.xb is '�Ա�';
comment on column jx_m_yh.yx is '����';
comment on column jx_m_yh.dh is '��ϵ�绰';
comment on column jx_m_yh.csrq is '��������';
comment on column jx_m_yh.zcsj is 'ע��ʱ��';
comment on column jx_m_yh.zhdl is '����¼ʱ��';
comment on column jx_m_yh.jsdh is '������ɫ';
comment on column jx_m_yh.mmbhwt is '���뱣���������';
comment on column jx_m_yh.mmbhda is '���뱣����';
comment on column jx_m_yh.sfjh is '�Ƿ��Ѽ���(0-δ����,1-�Ѽ���,2-�ѽ���)';
comment on column jx_m_yh.grjj is '���˼��';
comment on column jx_m_yh.bz is '�����ֶ�';

/*�������ͱ�*/
create table jx_w_wzlx
(
  DH INTEGER not null primary key , 
  LXMC VARCHAR2(20) not null  unique,
  PDH INTEGER default 0 not null,
  MK INTEGER default 0 not null,
  TOPDH VARCHAR2(100) default '$' not null,
  foreign key (MK) references  jx_m_mk(DH) 
);
comment on table jx_w_wzlx is '�������ͱ�';
comment on column jx_w_wzlx.dh is '���ͱ��';
comment on column jx_w_wzlx.lxmc is '��������';
comment on column jx_w_wzlx.pdh is '�ϼ�����';
comment on column jx_w_wzlx.mk is '����ģ��';
comment on column jx_w_wzlx.topdh is '�ö������б�';

/*���±�*/
create table jx_w_wz
(
  DH INTEGER not null primary key , 
  BT VARCHAR2(30) not null  unique,
  ZZ  VARCHAR2(18) not null,
  LX INTEGER not null,
  NR CLOB,
  FBRQ DATE default sysdate,
  GXRQ DATE default sysdate,
  TP  VARCHAR2(500),
  foreign key (LX) references  jx_w_wzlx(DH),
  foreign key (ZZ) references  jx_m_yh(ZH)
);
comment on table jx_w_wz is '���±�';
comment on column jx_w_wz.dh is '���±��';
comment on column jx_w_wz.bt is '���±���';
comment on column jx_w_wz.zz is '��������';
comment on column jx_w_wz.lx is '��������';
comment on column jx_w_wz.nr is '��������';
comment on column jx_w_wz.fbrq is '��������';
comment on column jx_w_wz.gxrq is '��������';
comment on column jx_w_wz.tp is 'ͼƬ��ַ';

/*ͼƬ���ͱ�*/
create table jx_w_tplx
(
  DH INTEGER not null primary key , 
  LXMC VARCHAR2(20) not null  unique,
  PDH INTEGER default 0 not null,
  MK INTEGER default 0 not null,
  foreign key (MK) references  jx_m_mk(DH)
);
comment on table jx_w_tplx is 'ͼƬ���ͱ�';
comment on column jx_w_tplx.dh is '���ͱ��';
comment on column jx_w_tplx.lxmc is '��������';
comment on column jx_w_tplx.pdh is '�ϼ�����';
comment on column jx_w_tplx.mk is '����ģ��';

/*ͼƬ��*/ 
create table jx_w_tp
(
  DH INTEGER not null primary key , 
  ALT VARCHAR2(20) not null  unique,
  ZZ  VARCHAR2(18) not null,
  LX INTEGER not null,
  WZ INTEGER ,
  SCRQ DATE default sysdate,
  GXRQ DATE default sysdate,
  NR CLOB,
  SX INTEGER default 1,
  foreign key (LX) references  jx_w_tplx(DH),
  foreign key (ZZ) references  jx_m_yh(ZH),
  foreign key (WZ) references  jx_w_wz(DH)
);
comment on table jx_w_tp is 'ͼƬ��';
comment on column jx_w_tp.dh is 'ͼƬ���';
comment on column jx_w_tp.alt is 'ͼƬ����';
comment on column jx_w_tp.zz is '�ϴ���';
comment on column jx_w_tp.lx is 'ͼƬ����';
comment on column jx_w_tp.wz is '��������';
comment on column jx_w_tp.scrq is '�ϴ�����';
comment on column jx_w_tp.gxrq is '��������';
comment on column jx_w_tp.nr is 'ͼƬ����';
comment on column jx_w_tp.sx is 'ͼƬ˳��';

/*���Ա�*/
create table jx_w_lyb
(
  DH VARCHAR2(32) not null primary key , 
  ZH   VARCHAR2(18) ,
  XM   VARCHAR2(15) not null, 
  LYRQ DATE default sysdate,
  LYNR VARCHAR2(700),
  BQ VARCHAR2(100),
  XP VARCHAR2(100),
  LX char(1) default 0 not null  ,
  SFNM char(1) default 0 not null  ,
  SFKJ char(1) default 0 not null  ,
  PDH VARCHAR2(32),
  foreign key (PDH) references  jx_w_lyb(DH) on delete cascade,
  foreign key (ZH) references  jx_m_yh(ZH) on delete cascade
);
comment on table jx_w_lyb is '���Ա�';
comment on column jx_w_lyb.dh is '���Ա��';
comment on column jx_w_lyb.zh is '��Ա�˺�';
comment on column jx_w_lyb.xm is '�ǳ�';
comment on column jx_w_lyb.lyrq is '��������';
comment on column jx_w_lyb.lynr is '��������';
comment on column jx_w_lyb.bq is '���Ա���';
comment on column jx_w_lyb.xp is '��Ա��Ƭ';
comment on column jx_w_lyb.lx is '��������(0,����;1,�ظ�)';
comment on column jx_w_lyb.sfnm is '�Ƿ������û�(0,��;1,��)';
comment on column jx_w_lyb.sfkj is  '�Ƿ�ɼ�(0,�����û��ɼ�;1,������Ա�ɼ�;2,ע���û��ɼ�;)';
comment on column jx_w_lyb.pdh is '�ϼ�����';

/*���߱���*/
create table jx_w_zxbm
(
  ZJHM VARCHAR2(30) not null primary key , 
  XM    VARCHAR2(15)  not null,
  XB     char(1) not null  ,
  NL  INTEGER ,
  ZY INTEGER default 0 not null,
  ZJLX INTEGER default 0 not null, 
  SJHM VARCHAR2(13) not null,
  LXDZ VARCHAR2(200),
  BZ VARCHAR2(700),
  SFCL char(1) not null
);
comment on table jx_w_zxbm is '���߱�����'; 
comment on column jx_w_zxbm.zjhm is '֤������';
comment on column jx_w_zxbm.xm is '����';
comment on column jx_w_zxbm.xb is '�Ա�(1:��,2:Ů)';
comment on column jx_w_zxbm.nl is '����';
comment on column jx_w_zxbm.zy is 'ְҵ';
comment on column jx_w_zxbm.zjlx is '֤������'; 
comment on column jx_w_zxbm.sjhm is '�ֻ�����';
comment on column jx_w_zxbm.lxdz is '��ϵ��ַ';
comment on column jx_w_zxbm.bz is '��ע';
comment on column jx_w_zxbm.sfcl is '�Ƿ��Ѵ���(0:������,1:�Ѵ���)';
----------------------------------------------------------------------------------------------
