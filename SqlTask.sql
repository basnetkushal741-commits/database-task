create database contact_book;

use contact_book;

create table contacts (
    contact_id int auto_increment primary key,
    customer_name varchar(100),
    phone varchar(20),
    email varchar(100),
    city varchar(50)
);

delimiter //

create procedure add_contact(
    in p_name varchar(100),
    in p_phone varchar(20),
    in p_email varchar(100),
    in p_city varchar(50)
)
begin

    if p_name = '' or p_phone = '' then
        select 'error: name or phone cannot be empty' as message;

    else

        insert into contacts(customer_name, phone, email, city)
        values(p_name, p_phone, p_email, p_city);

        select last_insert_id() as new_contact_id,
        'contact added successfully' as message;

    end if;

end //

create procedure search_contact(
    in p_search varchar(100)
)
begin

    select *
    from contacts
    where customer_name like concat('%', p_search, '%');

end //

create procedure update_phone(
    in p_contact_id int,
    in p_new_phone varchar(20)
)
begin

    if exists (
        select *
        from contacts
        where contact_id = p_contact_id
    ) then

        update contacts
        set phone = p_new_phone
        where contact_id = p_contact_id;

        select 'phone number updated successfully' as message;

    else

        select 'contact not found' as message;

    end if;

end //

create procedure delete_contact(
    in p_contact_id int
)
begin

    if exists (
        select *
        from contacts
        where contact_id = p_contact_id
    ) then

        delete from contacts
        where contact_id = p_contact_id;

        select 'contact deleted successfully' as message;

    else

        select 'contact not found' as message;

    end if;

end //

delimiter ;

call add_contact('ram sharma', '9800000001', 'ram@gmail.com', 'kathmandu');

call add_contact('ramesh karki', '9800000002', 'ramesh@gmail.com', 'lalitpur');

call add_contact('bikram thapa', '9800000003', 'bikram@gmail.com', 'bhaktapur');

call search_contact('ram');

call update_phone(1, '9811111111');

call delete_contact(2);

select * from contacts;