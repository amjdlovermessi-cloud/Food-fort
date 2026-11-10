# Food Fort V2

A clean rebuild of the Food Fort multi-restaurant SaaS platform.

## Non-negotiable data safety
- The existing `main` branch and its deployed pages remain untouched.
- Existing Supabase project data is preserved. No DROP, TRUNCATE, destructive migration, or user deletion is part of this rebuild.
- V2 is developed in the `rebuild-v2` Git branch and under `/v2`.
- Existing tables are treated as the compatibility/data layer until a reviewed migration is justified.

## Product roles

### Platform supplier
Full platform-wide access:
- Create, suspend, archive, and configure restaurants.
- Set restaurant identity: name, logo, colors, theme, contact details, and public slug.
- Manage plans, subscriptions, billing status, payment methods, staff invitations, and platform settings.
- View every restaurant's categories, products, prices, availability, orders, and order history.
- Inspect operational and sales analytics across all tenants.

### Restaurant team
Scoped to its own restaurant:
- Manage categories and menu items.
- Edit item names, descriptions, prices, photos, sizes, and availability.
- Receive and process orders.
- Cannot change platform branding, subscription, global settings, or access another restaurant.

### Customer
- Browse an active restaurant's public menu.
- Build a cart and place an order.
- Track their own order with a safe public tracking flow.

## Rebuild sequence
1. V2 UI shell and navigation, isolated from production.
2. Authentication and role-aware route guards.
3. Supplier dashboard and restaurant management.
4. Restaurant workspace: menu and orders.
5. Public menu, cart, checkout, and tracking.
6. Analytics, subscription lifecycle, payment integrations.
7. RLS review, permission tests, and browser end-to-end tests.
8. Controlled cutover only after explicit owner approval.

## Existing database inventory (read-only discovery)
Current public tables include restaurants, restaurant_members, restaurant_subscriptions, subscription_plans, menu_categories, menu_products, restaurant_payment_methods, orders, order_items, platform_admins, restaurant_profile, and foodfort_promo_codes. Existing row counts observed during discovery: 1 restaurant, 11 categories, 88 products, 5 orders, 1 platform admin, and 1 active subscription.

These are discovery snapshots, not a promise that counts remain unchanged. Do not seed demo rows into production.
