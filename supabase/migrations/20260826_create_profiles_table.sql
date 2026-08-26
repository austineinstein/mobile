-- Create profiles table
create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  display_name text,
  avatar_url text,
  updated_at timestamptz default now()
);

-- Grant permissions
grant select, insert, update on public.profiles to authenticated;
grant all on public.profiles to service_role;

-- Enable row level security
alter table public.profiles enable row level security;

-- Create RLS policies
create policy "Users read own profile" on public.profiles
  for select to authenticated using (auth.uid() = id);
  
create policy "Users insert own profile" on public.profiles
  for insert to authenticated with check (auth.uid() = id);
  
create policy "Users update own profile" on public.profiles
  for update to authenticated using (auth.uid() = id);

-- Create trigger function for new user signup
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles (id, display_name)
  values (new.id, new.raw_user_meta_data->>'display_name')
  on conflict (id) do nothing;
  return new;
end;
$$;

-- Create trigger
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();
