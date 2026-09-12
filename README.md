# Xchange Mobile

## Overview
This workspace contains the Xchange mobile app and its Supabase backend scaffolding. The app is built with Ionic + Vue + Vite and packaged via Capacitor for Android and iOS release builds.

## Project structure
- `Xchange/` — Ionic/Vue mobile application
- `supabase/migrations/` — database migration files
- `capacitor.config.ts` — root Capacitor config used for project-level app metadata

## Local development
From the app folder:

```bash
cd /workspaces/mobile/Xchange
npm install
npm run dev
```

## Production build and release
Use the release script to build the web bundle and sync it with Capacitor:

```bash
cd /workspaces/mobile/Xchange
npm run release
```

This runs:

```bash
npm run build
npx cap sync
```

### Open native projects
```bash
cd /workspaces/mobile/Xchange
npm run android:open
# or
npm run ios:open
```

### Native packaging workflow
1. Update the app version and package metadata in `Xchange/package.json` and `Xchange/capacitor.config.ts` as needed.
2. Run `npm run release`.
3. Open the platform project in Android Studio or Xcode.
4. Set signing configuration, version code, and app icons for the target store.
5. Build the production archive or APK/AAB.

## Important notes
- The app currently targets the package ID `com.xchange.mobile`.
- The release build succeeds with a Vite warning about large Ionic bundle size; this is non-blocking but worth optimizing later if app size becomes a concern.
- Keep dependency versions pinned in production builds to avoid unexpected changes in native packaging.

## Future work
- Lock dependency ranges more tightly for reproducible builds.
- Add debug/admin-only store or configuration gating.
- Add CI checks for linting, test runs, and release validation.

## Release checklist
- [x] Add production app metadata
- [x] Generate native Capacitor platform projects
- [x] Add release scripts for Android/iOS sync
- [x] Add CI validation for lint + test + build
- [ ] Configure signing credentials in Android Studio / Xcode
- [ ] Submit release builds to the app stores

## CI validation
Run the full release gate locally:

```bash
cd /workspaces/mobile/Xchange
npm run ci:check
```

This validates linting, unit tests, and the production bundle before native packaging.