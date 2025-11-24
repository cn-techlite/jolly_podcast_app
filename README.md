# Overview Jolly Podcast App

- A simplified, functional podcast application built with Flutter, using MVC architecture, Riverpod state management, and GetIt for dependency injection & token persistence.


##  Features Overview

- ✅ Authentication

Login using API (phone + password)

Error handling for incorrect credentials

Saves token + userId using GetIt service

- ✅ Podcast List

Fetches all podcasts using token-authenticated request

Displays:

Podcast title

Thumbnail

Clean UI matching Figma layout

- ✅ Podcast Player

Dedicated episode details page

Functional audio playback using just_audio

Custom-designed slider matching Figma mockup

Prevents multiple audio streams (only one plays at a time)

Supports:

Play / Pause

Seek

Live position + duration updates

Handles audio errors gracefully

- 🧱 Architecture

The project follows a clean MVC Architecture:


lib/
 ├── models/
 ├── controllers/
 ├── services/
 ├── views/
 ├── widgets/
 ├── state/  (Riverpod)
 └── core/

Models → data structures (LoginModel, PodcastModel, PlayerStateModel)

Controllers → business logic (Audio controller, Auth controller)

Services → API calls, local storage, dependency injection

Views → Screens (Login, PodcastList, PodcastDetail)

State → Riverpod AsyncNotifiers for reactive UI

Core → App theme, constants, helpers

🎨 UI / UX Reference
Figma Design

All UI layouts follow the provided design:
🔗 https://www.figma.com/design/JvuptFe2YT64HJ1YjQJsnF/Jolly-Podcast-test?node-id=0-1&p=f

Pixel-perfect accuracy isn't required, but spacing, layout structure, and visual hierarchy are faithfully implemented.

🔌 API Documentation

The app integrates with the official test Swagger API:

🔗 http://13.49.46.240:9000/#/Consumer/get_api_podcasts__podcastId__status

✔ Login
✔ Podcast list
✔ Fetch single podcast
✔ Token-based authorization included

🧪 Test Login Credentials
Field	Value
Phone	08114227399
Password	Development@101

🧩 State Management – Riverpod

The project uses Riverpod (AsyncNotifier) as the main state management system.

Key Providers:

podcastControllerProvider → fetches podcast list

playerStateControllerProvider → handles audio playback

currentAudioManagerProvider → ensures only one audio stream plays at a time


📘 Assumptions Made

✔ The API URLs will remain stable
✔ Podcast audio links are valid remote URLs
✔ Token stays valid through the testing session
✔ No logout flow was required
✔ No pagination needed for podcast list

🛠 What I Would Improve With More Time
1. Add global mini-player

Persistent bottom player like Spotify.

2. Implement full audio queue system

Support playlists and episode auto-play.

3. Expand error handling

Retry logic, offline mode, caching.

4. Unit tests & integration tests

Especially for API and audio logic.

5. Add animations

Smooth transitions, shimmer loading.

6. Local caching

Hive database for downloaded episodes.