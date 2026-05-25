create database college_noticeboard;
use college_noticeboard;
create table users (
    user_id int auto_increment primary key,
    username varchar(100) unique not null,
    user_password varchar(100) not null,
    role enum('teacher', 'student') default 'student'
);
create table notices (
    notice_id int auto_increment primary key,
    title varchar(255) not null,
    content text not null,
    created_by int,
    created_at timestamp default current_timestamp,

    foreign key (created_by) references users(user_id)
);
delimiter $$
create procedure registeruser(
    in p_username varchar(100),
    in p_password varchar(100),
    in p_role varchar(20)
)
begin
    insert into users(username, user_password, role)
    values(p_username, p_password, p_role);

    select 'user registered successfully' as message;
end $$

create procedure userlogin(
    in p_username varchar(100),
    in p_password varchar(100)
)
begin
    select *
    from users
    where username = p_username
    and user_password = p_password;
end $$

create procedure checkpermission(
    in p_user_id int
)
begin
    declare user_role varchar(20);

    select role into user_role
    from users
    where user_id = p_user_id;

    if user_role != 'teacher' then
        signal sqlstate '45000'
        set message_text = 'permission denied: only teachers can perform this action';
    end if;
end $$

create procedure createnotice(
    in p_title varchar(255),
    in p_content text,
    in p_created_by int
)
begin
    call checkpermission(p_created_by);

    insert into notices(title, content, created_by)
    values(p_title, p_content, p_created_by);

    select 'notice created successfully' as message;
end $$
create procedure viewnotices()
begin
    select 
        n.notice_id,
        n.title,
        n.content,
        u.username as created_by,
        n.created_at
    from notices n
    join users u
    on n.created_by = u.user_id;
end $$
create procedure updatenotice(
    in p_notice_id int,
    in p_title varchar(255),
    in p_content text,
    in p_user_id int
)
begin
    call checkpermission(p_user_id);

    update notices
    set title = p_title,
        content = p_content
    where notice_id = p_notice_id;

    select 'notice updated successfully' as message;
end $$
create procedure deletenotice(
    in p_notice_id int,
    in p_user_id int
)
begin
    call checkpermission(p_user_id);

    delete from notices
    where notice_id = p_notice_id;

    select 'notice deleted successfully' as message;
end $$

delimiter ;
call registeruser('ram_teacher', '1234', 'teacher');

call registeruser('hari_student', '5678', 'student');


call userlogin('ram_teacher', '1234');


call userlogin('hari_student', '5678');


call createnotice(
    'holiday notice',
    'college will remain closed tomorrow.',
    1
);
call createnotice(
    'fake notice',
    'students should not create notices.',
    2
);