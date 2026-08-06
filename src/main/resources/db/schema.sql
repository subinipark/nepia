-- DDL section...



-- # table name : 사용자 정보 테이블
drop table if exists users cascade;

create table if not exists users (
    id                  int                 not null    auto_increment,
    email               varchar(45)         not null    unique,
    nickname            varchar(20)         not null    unique,
    name                varchar(15)         not null,
    auth_type           char(5)             not null,
    enabled             tinyint(1)          not null    default 1,
    deleted_yn          char(1)             not null    default 'N',
    created_at          datetime            not null    default now(),
    updated_at          datetime            not null,
    deleted_at          datetime            null,
    primary key (id)
);


-- # table name : 사용자 로컬 인증 정보 테이블
drop table if exists user_auth_local cascade;

create table if not exists user_auth_local (
    user_id             int                 not null,
    password            varchar(255)        not null,
    updated_at          datetime            not null,
    primary key (user_id),
    foreign key (user_id) references users (id)
);


-- # table name : 사용자 소셜 인증 정보 테이블
drop table if exists user_auth_social cascade;

create table if not exists user_auth_social (
    id                  int                 not null    auto_increment,
    user_id             int                 not null,
    provider            varchar(50)         not null,
    provider_id         varchar(255)        not null,
    created_at          datetime            not null    default now(),
    primary key (id),
    foreign key (user_id) references users (id)
);


-- # table name : 사용자별 보유 권한 정보 테이블
drop table if exists user_roles cascade;

create table if not exists user_roles (
    user_id             int                 not null,
    role                varchar(20)         not null,
    primary key (user_id, role),
    foreign key (user_id) references users (id)
);


-- # table name : 로그인 이력 테이블
drop table if exists login_histories cascade;

create table if not exists login_histories (
    id                  int                 not null    auto_increment,
    user_id             int                 not null,
    ip_address          varchar(45)         not null,
    device              varchar(25)         not null,
    os                  varchar(20)         not null,
    browser             varchar(20)         not null,
    login_at            datetime            not null,
    primary key (id),
    foreign key (user_id) references users (id)
);


-- # table name : 사용자 프로필 정보 테이블
drop table if exists profiles cascade;

create table if not exists profiles (
    id                  int                 not null    auto_increment,
    user_id             int                 not null,
    profile_img_url     varchar(255)        null,
    bio                 varchar(150)        null,
    univ                varchar(45)         null,
    site_url            varchar(255)        null,
    github_url          varchar(255)        null,
    updated_at          datetime            not null,
    primary key (id),
    foreign key (user_id) references users (id)
);


-- # table name : 팀 정보 테이블
drop table if exists teams cascade;

create table if not exists teams (
    id                  int                 not null    auto_increment,
    name                varchar(65)         not null,
    description         varchar(150)        null,
    img_url             varchar(255)        null,
    created_by          int                 not null,
    deleted_yn          char(1)             not null    default 'N',
    created_at          datetime            not null    default now(),
    updated_at          datetime            not null,
    deleted_at          datetime            null,
    primary key (id),
    foreign key (created_by) references users (id)
);


-- # table name : 팀원 정보 테이블
drop table if exists team_users cascade;

create table if not exists team_users (
    team_id             int                 not null,
    user_id             int                 not null,
    is_captain          char(1)             not null,
    deleted_yn          char(1)             not null    default 'N',
    created_at          datetime            not null    default now(),
    updated_at          datetime            not null,
    deleted_at          datetime            null,
    primary key (team_id, user_id),
    foreign key (team_id) references teams (id),
    foreign key (user_id) references users (id)
);


-- # table name : 업무 그룹 테이블
drop table if exists tasks cascade;

create table if not exists tasks (
    id                  int                 not null    auto_increment,
    name                varchar(55)         not null,
    used_yn             char(1)             not null    default 'N',
    order_no            int                 not null    default 0,
    created_at          datetime            not null    default now(),
    updated_at          datetime            not null,
    primary key (id)
);


-- # table name : 프로젝트 정보 테이블
drop table if exists projects cascade;

create table if not exists projects (
    id                  int                 not null    auto_increment,
    name                varchar(150)        not null,
    description         varchar(250)        null,
    team_id             int                 not null,
    user_id             int                 not null,
    started_date        date                not null,
    end_date            date                not null,
    status              char(1)             not null,
    deleted_yn          char(1)             not null    default 'N',
    created_at          datetime            not null    default now(),
    updated_at          datetime            not null,
    deleted_at          datetime            null,
    primary key (id),
    foreign key (team_id) references teams (id),
    foreign key (user_id) references users (id)
);


-- # table name : 프로젝트 업무 테이블
drop table if exists project_tasks cascade;

create table if not exists project_tasks (
    id                  int                 not null    auto_increment,
    project_id          int                 not null,
    parent_task_id      int                 not null,
    name                varchar(200)        not null,
    started_date        date                not null,
    end_date            date                not null,
    actual_end_date     date                null,
    status              char(1)             not null,
    rate                int                 not null    default 0,
    order_no            int                 not null    default 0,
    created_at          datetime            not null    default now(),
    updated_at          datetime            not null,
    primary key (id),
    foreign key (project_id) references projects (id)
);


-- # table name : 프로젝트 업무 할당 정보 테이블
drop table if exists allocations cascade;

create table if not exists allocations (
    project_task_id     int                 not null,
    user_id             int                 not null,
    primary key (project_task_id, user_id),
    foreign key (project_task_id) references project_tasks (id),
    foreign key (user_id) references users (id)
);


/*
-- # table name : 국문 명 / 영문 명
drop table if exists 테이블명 cascade;

create table if not exists 테이블명 (
    column_namedatatypenot null,
    column_namedatatypenot null,
    primary key (주키),
    foreign key (외래키_컬럼) references 참조테이블 (참조_테이블_주키)
);


-- # table name : 국문 명 / 영문 명
drop table if exists 테이블명 cascade;

create table if not exists 테이블명 (
    column_namedatatypenot null,
    column_namedatatypenot null,
    primary key (주키),
    foreign key (외래키_컬럼) references 참조테이블 (참조_테이블_주키)
);


-- # table name : 국문 명 / 영문 명
drop table if exists 테이블명 cascade;

create table if not exists 테이블명 (
    column_namedatatypenot null,
    column_namedatatypenot null,
    primary key (주키),
    foreign key (외래키_컬럼) references 참조테이블 (참조_테이블_주키)
);


-- # table name : 국문 명 / 영문 명
drop table if exists 테이블명 cascade;

create table if not exists 테이블명 (
    column_namedatatypenot null,
    column_namedatatypenot null,
    primary key (주키),
    foreign key (외래키_컬럼) references 참조테이블 (참조_테이블_주키)
);
*/