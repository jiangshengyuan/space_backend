drop schema if exists t_business;
create database t_business;
use t_business;
drop table if exists t_business.message;
create table message
(
    id           bigint primary key  not null auto_increment,
    from_account varchar(32)         not null comment '发送账号',
    to_account   varchar(32)         not null comment '接收账号',
    have_read    char(1) default '0' not null comment '已读未读,0：已读，1:未读',
    content      text    default null,
    create_time  datetime,
    update_time  datetime,
    status       char(1)             not null comment '是否有效：0：删除，1:使用中'
);