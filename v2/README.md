# Food Fort V2

A clean rebuild of the Food Fort multi-restaurant SaaS platform.

## Data safety
- The production `main` branch and its deployed pages remain untouched.
- The existing Supabase production project and all records are preserved.
- V2 lives on the separate `rebuild-v2` Git branch under `/v2`.
- No destructive SQL or production data migration has been run for this rebuild.

## V2 pages
- `platform.html`: supplier login and platform overview, reading existing Supabase records.\n- `catalog.html`: supplier-only cross-restaurant catalog, product, price, and availability management.\n- `branding.html`: supplier-only restaurant identity editor (name, slug, tagline, logo, colors, theme, contact details).
- `restaurant.html`: restaurant team login, scoped menu/category editing, and order status management.
- `menu.html?restaurant=<slug>`: public restaurant menu and checkout through the existing secure `create_restaurant_order` RPC.\n- `track-order.html?order=<order-id>`: customer order tracking in the original anonymous customer session.
- `index.html`: V2 entry point.

## Roles
### Platform supplier
Full platform-wide visibility and management of restaurants, branding, menus, prices, orders, plans, subscriptions, staff, and settings.

### Restaurant team
Can manage only its own menu/categories and process its own orders. It cannot change platform branding or subscription settings, nor access another tenant.

### Customer
Can browse an active restaurant's menu, create a cart, and submit an order through the database-validated RPC. The database recalculates prices and validates product availability and payment method.

## Current implementation notes
- The new pages use the Supabase publishable key only. No service-role key is embedded in browser code.
- Restaurant workspace requires a real restaurant membership created by the supplier. Current prototype restaurant has no member rows or owner account linked yet, so manager login must be invited before that screen can be fully tested.
- Supplier dashboard reads platform-wide restaurant records. Order visibility may still be restricted by the existing supplier order policy and must be tested/fixed before claiming complete supplier visibility.
- Customer checkout uses anonymous Supabase auth and the existing `create_restaurant_order` RPC. Anonymous sign-in must be enabled in Supabase Auth.
- No production browser end-to-end test has been completed. V2 must not be merged into the live site until login, RLS, menu, checkout, order status, and tenant-isolation tests pass.

## Existing data snapshot during discovery
1 restaurant, 11 categories, 88 products, 5 orders, 1 platform admin, 1 active subscription. These are test/prototype data and may change; do not treat them as real business traction.

## Rebuild sequence
1. V2 supplier overview and navigation.
2. Restaurant workspace and public menu/checkout.
3. Supplier CRUD for restaurants, identity, payment methods, staff, and subscriptions.
4. Supplier all-tenant order visibility and reporting.
5. Authentication, RLS, and cross-tenant isolation tests.
6. Browser end-to-end testing and controlled cutover after explicit owner approval.
