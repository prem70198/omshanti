# Product Requirements Document (PRD) — Om Shanti (ॐ शान्ति)

> **Document Version:** 1.0.0  
> **Status:** Active / Production Blueprint  
> **Last Updated:** October 2026  
> **Core Theme:** *Peace Begins Within (शांति आपके भीतर है)* — Digital Meditation Companion & Rajyoga Practice Sanctuary

---


<p align="center">
  <img src="docs/screenshots/paramdham_hero.jpg" alt="Paramdham - The Incorporeal World of Pure Light" width="100%" />
</p>

## 1. Executive Summary & Product Vision

### 1.1 What is Om Shanti?
**Om Shanti** is a modern, cross-platform spiritual wellness and meditation companion app built with Flutter. Inspired by the teachings and universal spiritual heritage of **Rajyoga Meditation** (as taught by the Brahma Kumaris World Spiritual University), the application serves as a dedicated digital sanctuary for inner calm, self-transformation, mindful living, and selfless service.

Unlike generic meditation applications that focus narrowly on productivity hacks or commercial paywalls, **Om Shanti** blends deep spiritual philosophy with everyday digital utility:
* **Time-tested Daily Practice Cycles:** Amritvela (nectar hours of morning meditation) and Numasham (dusk/evening contemplation).
* **Structured Spiritual Curriculum:** Interactive 7-Day Rajyoga Foundation Course.
* **Daily Murli Hub:** Daily wisdom study, audio lectures, and personal reflection diary (*मंथन डायरी*).
* **Purusharth Charting:** Daily spiritual self-governance journal (*दैनिक पुरुषार्थ चार्ट*).
* **Global Community Connection:** Live collective meditation rooms, worldwide center finder, and selfless service (*Seva*) opportunities.

### 1.2 Product Vision
> *"To empower individuals across the globe with accessible, authentic spiritual tools and time-honored meditation practices that foster mental peace, emotional resilience, purity of thought, and compassionate community action."*

### 1.3 Key UI Visual Designs & Interfaces
| Home & Amritvela Sanctuary | Deep Meditation Player | Pranayama Breathing Visualizer | Daily Murli & Journal |
| :---: | :---: | :---: | :---: |
| <img src="docs/screenshots/home_screen.jpg" width="220" /> | <img src="docs/screenshots/meditation_player.jpg" width="220" /> | <img src="docs/screenshots/breathing_visualizer.jpg" width="220" /> | <img src="docs/screenshots/murli_journal.jpg" width="220" /> |

---

## 2. The "WHY": Problem Statement & Value Proposition

### 2.1 The Problem
1. **The Modern Cognitive Crisis:**
   Modern life is characterized by attention fragmentation, digital burnout, chronic anxiety, and decision fatigue. Most digital solutions are superficial relaxation apps or commercial tools filled with aggressive upsells and intrusive notifications.
2. **Scattered Spiritual Resources:**
   Practitioners of Rajyoga and earnest spiritual seekers frequently have to navigate fragmented channels—audio on WhatsApp groups, Murli PDFs on websites, center locations on search engines, and YouTube live streams across disparate links.
3. **Absence of Authentic Spiritual Discipline Tools:**
   Meditation is not merely a 5-minute breathing break; in traditions like Rajyoga, it is a lifestyle of daily remembrance (*Smriti*), introspection, and self-evaluation (*Purusharth*). No unified mobile application offered an integrated system for tracking daily spiritual charts, Amritvela wake-up practice, Murli churning, and community seva.
4. **Language & Cultural Barriers:**
   A large proportion of spiritual seekers prefer native language engagement (particularly Hindi and English). Many global applications fail to provide bilingual spiritual terminology and culturally resonant user experiences.

### 2.2 Our Solution & Value Proposition
**Om Shanti** solves these pain points by offering:
* **All-in-One Spiritual Hub:** Combines meditation audio, breathing visualizers, daily Murli, live group silence sessions, and course learning under one roof.
* **Free & Mindful Experience:** Completely free from commercial paywalls, advertisements, and data exploitation.
* **Authentic Heritage & Design Language:** Built using the sacred spiritual aesthetic of Brahma Kumaris—Paramdham golden-red aura, tranquil celestial blues, and sacred crimson motifs.
* **Bilingual Parity:** Seamless, instantaneous toggle between English and Hindi across the entire user interface and core content.
* **Offline-First Resilience:** Immediate access to favorite meditations, practice charts, and offline notes without needing continuous high-speed internet.

---

## 3. Target Audience & User Personas

| Persona | Profile | Core Motivations & Pain Points | Primary Features Used |
| :--- | :--- | :--- | :--- |
| **Persona A: "The Urban Seeker"** (Priya, 28, Software Engineer) | High-stress professional experiencing anxiety and mental burnout. New to structured meditation. | Wants simple, non-dogmatic guidance, calming breathing exercises, and bite-sized evening unwinding. | • Pranayama / Breathing Visualizer<br>• 7-Day Foundation Course (Day 1: Who Am I?)<br>• Evening Calm playlists |
| **Persona B: "The Dedicated BK Practitioner"** (Ramesh, 54, Educator) | Long-term Rajyoga practitioner following daily disciplines. | Needs punctual Amritvela reminders (4:00 AM), access to the Daily Murli, and a digital version of the traditional spiritual chart (*Purusharth Chart*). | • Practice Schedule & Amritvela alarms<br>• Daily Murli Reader & Audio<br>• Spiritual Journal (*Purusharth Chart*) |
| **Persona C: "The Community & Seva Volunteer"** (Ananya, 35, NGO Worker) | Values community impact and collective meditation energy. | Wants to find nearest meditation retreat centers when traveling and participate in community service projects. | • Center Finder with GPS / Map directions<br>• Live Group Meditation Room<br>• Seva (Selfless Service) Opportunities |

---

## 4. The "WHAT": Feature Breakdown & Requirements

### 4.1 Feature Matrix Overview

```mermaid
mindmap
  root((Om Shanti App))
    Daily Meditation
      Amritvela & Numasham
      Breathing Visualizer
      Ambient Soundscapes & Bell Chimes
      Sleep Timers & Playlists
    Spiritual Wisdom
      7-Day Rajyoga Course
      Daily Murli (Audio + Text)
      Awakening TV & Peace News
      AI Spiritual Resource Guide
    Personal Practice
      Spiritual Purusharth Chart
      Murli Churning Notes Diary
      Meditation Minutes & Streak Tracker
      Saved Favorites & Downloads
    Global Community
      Live Collective Silence Rooms
      Brahma Kumaris Center Locator
      Retreats & Event Registrations
      Seva (Selfless Service) Portal
```

---

### 4.2 Module Deep Dive

#### Module 1: Meditation Player & Sensory Experience
* **Audio Guidance:** Curated guided meditations categorized by state of mind (*Pure Peace, Focus & Clarity, Deep Relaxation, Soul Consciousness, Forgiveness*).
* **Multi-Layer Sensory Audio:** Independent toggles for ambient soundscapes (Gentle Tanpura, Flowing River, Deep Silence, Celestial Pad) and periodic bell chimes (every 3, 5, or 10 minutes).
* **Breathing Visualizer (Pranayama):** Interactive animated visualizer with 4-4-4-4 Box Breathing cadence (Inhale, Hold, Exhale, Stillness) to restore parasympathetic calm.
* **Sleep Timer:** Auto-stop timer presets (10m, 15m, 30m, 60m).

#### Module 2: Daily Spiritual Disciplines & Schedules
* **Amritvela (अमृतवेला - 4:00 AM):** Dedicated early morning remembrance session with automatic alarms, silence trackers, and custom alerts.
* **Traffic Control of the Mind:** Hourly 1-minute mindfulness pauses throughout the day.
* **Numasham (नुमाशाम - 6:30 PM):** Twilight meditation to cleanse the day's mental impressions before nightfall.
* **Custom Practice Alarms:** Users can customize their meditation schedule with daily recurring notifications.

#### Module 3: 7-Day Rajyoga Foundation Course
A step-by-step interactive spiritual curriculum:
1. **Day 1: Who Am I? (आत्म दर्शन):** Consciousness, the soul, and its three faculties (Mind, Intellect, Impressions).
2. **Day 2: Who is God? (परमात्मा दर्शन):** The Supreme Soul Shiva, His form of radiant incorporeal light, and attributes.
3. **Day 3: The Three Worlds (तीन लोक):** Physical universe (*Sakaar*), Subtle realm (*Aakaar*), and World of Soul Silence (*Paramdham/Nirvana*).
4. **Day 4: The Law of Karma (कर्म का गूढ़ रहस्य):** Cause, effect, intentions, and breaking karmic bondages.
5. **Day 5: The Eternal World Drama (काल चक्र / सृष्टि चक्र):** The 5000-year cycle of Golden, Silver, Copper, and Iron ages.
6. **Day 6: The Tree of Religions (सृष्टि कल्प वृक्ष):** The genealogical growth of world faiths and universal brotherhood.
7. **Day 7: Rajyoga Lifestyle & Principles (राजयोग जीवन शैली):** Four pillars of purity: Pure Diet (*Sattvic Ahara*), Pure Company (*Satsang*), Study (*Gyan*), and Remembrance (*Yoga*).
* *Includes: Lesson reading, audio reflection, self-inquiry reflection question, and completed lesson badge persistence.*

#### Module 4: Daily Murli Hub (आज की मुरली)
* **Daily Mahavakyas:** Morning spiritual discourse text in both English and Hindi.
* **Key Components:**
  * Essence (*सार*)
  * Question & Answer (*प्रश्न-उत्तर*)
  * Essence for Dharna (*धारणा के लिए मुख्य सार*)
  * Blessing (*वरदान*)
  * Slogan (*स्लोगन*)
* **Murli Churning Diary (*मंथन डायरी*):** Built-in personal note-taking screen tied to each day's Murli for writing daily realizations.

#### Module 5: Spiritual Purusharth Chart (दैनिक पुरुषार्थ चार्ट)
Digital transformation of the traditional BK daily self-check chart:
* Early morning Amritvela practice duration (mins).
* Traffic control pauses observed.
* Murli study completed (Yes/No).
* Food prepared & eaten in spiritual remembrance (Yes/No).
* Control over speech, anger, and peaceful interactions (Rating 1–5).
* Historical log viewing and streak tracking.

#### Module 6: Live Meditation Rooms (सामूहिक योग)
* Real-time live room simulation featuring collective silence sessions broadcast from Madhuban (Mount Abu).
* Real-time participant counter reflecting global seekers meditating together.
* Live peaceful thought chat (*"Om Shanti, sending vibrations of peace"*) with spam control.
* "Raise Hand" / "Send Peace Vibrations" interactive haptic button.

#### Module 7: Global Center Locator
* Directory of worldwide Brahma Kumaris Raja Yoga centers.
* Real-time distance calculation (`x km away`), address, and contact information.
* One-click phone calling and Google Maps direction routing.
* Daily center program schedule display.

#### Module 8: Seva (Selfless Service) Portal
* Discover verified volunteer opportunities across 4 wings:
  1. **Environment:** Tree planting, water conservation, eco-ashram maintenance.
  2. **Value Education:** Teaching moral values and Rajyoga in schools/colleges.
  3. **Community Harmony:** Peace rallies, blood donation camps, prison rehabilitation.
  4. **Meditation Outreach:** Organizing public meditation stalls and spiritual fairs.
* In-app one-click application and logged volunteer hours tracking.

#### Module 9: AI Spiritual Resource Guide
* Context-aware spiritual inquiry assistant.
* Answers questions regarding meditation techniques, course concepts, coping with grief, overcoming anger, and finding approved BK literature.

#### Module 10: Localization, Theming & Accessibility
* **Bilingual System:** Instant 1-tap switch between English and Hindi without app reload.
* **Dual Spiritual Theme:**
  * **Day Theme (Pure Ivory):** Serene warm white canvas inspired by white BK attire.
  * **Paramdham Night Theme (Cosmic Void):** Deep dark theme optimized for night and 4 AM Amritvela meditation in pitch darkness.

---

## 5. Non-Functional Requirements (NFRs)

| Category | Requirement Specification |
| :--- | :--- |
| **Performance** | • 60 FPS smooth rendering during audio animations & breathing visualizer.<br>• App cold start time < 1.2 seconds.<br>• Memory footprint < 90MB on standard mobile devices. |
| **Offline Resilience** | • 100% offline functionality for saved meditations, charts, notes, and the 7-day course.<br>• SharedPreferences JSON caching with instantaneous disk read/write. |
| **Privacy & Security** | • Zero telemetry tracking or third-party ad SDKs.<br>• All journal reflections, purusharth charts, and notes are stored strictly local-on-device unless user opts for cloud sync. |
| **Accessibility (a11y)** | • High-contrast typography supporting dynamic text scaling.<br>• Clear visual touch targets (> 48x48dp) for elderly practitioners. |
| **Cross-Platform Compatibility** | • Uniform experience across Android (API 21+), iOS (13+), and modern Web browsers. |

---

## 6. Success Metrics & Key Performance Indicators (KPIs)

1. **Daily Practice Adherence (DPA):** Percentage of users who complete either an Amritvela or Numasham meditation session at least 4 days a week.
2. **7-Day Course Completion Rate:** Percentage of new seekers completing all 7 lessons within 14 days of install.
3. **Daily Purusharth Chart Retention:** Average number of consecutive days a user fills their spiritual chart.
4. **Community Engagement:** Registrations for online/offline retreats and Seva applications submitted via the portal.

---

## 7. Future Product Roadmap

* **Phase 2 (Q1 2027):** Real-time WebRTC audio room streaming directly from Madhuban (Mount Abu).
* **Phase 3 (Q2 2027):** Wearable OS Companion app (Apple Watch / Wear OS) with subtle haptic tap alarms for hourly Traffic Control of the mind.
* **Phase 4 (Q3 2027):** Multi-language expansion to Gujarati, Tamil, Telugu, Spanish, and French.
