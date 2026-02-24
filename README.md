# FocusFlow Pro

**FocusFlow Pro** is a minimalist app for mindful work and focus tracking.  
It helps you quickly capture tasks, start focus sessions with a timer, track your energy during the day, and see simple progress analytics without heavy dashboards.

---

## ✨ Features

### 🕒 Focus Sessions (Pomodoro style)
- Circular timer with smooth animation.
- Preset durations: **15 / 25 / 50 minutes** (choose before starting).
- Timer **keeps running** even when you switch to another tab.
- Finished sessions are saved automatically in history.

### ✅ Tasks
- Simple daily task list: **title, category, priority, effort** (Light / Standard / Deep).
- Filter by category.
- Quick actions: checkbox, swipe actions, context menu (`Start Focus` / `Complete`).
- Clean “Add Task” screen with glass-style cards.

### 🔋 Energy Check-in
- Quick energy level check: 😴 / 😐 / 🔥
- Energy level is linked to focus sessions.

### 📊 Analytics
- Total completed tasks (all time).
- Total focus time (minutes).
- Smart text insights based on your habits (lots of focus / lots of tasks / low activity).
- 30-day calendar heatmap based on focus sessions.

### 🧊 Soft UI (Glassmorphism)
- Custom glass cards: `GlassCard`
- Blurred colorful background shapes: `BlurredBackground`
- Supports light/dark mode via `AppTheme` + system colors

---

## 🧱 Tech Stack

- **SwiftUI** — declarative UI, custom tab bar, animations, glass cards
- **Combine** — focus timer built with `Timer.publish`
- **ObservableObject / @StateObject / @ObservedObject / @EnvironmentObject** — state management
- **Persistence** — simple JSON storage via `PersistenceService`
- **Haptics** — haptic feedback via `HapticService`

---

## 🏗 Project Structure

```text
App/
  FocusFlowProApp.swift
  RootContainerView.swift
  AppState.swift

Navigation/
  MainTabView.swift
  CustomTabBar.swift
  Tab.swift

Screens/
  Dashboard/
  Focus/
  Tasks/
  Analytics/
  Energy/
  Settings/
  Launch/

Components/
  CircularProgressView.swift
  CircularTimerView.swift
  EnergySelectorView.swift
  SectionHeaderView.swift

Models/
  Task, TaskCategory, TaskPriority
  FocusSession
  EnergyEntry, EnergyLevel

Services/
  PersistenceService.swift
  HapticService.swift
  SmartInsightEngine.swift

Theme/
  AppTheme.swift
  GlassCard.swift
  GradientBackground.swift
  BlurredBackground (UIComponents.swift)

```
⸻

## ⚙️ Getting Started

1) Clone the repository

```
git clone https://github.com/PashchenkoIvan/FocusFlowPro.git
cd FocusFlowPro
```

2) Open in Xcode
	•	Open FocusFlowPro.xcodeproj (or your workspace).
	•	Make sure the FocusFlowPro target is selected.

3) Build & Run
	•	Choose a simulator (e.g. iPhone 15 Pro)
	•	Press Run (⌘ + R)

No third-party dependencies (CocoaPods/SPM). Built with standard SwiftUI/Combine only.

⸻

## 💡 How to Use

### Dashboard
	•	Top: date + “Today”
	•	Quick cards:
	•	Focus session → timer screen
	•	Energy check-in → energy screen
	•	Today Focus: circular progress + completion percent
	•	Insight: short habit-based message
	•	Today’s Tasks: up to 4 tasks (more on Tasks screen)

### Focus
	•	Choose duration: 15 / 25 / 50
	•	Choose energy level (emoji)
	•	Tap Start
	•	Timer counts down
	•	You can switch tabs — timer continues in background
	•	Tap Pause / Reset if needed
	•	When timer ends:
	•	Haptic notification
	•	Session saved to FocusSessions + shown in analytics

### Tasks
	•	Add:
	•	Tap floating +
	•	Enter title + choose category/priority/effort
	•	Tap Add Task
	•	Manage:
	•	Tap left icon to toggle status (planned/done)
	•	Swipe left:
	•	Complete — finish task
	•	Focus — go to focus screen
	•	Long-press for context menu actions

### Analytics
	•	Completed Tasks — total tasks done
	•	Focus Time — total focus minutes
	•	Insight — short message based on activity
	•	Last 30 Days — calendar heatmap (sessions per day)

### Energy Check-in
	•	Choose 😴 / 😐 / 🔥 and tap Save
	•	Adds an EnergyEntry to history (can be used later for deeper analytics)

### Settings
	•	Dark Mode — force dark theme
	•	Haptics — enable/disable haptics
	•	About FocusFlow Pro — app philosophy
	•	Reset All Data — clears tasks, sessions, and check-ins (danger zone)

⸻

## 🧩 Key Implementation Notes
	•	Timer lives at the tab level
	•	FocusViewModel is created as @StateObject in MainTabView
	•	Passed to FocusView as @ObservedObject
	•	This keeps the timer running while switching tabs
	•	Theme support
	•	AppState.isDarkMode controls .preferredColorScheme
	•	AppTheme uses system colors (Color(.systemBackground), Color.primary, Color.secondary)
	•	Reusable glass cards
	•	GlassCard standardizes padding, corner radius, border, and shadow

⸻

## 🛣 Roadmap / Ideas
	•	Show active focus indicator in the tab bar (small progress around the timer icon)
	•	Add deeper energy analytics (e.g. “focus vs energy by weekday” chart)
	•	Add localization (RU/EN) via Localizable.strings
	•	Link focus sessions to a specific task (taskId already exists in FocusSession)

