{{ config(materialized='table') }}

With
    customers
    as
    (
        select
            customerid as customer_id, secondcode as customer_second_code, partyref as party_ref, "Type" as customer_type, "Number" as customer_number,customer_ref
        from {{ source('parnian', 'customer')}}
)

select *
from customers

with customeraddress as  (
    select * from {{ ref('raw_customeraddress' )}}
),
left join customer_address using(customer_ref)
with  address as  (
    select * from {{ ref('raw_address' )}}
),
left join  gnr3.address  using(address_id)

customer_address as (

    select
        customer_id,
        customer,
        customer_type,
        customer_address,
        address.details as customeraddress,
        address.zipcode as postalcode,

    from address

    group by 1

), 

select * from customer_address
