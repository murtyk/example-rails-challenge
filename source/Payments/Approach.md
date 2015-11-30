### Approach/Steps

1. Generate new rails app (Payments).

- Replace sqlite with pg. Update database.yml.
- Include gems: bootstrap, jquery, and for testing rspec etc. Copy from wtracker.
- Init rspec.
- Update asset manifests.

2. Generate Models. Since a charge can belong to an User or a Company, use STI polymorphism.

- Charge (chargable_id, chargable_type)
- User
- Company
