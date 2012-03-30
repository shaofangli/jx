--Oracle中的所有字段类型：

字段类型 中文说明 限制条件 其它说明     

CHAR 固定长度字符串 最大长度2000bytes       
VARCHAR2 可变长度的字符串 最大长度4000bytes     可做索引的最大长度749     
NCHAR 根据字符集而定的固定长度字符串 最大长度2000bytes         
NVARCHAR2 根据字符集而定的可变长度字符串 最大长度4000bytes         
DATE 日期（日-月-年）DD-MM-YY（HH-MI-SS）    
LONG 超长字符串 最大长度2G（231-1） 足够存储大部头著作（不建议使用）
RAW 固定长度的二进制数据 最大长度2000bytes 可存放多媒体图象声音等     
LONG RAW 可变长度的二进制数据 最大长度2G 可存放多媒体图象声音等  
BLOB 二进制数据 最大长度4G 
CLOB 字符数据 最大长度4G 
NCLOB 根据字符集而定的字符数据 最大长度4G       
BFILE 存放在数据库外的二进制数据 最大长度4G  
ROWID 数据表中记录的唯一行号 10 bytes 
NROWID 二进制数据表中记录的唯一行号 最大长度4000bytes 
NUMBER(P,S) 数字类型   P为整数位，S为小数位     
DECIMAL(P,S)   数字类型   P为整数位，S为小数位     
INTEGER   整数类型   小的整数 
FLOAT   浮点数类型   NUMBER(38)，双精度 
REAL 实数类型   NUMBER(63)，精度更高

--备份jx数据库
exp jx/jx owner=jx file=E:\workspace\jx.dmp

--恢复jx数据库
imp jx/jx file=E:\workspace\jx.dmp log=E:\workspace\jx.log fromuser=jx touser=jx ignore=y

--删除用户X及所有相关的数据
drop user jx cascade;

--清空Oracle回收站
PURGE RECYCLEBIN; 

--创建用户
CREATE   USER  jx IDENTIFIED  BY  jx
DEFAULT  TABLESPACE users
TEMPORARY  TABLESPACE temp;
--给用户授予权限
GRANT resource,connect to jx;

--GRANT  
--　　 CREATE  SESSION,  CREATE   ANY   TABLE ,  CREATE   ANY   VIEW  , CREATE   ANY   INDEX ,  CREATE   ANY   PROCEDURE ,
--　　 ALTER   ANY   TABLE ,  ALTER   ANY   PROCEDURE ,
--　　 DROP   ANY   TABLE ,  DROP   ANY   VIEW ,  DROP   ANY   INDEX ,  DROP   ANY   PROCEDURE ,
--　　 SELECT   ANY   TABLE ,  INSERT   ANY   TABLE ,  UPDATE   ANY   TABLE ,  DELETE   ANY   TABLE
--　　 TO  jx;

--=================================================================================

-- contains 函数(in_str:被搜索的字符串,in_sub：要包含的字符串
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

/**分页相关*-----------------------------------------------------------------------------------------------------*/
create or replace package REFCURSOR_PKG   as
    TYPE   refCursorType   IS   REF   CURSOR; 
end   REFCURSOR_PKG;

--获得分页的总页数；传入的参数为allPageRows/singPageRows
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

--分页存储过程
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
/**分页相关*-----------------------------------------------------------------------------------------------------*/


/*角色表*/
create table jx_m_js
( 
  DH   INTEGER not null primary key , 
  MC   VARCHAR2(20) not null unique ,
  MKS VARCHAR2(120)
);
comment on table jx_m_js is '角色表';
comment on column jx_m_js.dh is '角色代号';
comment on column jx_m_js.mc is '角色名称';
comment on column jx_m_js.mks is '角色所拥有的模块集';

/**模块表**/
create table jx_m_mk
( 
  DH   INTEGER not null primary key ,  
  NM VARCHAR2(20) not null,
  PDH INTEGER default 0 not null
);
comment on table jx_m_mk is '模块表';
comment on column jx_m_mk.dh is '模块代号';
comment on column jx_m_mk.nm is '模块名称';
comment on column jx_m_mk.pdh is '上级模块代号';

/*操作表*/
create table jx_m_cz
( 
  DH   INTEGER not null primary key , 
  NM VARCHAR2(30) not null,
  URI  VARCHAR2(120) ,
  MTD  VARCHAR2(20),
  MK INTEGER default 0 not null,
  foreign key (MK) references jx_m_mk(DH)
);
comment on table jx_m_cz is '操作管理表';
comment on column jx_m_cz.dh is '操作代号';
comment on column jx_m_cz.nm is '操作名称';
comment on column jx_m_cz.uri is '操作地址';
comment on column jx_m_cz.mtd is '操作方法';
comment on column jx_m_cz.mk is '所属模块'; 


/**权限表**/
create table jx_m_qx
(
  JSDH  INTEGER not null ,
  CZDH INTEGER not null,
  QX CHAR(1) default 0 not null,
  XS CHAR(1) default 1 not null,
  foreign key (JSDH) references  jx_m_js(DH) on delete cascade,
  foreign key (CZDH) references  jx_m_cz(DH) on delete cascade
);
comment on table jx_m_qx is '操作权限表';
comment on column jx_m_qx.jsdh is '角色代号';
comment on column jx_m_qx.czdh is '操作代号';
comment on column jx_m_qx.qx is '是否对该操作有权限(0:无权限,1:有权限)';
comment on column jx_m_qx.xs is '是否在界面显示该条操作(0:不显示,1:显示)';

/*用户表*/ 
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
comment on table jx_m_yh is '用户表';
comment on column jx_m_yh.zh is '账号';
comment on column jx_m_yh.mm is '密码';
comment on column jx_m_yh.xm is '真实姓名或昵称';
comment on column jx_m_yh.xb is '性别';
comment on column jx_m_yh.yx is '邮箱';
comment on column jx_m_yh.dh is '联系电话';
comment on column jx_m_yh.csrq is '出生日期';
comment on column jx_m_yh.zcsj is '注册时间';
comment on column jx_m_yh.zhdl is '最后登录时间';
comment on column jx_m_yh.jsdh is '所属角色';
comment on column jx_m_yh.mmbhwt is '密码保护问题序号';
comment on column jx_m_yh.mmbhda is '密码保护答案';
comment on column jx_m_yh.sfjh is '是否已激活(0-未激活,1-已激活,2-已禁用)';
comment on column jx_m_yh.grjj is '个人简介';
comment on column jx_m_yh.bz is '备用字段';

/*文章类型表*/
create table jx_w_wzlx
(
  DH INTEGER not null primary key , 
  LXMC VARCHAR2(20) not null  unique,
  PDH INTEGER default 0 not null,
  MK INTEGER default 0 not null,
  TOPDH VARCHAR2(100) default '$' not null,
  foreign key (MK) references  jx_m_mk(DH) 
);
comment on table jx_w_wzlx is '文章类型表';
comment on column jx_w_wzlx.dh is '类型编号';
comment on column jx_w_wzlx.lxmc is '类型名称';
comment on column jx_w_wzlx.pdh is '上级代号';
comment on column jx_w_wzlx.mk is '所属模块';
comment on column jx_w_wzlx.topdh is '置顶文章列表';

/*文章表*/
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
comment on table jx_w_wz is '文章表';
comment on column jx_w_wz.dh is '文章编号';
comment on column jx_w_wz.bt is '文章标题';
comment on column jx_w_wz.zz is '文章作者';
comment on column jx_w_wz.lx is '文章类型';
comment on column jx_w_wz.nr is '文章内容';
comment on column jx_w_wz.fbrq is '发表日期';
comment on column jx_w_wz.gxrq is '更新日期';
comment on column jx_w_wz.tp is '图片地址';

/*图片类型表*/
create table jx_w_tplx
(
  DH INTEGER not null primary key , 
  LXMC VARCHAR2(20) not null  unique,
  PDH INTEGER default 0 not null,
  MK INTEGER default 0 not null,
  foreign key (MK) references  jx_m_mk(DH)
);
comment on table jx_w_tplx is '图片类型表';
comment on column jx_w_tplx.dh is '类型编号';
comment on column jx_w_tplx.lxmc is '类型名称';
comment on column jx_w_tplx.pdh is '上级代号';
comment on column jx_w_tplx.mk is '所属模块';

/*图片表*/ 
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
comment on table jx_w_tp is '图片表';
comment on column jx_w_tp.dh is '图片编号';
comment on column jx_w_tp.alt is '图片标题';
comment on column jx_w_tp.zz is '上传者';
comment on column jx_w_tp.lx is '图片类型';
comment on column jx_w_tp.wz is '所属文章';
comment on column jx_w_tp.scrq is '上传日期';
comment on column jx_w_tp.gxrq is '更新日期';
comment on column jx_w_tp.nr is '图片内容';
comment on column jx_w_tp.sx is '图片顺序';

/*留言表*/
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
comment on table jx_w_lyb is '留言表';
comment on column jx_w_lyb.dh is '留言编号';
comment on column jx_w_lyb.zh is '会员账号';
comment on column jx_w_lyb.xm is '昵称';
comment on column jx_w_lyb.lyrq is '留言日期';
comment on column jx_w_lyb.lynr is '留言内容';
comment on column jx_w_lyb.bq is '留言表情';
comment on column jx_w_lyb.xp is '会员相片';
comment on column jx_w_lyb.lx is '留言类型(0,留言;1,回复)';
comment on column jx_w_lyb.sfnm is '是否匿名用户(0,否;1,是)';
comment on column jx_w_lyb.sfkj is  '是否可见(0,所有用户可见;1,仅管理员可见;2,注册用户可见;)';
comment on column jx_w_lyb.pdh is '上级代号';

/*在线报名*/
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
comment on table jx_w_zxbm is '在线报名表'; 
comment on column jx_w_zxbm.zjhm is '证件号码';
comment on column jx_w_zxbm.xm is '姓名';
comment on column jx_w_zxbm.xb is '性别(1:男,2:女)';
comment on column jx_w_zxbm.nl is '年龄';
comment on column jx_w_zxbm.zy is '职业';
comment on column jx_w_zxbm.zjlx is '证件类型'; 
comment on column jx_w_zxbm.sjhm is '手机号码';
comment on column jx_w_zxbm.lxdz is '联系地址';
comment on column jx_w_zxbm.bz is '备注';
comment on column jx_w_zxbm.sfcl is '是否已处理(0:待处理,1:已处理)';
----------------------------------------------------------------------------------------------
