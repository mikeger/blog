---
marp: true
header: ''
footer: ''
paginate: true
transition: coverflow
---

<style>
/* @font-face {
    font-family: "Outfit";
    src: url("theme/fonts/Outfit-Regular.ttf");
}
@font-face {
    font-family: "Outfit";
    src: url("theme/fonts/Outfit-Bold.ttf");
    font-weight: bold;
} */
section {
  background: white;
  /* font-family: "Outfit"; */
  font-size: 10;
}
h1 {
  font-size: 64;
}
h1, h2, h3 {
  color: #101328;
}
header img {
  float: right;
  margin-right: 30px;

}
header {
  width: 100%;
}

</style>

# THE FAST AND THE CURIOUS: OPTIMIZING PROJECT BUILDS FOR MAXIMUM SPEED

#### Michael 'Mike' Gerasymenko

---

# Where I work

![bg left:33% 50%](./images/elevenlabs-logo-black.svg)

Today, a Mobile Engineer at ElevenLabs
<!-- _header: '' -->
<!-- _footer: '' -->
<!-- _paginate: false -->

--- 

# Where I am from

- Born in Odesa, Ukraine

- Support Odesa local charity [Monstrov.org](https://monstrov.org/stop-war-in-ukraine/)

---

# What is happening where I am from

https://dou.ua/memorial/#RuslanKolosovskyi


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

## Apple Intelligence hallucinating the app?

## Fans spin?

---

# ~~What actually happens during the build?~~

## Not the right question! Let's try "Five Why"'s.

---

## 1. We need to build an app. Why?
## 2. CPU cannot run Swift directly. Why?
## 3. Swift code must be translated to machine code. Why?
## 4. Translation isn’t “just one step”. Why?
## 5. Why does this pipeline feel slow and painful in real life?

---

Swift and other programming languages have a human-friendly syntax, device hardware is expecting a hardware-friendly code to execute. Same applies for the resources.

---

# Xcode is trying it's best

After initial build is complete, next builds are faster. Why?

- Xcode is trying to reuse results of the former builds to make process faster.

---

# So, Xcode is caching the build results?

Yes, we have a clean build and incremental build

---

# Why does it still feels slow?

---

# Compiling Swift is generally slower than compiling many other languages

---

# Your project is big and getting bigger

---

# AI is making your project even bigger

---

# Wait, are you measung it?

- On the CI
- On the local machines

---

# Local: In Xcode

`defaults write com.apple.dt.Xcode ShowBuildOperationDuration YES`

---

# XCMetrics

- Usually I would recommend it, but not today

---

# Upload telemetry to a google sheet

Something I learned in my startup years is that a Google Sheet could be a surprisingly potent database:

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

# How hard caching can be?

> There are only two hard things in Computer Science: cache invalidation and naming things.

Phil Karlton

---

Xcode needs to do a bunch of work to make sure caching happens correctly. 

It's not always easy.

--- 

# Compile time settings

- Defer dSYM creation
- Build active architecture only
- Compilation mode
- Optimization level
- Build system
  - Legacy
  - New (Xcode 10)

---

# What Xcode offers to address this?

- Build Timeline
- Flags to indicate inter-target dependencies
- Xcode 26 Compilation Caching
- Type checking duration

---

# Xcode 26 Compilation Caching

`Enable Compilation Caching`

---

# Side Note: Multi-core and it's bottlenecks

Xcode is optimizing to utilize all available CPU cores to distribute the compilation work.

Some tasks cannot be parallelized (linking, code signing).

---

# Xcode: Build Timeline


--- 

# Xcode: Flags to indicate inter-target dependencies

---

# Warnings for compilation duration

`-Xfrontend -debug-time-function-bodies`
`-warn-long-function-bodies=200`
`-warn-long-expression-type-checking=200`

---

# Why monoliths are bad for incremental builds

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

# Resources packaging



---

# Thank you!

- Dnio by Alvaro Reyes / Unsplash
