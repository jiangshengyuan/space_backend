create database if not exists t_space;
use t_space;
-- 登录信息表
create table if not exists t_space.login_info
(
    id             bigint primary key not null auto_increment comment '默认自增id',
    li_id  varchar(32)        not null comment '表ID',
    login_id     varchar(32)        not null comment '登录ID',
    login_password char(16)           not null comment '密码',
    phone          varchar(16) comment '电话号码',
    email          varchar(64) comment '邮箱',
    create_time       datetime,
    update_time       datetime,
    valid            char(1)            not null comment '是否有效：0：用户注销，1:正常使用中，X：违规封禁，Z：系统自动清除'
);
create table if not exists t_space.login_data
(
    id             bigint primary key not null auto_increment comment '默认自增id',
    li_id  varchar(32)        not null comment '表ID',
    login_type  char(1) comment '登录方式',
    login_token  char(1) comment '登录token',
    create_time       datetime,
    update_time       datetime,
    valid            char(1)            not null comment '是否有效：0：用户注销，1:正常使用中，X：违规封禁，Z：系统自动清除'
);
-- 用户信息表
create table if not exists t_space.user_info
(
    id                bigint primary key not null comment '默认自增id',
    ui_id             varchar(32) comment '表ID',
    user_id     varchar(32)        not null comment '登录ID',
    true_name         varchar(64) comment '真实姓名',
    nick_name         varchar(32) comment '昵称',
    birth             datetime comment '出生年月：yyyy-MM-dd',
    sex               char(1)            not null comment '性别',
    id_card           varchar(32) comment '身份证号码',
    country           varchar(64) comment '国籍',
    one_level_address varchar(64) comment '州、省、邦等',
    city              varchar(64) comment '城市',
    county            varchar(64) comment '县区（限制使用）',
    certification     char(1)            not null comment '是否实名认证',
    create_time       datetime,
    update_time       datetime,
    valid            char(1)            not null comment '是否有效：0：用户注销，1:正常使用中，X：违规封禁，Z：系统自动清除'
);

-- 角色表
create table if not exists t_space.role_info
(
    id        bigint primary key not null comment '默认自增id',
    ri_id             varchar(32) comment '表ID',
    role_name char(16)           not null comment '角色名:administrator',
    create_time       datetime,
    update_time       datetime,
    valid            char(1)            not null comment '是否有效：0：用户注销，1:正常使用中，X：违规封禁，Z：系统自动清除'
);
-- 用户&角色表
create table if not exists t_space.user_role
(
    id      bigint primary key not null comment '默认自增id',
    ur_id             varchar(32) comment '表ID',
    user_id bigint             not null,
    role_id bigint             not null,
    create_time       datetime,
    update_time       datetime,
    valid            char(1)            not null comment '是否有效：0：用户注销，1:正常使用中，X：违规封禁，Z：系统自动清除'
);
-- 权限表
create table if not exists t_space.role_authority
(
    id             bigint primary key not null comment '默认自增id',
    ra_id             varchar(32) comment '表ID',
    role_id        bigint             not null,
    authority_code varchar(16)        not null comment '权限码',
    authority_name char(16)           not null comment '权限名',
    create_time       datetime,
    update_time       datetime,
    valid            char(1)            not null comment '是否有效：0：用户注销，1:正常使用中，X：违规封禁，Z：系统自动清除'
);
-- 收货地址表
create table if not exists t_space.delivery_address
(
    id             bigint primary key not null comment '默认自增id',
    user_id        bigint             not null comment '用户id',
    location       varchar(64) comment '城市',
    detail_address varchar(64) comment '详细地址',
    receiver       varchar(64) comment '收货人',
    phone          varchar(16) comment '电话号码',
    tag            char(1) comment '标签：家：0，公司：1，临时：X',
    default_place  char(1) comment '是否为默认收货地址',
    create_time       datetime,
    update_time       datetime,
    valid            char(1)            not null comment '是否有效：0：用户注销，1:正常使用中，X：违规封禁，Z：系统自动清除'
);
-- 优惠券表
create table if not exists t_space.coupon
(
    id               bigint primary key not null comment '默认自增id',
    c_id          bigint             not null comment '表id',
    user_id          bigint             not null comment '用户id',
    discount_type    char(1)            not null comment '打折方式',
    discount_amount  decimal(10, 2) comment '打折金额',
    discount_percent int(2) comment '打折比例',
    start_price      int                not null comment '满减起始价格',
    begin_date       datetime           not null comment '开始使用期限',
    end_date         datetime           not null comment '截止使用期限',
    create_time       datetime,
    update_time       datetime,
    valid            char(1)            not null comment '是否有效：0：失效，1:正常'
);
