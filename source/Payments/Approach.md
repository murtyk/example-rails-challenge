### Approach/Steps

1. Generate new rails app (Payments).

- Replace sqlite with pg. Update database.yml.
- Include gems: bootstrap, jquery, and for testing rspec etc. Copy from wtracker.
- Init rspec.
- Update asset manifests.

2. Generate Models. Since a charge can belong to an User or a Company, use STI polymorphism.

- Charge: additional attributes - chargable_id and chargable_type.
- User
- Company

How do we handle money? Use money-rails like in learntobe? Pg money?

unique_code: Generate using SecureRandom. Make it url safe.

Why specific mention of created_at? And no mention of updated_at?

Create factories and finish model specs.

3. Generate seed data. It does not make sense to have random seed data. Use factories to generate and copy to seeds.rb.

4. Create scopes and check seeded data.
- 13 successful
- 3 disputed
- 5 failed

5. Index page
  - create layout. copy from wtracker.
  - define css for row colors
  - route, controller and view
  - create feature spec

6. Index - show link (unique_code instead of id)

7. New Charge page
  - select only one of user or company
