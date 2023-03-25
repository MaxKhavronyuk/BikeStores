SELECT 
    items.order_id,
    orders.order_date,
    products.product_name,
    brands.brand_name,
    category.category_name,
    items.quantity,
    (items.quantity * items.list_price * (1 - items.discount)) AS revenue,
    stocks.quantity as in_stock,
    concat(customers.first_name,' ', customers.last_name) as customer_name,
    stores.store_name,
    customers.state,
    concat(staff.first_name,' ', staff.last_name) as staff_name
FROM
    sales.order_items AS items
join sales.orders as orders
on items.order_id = orders.order_id
join sales.customers as customers
on orders.customer_id = customers.customer_id
join sales.staffs as staff
on orders.staff_id = staff.staff_id
join sales.stores as stores
on orders.store_id = stores.store_id
join production.products as products
on items.product_id = products.product_id
join production.brands as brands
on products.brand_id = brands.brand_id
join production.categories as category
on products.category_id = category.category_id
join production.stocks as stocks
on stocks.store_id = orders.store_id and stocks.product_id = items.product_id
order by order_id