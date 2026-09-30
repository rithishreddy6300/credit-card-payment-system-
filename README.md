# Ledgerly Credit Card Payment System

A demo-safe fintech console built for the Full Stack Junior Application Task. Payments are simulated only; no real gateway or card network is connected.

## Stack
- React + Vite + Tailwind CSS UI
- Django + Django REST Framework for auth, cards, transactions, and admin reporting
- FastAPI payment simulator with Swagger at `http://localhost:8001/docs`
- SQLite for local development; MySQL 8.4 in Docker
- JWT access and refresh tokens

## Run locally
1. Install Node 22+ and Python 3.12+ (Python 3.14 also works with the portable dependency ranges).
2. Install frontend dependencies: `npm install`
3. Install backend dependencies: `python -m pip install -r requirements.txt`
4. Create the local schema: `cd backend && python manage.py migrate`
5. Start Django: `python manage.py runserver 8000`
6. In another terminal start FastAPI: `uvicorn payment_service.main:app --reload --port 8001`
7. In another terminal start the UI: `npm run dev`

Open `http://localhost:5173`. The UI includes overview, saved cards, transaction history, add-card, and payment simulation flows.

## Docker
Run `docker compose up --build`. The UI is at `http://localhost:5173`, Django at `http://localhost:8000`, FastAPI at `http://localhost:8001/docs`. Change all demo secrets before deployment.

## API surface
- `POST /api/auth/register/` creates a user with Django password hashing.
- `POST /api/auth/token/` and `/api/auth/token/refresh/` issue JWTs.
- `GET/POST /api/cards/` and `DELETE /api/cards/:id/` manage user-owned masked cards.
- `POST /api/transactions/create/` creates `PENDING`; `GET /api/transactions/` supports `status`, `min_amount`, `max_amount`, and `date` filters.
- `POST /payments/simulate` accepts a bearer token and returns `SUCCESS` or `FAILED`.
- Admin-only `GET /api/admin/summary/` and `/api/admin/transactions/export/` provide reporting.

Import `postman_collection.json` into Postman for the request sequence. Django admin is available at `/admin/` after creating a superuser with `python manage.py createsuperuser`.

## Security decisions
Raw PAN and CVV are never stored. The card write serializer uses the raw PAN only to derive a mask and last four digits, and the CVV is discarded. Passwords are handled by Django's PBKDF2-compatible password hasher. Every API except registration/token endpoints requires JWT authentication. ORM querysets are user-scoped and use parameterized Django ORM queries. CORS is open only in local `DEBUG` mode.

## Database and tests
`schema.sql` documents the MySQL table shape. Django migrations are the source of truth and support both SQLite and MySQL. Run `cd backend && pytest` for authentication-adjacent card and transaction API tests. The generated app uses Django's admin user table for users and password hashes; provide admin credentials separately at submission time rather than committing them.

## Submission checklist
- GitHub repository: push this folder to a private/public repository as required.
- Database dump/schema: `schema.sql` plus Django migrations.
- Postman collection: `postman_collection.json`.
- UI screenshots: capture the running dashboard, cards, payment modal, and transaction history.
- Admin credentials: create a local superuser; do not commit the password.
