{{ config(materialized='table') }}

With
    customers
    as
    (
        select
            customerid as customer_id, secondcode as customer_second_code, partyref as party_ref, "Type" as customer_type, "Number" as customer_number
        from {{ source('parnian', 'customer')}}
)

select *
from customers



