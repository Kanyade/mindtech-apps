# Mindtech Apps HW

- **Blocs** are responsible for handling UI state and logic. They are created on demand for each relevant screen or feature (except authentication). Blocs can request a force refresh of data when needed. E.g. pull-to-refresh or in case of an error.
- **Repositories** are responsible for holding and managing data, including fetching from remote sources or caching locally. Blocs interact with repositories to retrieve or update data. They only return Results, BLoCs should not have errors from these sources

**Authentication** is treated as a global concern and is managed by a dedicated repository & bloc that persists for the lifetime of the app.

**Routing** that is not a direct result of user navigation (such as automatic navigation after successful authentication) is handled within the router.

**Dependency injection** is managed using the [`get_it`](https://pub.dev/packages/get_it) package.

**Presentation layer** is organized in folders that reflect the hierarchy from the user's point of view. Features have their own domain folders.

A **custom linter** is used to enforce code quality and limit certain patterns or practices.

For **responsivity**, the [`screenutil`](https://pub.dev/packages/flutter_screenutil) package is used to adapt layouts and widgets to different screen sizes and resolutions.
