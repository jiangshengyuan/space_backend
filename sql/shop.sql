drop schema if exists t_shop;
create database t_shop;
use t_shop;
-- 订单表
drop table if exists t_shop.order;
create table order_detail
(
    id          bigint primary key not null,
    serial_num  varchar(64)        not null comment '订单编号',
    user_id     bigint             not null comment '用户id',
    store_id    bigint             not null comment '店铺id',
    sku_id      bigint             not null comment '商品id',
    address_id  bigint             not null comment '收货地址id',
    price       decimal(10, 2)     not null comment '价格',
    pay_price   decimal(10, 2)     not null comment '实付价格',
    create_time datetime,
    update_time datetime,
    status      char(1)            not null comment '是否有效'
);
-- 店铺表
drop table if exists t_shop.store;
create table store
(
    id                 bigint primary key not null,
    level              int                not null default 0 comment '店铺级别',
    store_name         varchar(64)        not null comment '店铺名字',
    owner_name         varchar(64)        not null comment '所有人姓名',
    owner_id           varchar(64)        not null comment '所有人id',
    location           varchar(64)        not null comment '区域',
    logo_link          varchar(512)       not null comment 'logo链接',
    bail               int comment '保证金',
    store_claim        varchar(512) comment '店铺申明',
    store_category_id  char(1) comment '店铺大类id',
    certification_link varchar(512) comment '店铺资质链接',
    state              char(1) comment '店铺运营状态',
    store_card_link    int                not null comment '店铺名片',
    create_time        datetime,
    update_time        datetime,
    status             char(1)            not null comment '是否有效'
);
-- 店铺关注表
drop table if exists t_shop.store_follow;
create table store_follow
(
    id                bigint primary key not null comment '店铺id',
    collection_amount int(9) comment '收藏量',
    create_time       datetime,
    update_time       datetime,
    status            char(1)            not null comment '是否有效'
);

-- 商品信息表
drop table if exists t_shop.product;
create table product
(
    id                 bigint primary key not null,
    store_id           bigint             not null comment '',
    detail_description varchar(1024)      not null comment '',
    create_time        datetime,
    update_time        datetime,
    status             char(1)            not null comment '是否有效'
);
-- 商品SKU表
drop table if exists t_shop.product_sku;
create table product_sku
(
    id          bigint primary key not null,
    store_id    bigint             not null comment '店铺id',
    product_id  bigint             not null comment '商品id',
    price       decimal(10, 2)     not null comment '价格',
    create_time datetime,
    update_time datetime,
    status      char(1)            not null comment '是否有效'
);

-- 商品SKU库存表
drop table if exists t_shop.product_sku_stork;
create table product_sku_stork
(
    id          bigint primary key not null,
    sku_id      bigint             not null comment 'sku id',
    stork       bigint             not null comment '库存',
    create_time datetime,
    update_time datetime,
    status      char(1)            not null comment '是否有效'
);

-- 商品详情图片表
drop table if exists t_shop.product_detail_img;
create table product_detail_img
(
    id           bigint primary key not null,
    serial_id    int                not null comment '序号',
    product_id   bigint             not null comment '商品id',
    picture_path varchar(32)        not null comment '图片地址',
    create_time  datetime,
    update_time  datetime,
    status       char(1)            not null comment '是否有效'
);
-- 商品品类表
drop table if exists t_shop.product_category;
create table product_category
(
    id                        bigint primary key not null,
    one_level_category_name   varchar(32)        not null comment '一级目录名',
    one_level_category_num    char(1)            not null comment '一级目录编号',
    two_level_category_name   varchar(32)        not null comment '二级目录名',
    two_level_category_num    char(2)            not null comment '二级目录编号',
    three_level_category_name varchar(32)        not null comment '三级目录名',
    three_level_category_num  char(3)            not null comment '三级目录编号',
    four_level_category_name  varchar(32)        not null comment '四级目录名(限制使用)',
    four_level_category_num   char(4)            not null comment '四级目录编号(限制使用)',
    create_time               datetime,
    update_time               datetime,
    status                    char(1)            not null comment '是否有效'
);
-- 购物车表
drop table if exists t_shop.shopping_car;
create table shopping_car
(
    id          bigint primary key not null,
    sku_id      bigint             not null comment 'sku id',
    amount      int                not null comment '数量',
    create_time datetime,
    update_time datetime,
    status      char(1)            not null comment '是否有效'
);
