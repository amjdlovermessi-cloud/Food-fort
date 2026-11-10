-- This additive migration was applied to the existing Supabase production project.
-- It does not delete or modify any business records.
alter policy "menu_categories_staff_delete" on public.menu_categories
using (private.has_restaurant_access(restaurant_id) or private.is_platform_admin());
alter policy "menu_categories_staff_insert" on public.menu_categories
with check (private.has_restaurant_access(restaurant_id) or private.is_platform_admin());
alter policy "menu_categories_staff_update" on public.menu_categories
using (private.has_restaurant_access(restaurant_id) or private.is_platform_admin())
with check (private.has_restaurant_access(restaurant_id) or private.is_platform_admin());
alter policy "menu_products_staff_delete" on public.menu_products
using (private.has_restaurant_access(restaurant_id) or private.is_platform_admin());
alter policy "menu_products_staff_insert" on public.menu_products
with check (private.has_restaurant_access(restaurant_id) or private.is_platform_admin());
alter policy "menu_products_staff_update" on public.menu_products
using (private.has_restaurant_access(restaurant_id) or private.is_platform_admin())
with check (private.has_restaurant_access(restaurant_id) or private.is_platform_admin());
alter policy "orders_customer_or_staff_read" on public.orders
using (((customer_id = (select auth.uid())) and (coalesce((select auth.jwt())->>'is_anonymous','false')='true'))
       or private.has_restaurant_access(restaurant_id)
       or private.is_platform_admin());
alter policy "orders_restaurant_update" on public.orders
using (private.has_restaurant_access(restaurant_id) or private.is_platform_admin())
with check (private.has_restaurant_access(restaurant_id) or private.is_platform_admin());
alter policy "order_items_customer_or_staff_read" on public.order_items
using (exists (
  select 1 from public.orders o
  where o.id=order_items.order_id
    and (
      (o.customer_id=(select auth.uid()) and coalesce((select auth.jwt())->>'is_anonymous','false')='true')
      or private.has_restaurant_access(o.restaurant_id)
      or private.is_platform_admin()
    )
));
