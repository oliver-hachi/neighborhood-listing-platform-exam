-- Migration: Exam Services Persistence
-- Purpose: Create the relational schema for local services and bookings.

-- 1. Profiles
CREATE TABLE IF NOT EXISTS public.profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    role TEXT NOT NULL
        CHECK (role IN ('admin', 'merchant', 'provider', 'client')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now())
);

-- 2. Service Categories
CREATE TABLE IF NOT EXISTS public.service_categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT NOT NULL CHECK (char_length(name) >= 3),
    slug TEXT NOT NULL UNIQUE CHECK (slug ~* '^[a-z0-9-]+$'),
    active_status BOOLEAN NOT NULL DEFAULT true,
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now())
);

-- 3. Services
CREATE TABLE IF NOT EXISTS public.services (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    provider_id UUID NOT NULL
        REFERENCES public.profiles(id) ON DELETE RESTRICT,
    title TEXT NOT NULL CHECK (char_length(title) >= 5),
    hourly_rate NUMERIC(10, 2) NOT NULL CHECK (hourly_rate >= 0),
    duration_minutes INTEGER NOT NULL CHECK (duration_minutes >= 15),
    coverage_radius_miles INTEGER NOT NULL CHECK (coverage_radius_miles > 0),
    status TEXT NOT NULL DEFAULT 'draft'
        CHECK (status IN ('draft', 'pending', 'approved', 'suspended')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now())
);

-- 4. Service Category Mappings
CREATE TABLE IF NOT EXISTS public.service_category_mappings (
    service_id UUID REFERENCES public.services(id) ON DELETE CASCADE,
    category_id UUID REFERENCES public.service_categories(id) ON DELETE CASCADE,
    PRIMARY KEY (service_id, category_id)
);

-- 5. Bookings
CREATE TABLE IF NOT EXISTS public.bookings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    service_id UUID NOT NULL
        REFERENCES public.services(id) ON DELETE CASCADE,
    client_email TEXT NOT NULL
        CHECK (
            client_email ~*
            '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
        ),
    requested_date DATE NOT NULL,
    notes TEXT NOT NULL CHECK (char_length(notes) >= 10),
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now())
);