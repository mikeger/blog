---
marp: true
header: ''
footer: ''
paginate: true
transition: coverflow
---

<style>
@font-face {
  font-family: "InstrumentSerif";
  src: url("fonts/InstrumentSerif-Regular.ttf");
  font-style: normal;
  font-weight: 400;
}
@font-face {
  font-family: "InstrumentSerif";
  src: url("fonts/InstrumentSerif-Italic.ttf");
  font-style: italic;
  font-weight: 400;
}
@font-face {
  font-family: "IBMPlexSans";
  src: url("fonts/IBMPlexSans-VariableFont_wdth,wght.ttf");
  font-style: normal;
  font-weight: 100 900;
}
@font-face {
  font-family: "IBMPlexSans";
  src: url("fonts/IBMPlexSans-Italic-VariableFont_wdth,wght.ttf");
  font-style: italic;
  font-weight: 100 900;
}

/* Global slide typography */
section {
  background: white;
  color: #333;
  font-family: "IBMPlexSans";
  font-size: 36px;
  line-height: 1.35;
  padding: 80px 120px;
}

/* Title hierarchy */
h1 {
  font-size: 76px;
  line-height: 1.08;
  letter-spacing: -0.5px;
  margin: 0 0 22px 0;
}

h2 {
  font-size: 56px;
  line-height: 1.12;
  letter-spacing: -0.3px;
  margin: 0 0 18px 0;
}

h3 {
  font-size: 44px;
  line-height: 1.18;
  margin: 0 0 14px 0;
}

h4 {
  font-size: 38px;
  line-height: 1.22;
  margin: 0 0 12px 0;
}

h1, h2, h3, h4 {
  color: #0A0F25;
  font-family: "InstrumentSerif";
  font-style: italic;
}

/* Body text rhythm */
p {
  margin: 18px 0 0 0;
}

ul {
  margin: 18px 0 0 0;
  padding-left: 1.15em;
}

ul li {
  margin: 10px 0;
}

strong {
  font-weight: 650;
  color: #0A0F25;
}

em {
  font-style: italic;
  color: #555;
}

/* Header tweaks */
header img {
  float: right;
  margin-right: 30px;
}

header {
  width: 100%;
}
</style>

# THE FAST AND THE CURIOUS: OPTIMIZING PROJECT BUILDS FOR MAXIMUM SPEED

Michael 'Mike' Gerasymenko

Appdevcon 2026

<!-- _paginate: false -->
---

# Where I work

![bg left:33% 50%](./images/elevenlabs-logo-black.svg)

Mobile at ElevenLabs
Remotely from Berlin

Read me: [gera.cx](https://gera.cx)


<!-- _header: '' -->
<!-- _footer: '' -->

--- 

# Where I am from

Born in Odesa, Ukraine

Local charity [Monstrov.org](https://monstrov.org/stop-war-in-ukraine/)

![bg right](./images/flower.jpg)

---

# What is happening where I am from

https://dou.ua/memorial/

---

# Let's meditate

- Close your eyes and imagine
- Your day is starting
- You picked a fresh drink
- You are at your workstation
- Ray of sun is illuminating your work desk
- The project is open, and you know exactly what you need to do
- You do the changes and run the project
- In a snap, your product is launched and you can see the results of your work

---

# Does it work this way in your reality?

- I can tell for sure my reality is different.

---

# My last talk was at Swift Connection 2025

- Met Peter Steinberger
- He thinks mobile development is cooked
- His web technologies based projects build and test time is measured in seconds

_Well, he also thinks we don't need mobile apps all together, but let's focus at one thing at a time._

---

# Have we got used to the current state of affairs?

Is there anything we can do?

---

# Let's start from the beginning

---

![bg](./images/objc.jpg)

<!-- No, not from Objective-C -->
<!-- _header: '' -->
<!-- _footer: '' -->
<!-- _paginate: false -->

---

# Warning! We are going to go through a lot of slides

---

# What actually happens during the build?

---

## Xcode meditate?

## Fans spin?

---

# ~~What actually happens during the build?~~

## Not the right question! Let's try "Five Why"'s.

---

**`01`** We need to build an app. Why?
**`02`** CPU cannot run Swift directly. Why?
**`03`** Swift code must be translated to machine code. Why?
**`04`** Translation isn’t “just one step”. Why?
**`05`** Why does this pipeline feel slow and painful in real life?

---

Swift and other programming languages have a human-friendly syntax, device hardware is expecting a hardware-friendly code to execute. Same applies for the resources.

---

# Xcode is trying it's best

And it's getting better over time.

After initial build is complete, next builds are faster. Why?

→ Xcode is trying to reuse results of the former builds to make process faster.

---

# So, Xcode is caching the build results?

Yes, we have a clean build and incremental build.

---

# Why does it still feels slow?

---

# `01` Compiling Swift is generally slower than compiling many other languages

---

# `02` Your project is big and getting bigger

---

# `03` AI is making your project even bigger (slop)

---

# Different goals

For CI, clean build must be optimized
For local development, incremental builds must be fast

---

# We are going to use three metrics

**`01`** Clean Build _<sub>Δ</sub>t_
**`02`** Incremental (no changes)
**`03`** Incremental (one file change)

Let's take the initial value as 100% to help following the improvements.

---

# Local: In Xcode

`defaults write com.apple.dt.Xcode ShowBuildOperationDuration YES`

![Xcode screenshot from the top status bar showing the build time after the build](./images/xcode-time-report.png)

---

# XCMetrics

→ Usually I would recommend it, but not today
→ Server side component is not building on modern Xcode
→ No updates in two years
→ Spotify moved on? Any Spotify engineers in the audience?

---

# Your CI provider

You probably already know how long your build is taking on the CI, but do you keep track of the build time vs test time?

---

# Upload telemetry to a Google Sheet

<!-- Something I learned in my startup years is that a Google Sheet could be a surprisingly potent database.
Startup mindset
 -->

```ruby
require "google/apis/sheets_v4"
require "googleauth"
require "googleauth/stores/file_token_store"

// given spreadsheet_id and service_account_json

service = Google::Apis::SheetsV4::SheetsService.new
service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
          json_key_io: StringIO.new(service_account_json),
          scope: Google::Apis::SheetsV4::AUTH_SPREADSHEETS)

// values_rows contain the values to upload

value_range_object = Google::Apis::SheetsV4::ValueRange.new(majorDimension: "ROWS", values: values_rows)

response = service.append_spreadsheet_value(
          spreadsheet_id,
          stat_name + "!A2",
          value_range_object,
          value_input_option: VALUE_INPUT_OPTION)
```

---

# Improving incremental and clean builds: Caching

---

# How hard caching can be?

> There are only two hard things in Computer Science: cache invalidation and naming things.

Phil Karlton

---

Xcode needs to do a bunch of work to make sure caching happens correctly. 

It's not always easy.

--- 

# Compile Time Settings

→ Defer dSYM creation
→ Build Active Architecture Only / Architectures
→ Compilation Mode
→ Optimization Level
→ Build system (Legacy vs New Xcode 10)

---

# Baseline

---

# dSYM

`DEBUG_INFORMATION_FORMAT[config=Debug] = dwarf`

---

# Build Active Architecture Only / Architectures

`ARCHS = arm64 x86_64`
`ONLY_ACTIVE_ARCH[config=Debug] = YES`

---

# Compilation Mode

`SWIFT_COMPILATION_MODE[config=Debug] = singlefile`
`SWIFT_COMPILATION_MODE[config=Release] = wholemodule`

---

# Optimization Level

`SWIFT_OPTIMIZATION_LEVEL[config=Debug] = -Onone`
`SWIFT_OPTIMIZATION_LEVEL[config=Release] = -O`

---

# Basics done, what Xcode offers to address build time?

→ Build Timeline
→ Flags to indicate inter-target dependencies
→ Xcode 26 Compilation Caching
→ Type Checking Duration

---

# Xcode 26 Compilation Caching

`Enable Compilation Caching`

---

# Xcode: Build Timeline

--- 

# Xcode: Flags to indicate inter-target dependencies

---

# Warnings for compilation duration

Build settings -> Other Swift Flags

```
-Xfrontend -warn-long-expression-type-checking=20
-Xfrontend -warn-long-function-bodies=50
-Xfrontend -debug-time-function-bodies
-Xfrontend -debug-time-compilation
-Xfrontend -driver-time-compilation
```

---

# Multi-core and it's Bottlenecks

Xcode is optimizing to utilize all available CPU cores to distribute the compilation work.

Some tasks cannot be parallelized (linking, code signing).

---

# Why Monoliths Are Bad for Incremental Builds

---

# Enter Modularization

---

# Tuist, Bazel & Buck

| Problem | Xcode native | Tuist | Bazel & Buck |
|--------|--------------|-------|-------|
| Graph clarity | meh | good | strict |
| Remote cache | no | yes | yes |
| Dev friction | low | low | high |
| Migration cost | none | low | extreme |

---

# Resources Packaging

Cocoapods are deprecated. In case you are still using them, stop. 

Also, they have a significant issue with asset catalog compilation, read more here:

https://gera.cx/posts/cocoapods-resources

---

# Thank you!

- Dnio by Alvaro Reyes / Unsplash
- Sunflower by Wolfgang Hasselmann / Unsplash
