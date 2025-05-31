SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for zipkin_annotations
-- ----------------------------
DROP TABLE IF EXISTS `zipkin_annotations`;
CREATE TABLE `zipkin_annotations`
(
    `trace_id_high`         bigint(20)                                              NOT NULL DEFAULT 0 COMMENT 'If non zero, this means the\r\ntrace uses 128 bit traceIds instead of 64 bit',
    `trace_id`              bigint(20)                                              NOT NULL COMMENT 'coincides with zipkin_spans.trace_id',
    `span_id`               bigint(20)                                              NOT NULL COMMENT 'coincides with zipkin_spans.id',
    `a_key`                 varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'BinaryAnnotation.key or\r\nAnnotation.value if type == -1',
    `a_value`               blob                                                    NULL COMMENT 'BinaryAnnotation.value(), which must be smaller than\r\n64KB',
    `a_type`                int(11)                                                 NOT NULL COMMENT 'BinaryAnnotation.type() or -1 if Annotation',
    `a_timestamp`           bigint(20)                                              NULL     DEFAULT NULL COMMENT 'Used to implement TTL; Annotation.timestamp or\r\nzipkin_spans.timestamp',
    `endpoint_ipv4`         int(11)                                                 NULL     DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is null',
    `endpoint_ipv6`         binary(16)                                              NULL     DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is\r\nnull, or no IPv6 address',
    `endpoint_port`         smallint(6)                                             NULL     DEFAULT NULL COMMENT 'Null when Binary/Annotation.endpoint is\r\nnull',
    `endpoint_service_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL     DEFAULT NULL COMMENT 'Null when\r\nBinary/Annotation.endpoint is null',
    UNIQUE INDEX `trace_id_high` (`trace_id_high`, `trace_id`, `span_id`, `a_key`, `a_timestamp`) USING BTREE COMMENT 'Ignore insert on duplicate',
    INDEX `trace_id_high_2` (`trace_id_high`, `trace_id`, `span_id`) USING BTREE COMMENT 'for joining with zipkin_spans',
    INDEX `trace_id_high_3` (`trace_id_high`, `trace_id`) USING BTREE COMMENT 'for getTraces/ByIds',
    INDEX `endpoint_service_name` (`endpoint_service_name`) USING BTREE COMMENT 'for\r\ngetTraces and getServiceNames',
    INDEX `a_type` (`a_type`) USING BTREE COMMENT 'for getTraces and\r\nautocomplete values',
    INDEX `a_key` (`a_key`) USING BTREE COMMENT 'for getTraces and\r\nautocomplete values',
    INDEX `trace_id` (`trace_id`, `span_id`, `a_key`) USING BTREE COMMENT 'for dependencies job'
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = COMPRESSED;

-- ----------------------------
-- Table structure for zipkin_spans
-- ----------------------------
DROP TABLE IF EXISTS `zipkin_spans`;
CREATE TABLE `zipkin_spans`
(
    `trace_id_high`       bigint(20)                                              NOT NULL DEFAULT 0 COMMENT 'If non zero, this means the\r\ntrace uses 128 bit traceIds instead of 64 bit',
    `trace_id`            bigint(20)                                              NOT NULL,
    `id`                  bigint(20)                                              NOT NULL,
    `name`                varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
    `remote_service_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL     DEFAULT NULL,
    `parent_id`           bigint(20)                                              NULL     DEFAULT NULL,
    `debug`               bit(1)                                                  NULL     DEFAULT NULL,
    `start_ts`            bigint(20)                                              NULL     DEFAULT NULL COMMENT 'Span.timestamp(): epoch micros used for endTs query\r\nand to implement TTL',
    `duration`            bigint(20)                                              NULL     DEFAULT NULL COMMENT 'Span.duration(): micros used for minDuration and\r\nmaxDuration query',
    PRIMARY KEY (`trace_id_high`, `trace_id`, `id`) USING BTREE,
    INDEX `trace_id_high` (`trace_id_high`, `trace_id`) USING BTREE COMMENT 'for\r\ngetTracesByIds',
    INDEX `name` (`name`) USING BTREE COMMENT 'for getTraces and\r\ngetSpanNames',
    INDEX `remote_service_name` (`remote_service_name`) USING BTREE COMMENT 'for getTraces\r\nand getRemoteServiceNames',
    INDEX `start_ts` (`start_ts`) USING BTREE COMMENT 'for getTraces ordering\r\nand range'
) ENGINE = InnoDB
  CHARACTER SET = utf8
  COLLATE = utf8_general_ci
  ROW_FORMAT = COMPRESSED;

-- ----------------------------
-- Records of zipkin_annotations
-- ----------------------------
set
    global innodb_large_prefix = 1;
set
    global innodb_file_format = BARRACUDA;
-- ----------------------------
-- Table structure for zipkin_dependencies
-- ----------------------------
DROP TABLE IF EXISTS `zipkin_dependencies`;
CREATE TABLE `zipkin_dependencies`
(
    `day`         date                                                          NOT NULL,
    `parent`      varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `child`       varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
    `call_count`  bigint(20)                                                    NULL DEFAULT NULL,
    `error_count` bigint(20)                                                    NULL DEFAULT NULL,
    PRIMARY KEY (`day`, `parent`, `child`) USING BTREE
) ENGINE = InnoDB
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_general_ci
  ROW_FORMAT = COMPRESSED;

SET
    FOREIGN_KEY_CHECKS = 1;

