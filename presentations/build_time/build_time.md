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
  background: #050505;
  color: #F5F5F5;
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
  color: #FFFFFF;
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

pre, code {
  background: #0A0A0A;
  color: #FFFFFF;
  font-family: "Menlo", "IBMPlexSans", monospace;
  font-weight: 500;
  letter-spacing: 0.15px;
}

.hljs-symbol {
font-family: "Menlo", "IBMPlexSans", monospace;
}

pre {
  padding: 26px;
  border-radius: 18px;
  border: 1px solid #3A3A3A;
  box-shadow: 0 30px 70px rgba(0,0,0,0.65);
}

pre code {
  background: transparent;
  color: inherit;
  padding: 0;
}

code {
  padding: 4px 10px;
  border-radius: 8px;
  border: 1px solid #3A3A3A;
}

.hljs {
  color: #F8F8F2;
}

.hljs-keyword,
.hljs-selector-tag,
.hljs-literal {
  color: #FF7EA8;
  font-weight: 600;
}

.hljs-string,
.hljs-title,
.hljs-name {
  color: #8BE9FD;
}

.hljs-comment {
  color: #7E8C99;
}

.hljs-number,
.hljs-attr {
  color: #F1FA89;
}

table {
  width: 100%;
  border-collapse: collapse;
  margin: 28px 0 0 0;
  background: #0B0B0B;
  color: #F0F0F0;
}

th, td {
  border: 1px solid #2A2A2A;
  padding: 16px 20px;
  text-align: left;
}

th {
  background: #141414;
  font-weight: 700;
  color: #FFFFFF;
}

td {
  background: #0F0F0F;
  color: #F0F0F0;
}

tbody tr:nth-child(even) td {
  background: #141414;
}

strong {
  font-weight: 650;
  color: #FFFFFF;
}

em {
  font-style: italic;
  color: #CFCFCF;
}

/* Header tweaks */
header img {
  float: right;
  margin-right: 30px;
}

header {
  width: 100%;
}

section.title {
  position: relative;
  overflow: hidden;
}

section.title::after {
  content: "";
  position: absolute;
  inset: 0;
  background: radial-gradient(circle at 45% 40%, rgba(5,5,5,0.05), rgba(0,0,0,0.8));
  z-index: 0;
}

section.title > * {
  position: relative;
  z-index: 1;
}

section.title h1,
section.title p {
  text-shadow: 0 6px 22px rgba(0,0,0,0.8), 0 0 30px rgba(0,0,0,0.6);
}
</style>

<!-- _class: title -->

# The Fast and the Curious: Optimizing Projects for Maximum Speed
Michael 'Mike' Gerasymenko

Appdevcon 2026

![bg right:](images/adrien-olichon-tftHxIuPPu8-unsplash.jpg)

<!-- _paginate: false -->

---

# Who I am

<!-- TODO -->

---

# Where I work

![bg left:33% 70%](./images/elevenlabs-logo-black.svg)

Mobile at ElevenLabs (we are hiring)
Building the Reader App
Remotely from Berlin

Read me: [gera.cx](https://gera.cx)

![width:200](images/qr-gera-cx.png)

<!-- _header: '' -->
<!-- _footer: '' -->

--- 

# Where I am from

Born in Odesa, Ukraine

Local charity [Monstrov.org](https://monstrov.org/stop-war-in-ukraine/)

![width:200](images/qr-monstrov.png)

![bg right](./images/odesa.png)

---

# What is happening where I am from

https://dou.ua/memorial/ ![width:200 bg right:20%](images/memorial-qr.png)


![width:140 height:204](images/memorial-RUSLAN_KOLOSOVSKYI.png) ![width:140 height:204](images/memorial_MYKOLA_HUK.png) ![width:140 height:204](images/memorial_RUSLAN_IVAKHNENKO.png) ![width:140 height:204](images/memorial_VIACHESLAV_BUKOVSKYI.png) ![width:140 height:204](images/memorial_VIKTORIA_AMELINA.png)

---

# Imagine

→ Close your eyes and imagine
→ Your day is starting
→ Ray of sun is on your work desk
→ The project is open, and you know exactly what you need to do
→ You do the changes and run the project
→ In a snap, your app is launched <!-- and you can see the results of your work -->

![bg 110% left:33%](./images/thinker-inverted.png)

---

# Is it easy to imagine?

I can tell for sure my reality is different

---

# Is it impactful?


---

# Thought Leaders

![bg left 90%](./images/swift-connection.jpg)

→ Met Peter Steinberger
→ He thinks mobile development is cooked
→ His web projects build and test time is measured in seconds

<!-- _Well, he also thinks we don't need mobile apps all together, but let's focus at one thing at a time._ -->

---

# Have we got used to the current state of affairs?

---

# Let's start from the beginning
<!--
---

![bg](./images/objc-inverted.jpg)

<!-- No, not from Objective-C -->
<!-- _header: '' -->
<!-- _footer: '' -->
<!-- _paginate: false -->

---

# Warning! We are going to go through a lot of slides

---

# What actually happens during the build?

![bg right](./images/ruins-inverted.jpg)

<!-- 
---

## Xcode meditate?

## Fans spin? -->

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

# `03` AI is making your project even bigger

---

# Different goals

→ For CI, clean build must be optimized
→ For local development, incremental builds must be fast

---

# We are going to use three metrics

**`Σ`** Clean Build
**`δ`** Incremental Build

<!-- Let's take the initial value as 100% to help following the improvements. -->

![bg right:33%](./images/scholar.jpg)
<!-- _paginate: false -->

---

# Measuring

---

# Local: In Xcode

`defaults write com.apple.dt.Xcode ShowBuildOperationDuration YES`

![Xcode screenshot from the top status bar showing the build time after the build](./images/xcode-time-report.png)


---

# Xcode: Build Timeline (**`Σ`** Clean Build)

![](./images/clean.png)

Editor → Open Timeline

---

# Xcode: Build Timeline (**`δ`** Incremental Build)

![](./images/incremental.png)

→ **`Σ`** Clean Build depends on the number of cores
→ **`δ`** Incremental Build on the core performance

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

# Upload Telemetry to a Google Sheet

<!-- Something I learned in my startup years is that a Google Sheet could be a surprisingly potent database.
Startup mindset
 -->

```ruby
require "google/apis/sheets_v4"
require "googleauth"
require "googleauth/stores/file_token_store"

# given spreadsheet_id and service_account_json

service = Google::Apis::SheetsV4::SheetsService.new
service.authorization = Google::Auth::ServiceAccountCredentials.make_creds(
          json_key_io: StringIO.new(service_account_json),
          scope: Google::Apis::SheetsV4::AUTH_SPREADSHEETS)

# values_rows contain the values to upload

value_range_object = Google::Apis::SheetsV4::ValueRange.new(majorDimension: "ROWS", values: values_rows)

response = service.append_spreadsheet_value(
          spreadsheet_id,
          stat_name + "!A2",
          value_range_object,
          value_input_option: VALUE_INPUT_OPTION)
```

---

# Let's Make it Faster

---

# Less is More

→ Please don't forget to remove features
→ Start by checking disabled feature flags
→ [peripheryapp/periphery](https://github.com/peripheryapp/periphery) can help

![bg left:33%](./images/struggle-inverted.jpg)

---

# Caching

---

# How hard caching can be?

> There are only two hard things in Computer Science: cache invalidation and naming things.

Phil Karlton

![bg left:33%](./images/beast-inverted.jpg)

---

# So It's Actually Hard

Xcode needs to do a bunch of work to make sure caching happens correctly. 

It's not always easy.

---

# Basic work Xcode does

→ Target dependency graph
→ Swift file dependency tracking
→ Swift incremental compilation
→ Previous build records
→ File timestamp changes

---

# Common Things to look at

→ Correct target inputs and outputs
→ Avoid scripts changing files every time
→ Check build timeline

---

# Xcode 26 Compilation Caching

`Enable Compilation Caching`

→ Xcode stores compiled artifacts keyed by the content of the inputs
→ “Have we ever compiled this exact input before?”

--- 

# Compile Time Settings

![bg right:33%](./images/warrior.jpg)

---

# dSYM

### Affecting: **`δ`** Incremental

`DEBUG_INFORMATION_FORMAT[config=Release] = dwarf-with-dsym`
`DEBUG_INFORMATION_FORMAT[config=Debug] = dwarf`

---

# Architectures

### Affecting: **`δ`**, **`Σ`**

`ARCHS = arm64 x86_64`
`ONLY_ACTIVE_ARCH[config=Debug] = YES`

---

# Compilation Mode

### Affecting: **`δ`** Incremental

`SWIFT_COMPILATION_MODE[config=Debug] = singlefile`
`SWIFT_COMPILATION_MODE[config=Release] = wholemodule`

---

# Optimization Level

### Affecting: **`δ`** Incremental

`SWIFT_OPTIMIZATION_LEVEL[config=Debug] = -Onone`
`SWIFT_OPTIMIZATION_LEVEL[config=Release] = -O`

---

# High Level Build Steps

Xcode → swift-driver → swift-frontend → LLVM → linker

---

# Swift Driver

→ Analyzes inputs
→ Constructs the compilation plan
→ Schedules compilation jobs
→ Invokes swift-frontend, LLVM, linker, etc.
→ Manages incremental builds and dependencies

<!--
When builds feel slow, we often blame the compiler.
But most of the time, the driver is making conservative decisions because it cannot safely reuse results.

If you change one file:

Driver decides:

👉 only recompile that file
👉 recompile dependent files
👉 rebuild whole module
👉 invalidate downstream modules
-->

--- 

# Xcode: Flags to indicate inter-target dependencies

**`01`** Build Phases → Target Dependencies

**`02`** Library Configuration
`BUILD_LIBRARY_FOR_DISTRIBUTION`
`SWIFT_ENABLE_LIBRARY_EVOLUTION`
`SWIFT_MODULE_INTERFACE`

<!-- TODO: clarify if needed -->

**`03`** Run Script Input/Output configuration

<!-- When we talk about incremental builds, one hidden problem is how changes propagate across module boundaries.

By default, Swift modules are extremely fragile from a build-system perspective.
A tiny public API change can invalidate every downstream target and force a rebuild of a large portion of your dependency graph.

That’s where these settings come in.

⸻

BUILD_LIBRARY_FOR_DISTRIBUTION enables stable module interfaces.
Instead of depending on compiler-specific binary metadata, downstream targets can rely on a textual interface that survives compiler updates and reduces rebuild churn.

⸻

SWIFT_ENABLE_LIBRARY_EVOLUTION allows a module to evolve without breaking its ABI.
This is especially useful for frameworks and shared modules that change frequently but shouldn’t force massive recompilation of dependents.

⸻

And SWIFT_MODULE_INTERFACE generates .swiftinterface files, which are human-readable module descriptions.
These interfaces make dependency boundaries clearer and help the build system understand what actually changed.

⸻

The important takeaway is not the flags themselves.

The real idea is:

Stable module boundaries reduce cache invalidation and improve incremental builds.

In other words, build speed is strongly influenced by API stability and module design, not just compiler performance.
-->

---

# Warnings for Compilation Duration

Build settings → Other Swift Flags (`OTHER_SWIFT_FLAGS`)

```
-Xfrontend -warn-long-expression-type-checking=100
-Xfrontend -warn-long-function-bodies=100
```

---

# Other Useful Flags 

```
-Xfrontend -debug-time-function-bodies
-Xfrontend -debug-time-compilation
-Xswiftc -driver-time-compilation
-Xfrontend -stats-output-dir
```

<!-- 
When builds feel slow, the instinct is often to guess where the time is going.
But modern Swift compilation is complex enough that guessing usually leads to optimizing the wrong thing.

These flags help turn compilation into something measurable.

⸻

-Xfrontend -debug-time-function-bodies reports how long each function takes to compile and type-check.
This is extremely useful for identifying problematic expressions, especially in SwiftUI or heavily generic code, where a single function can silently add seconds to build time.

⸻

-Xfrontend -debug-time-compilation gives a higher-level breakdown of frontend compilation phases.
It helps answer the question: is the compiler slow, or is a specific part of the pipeline slow?

⸻

-Xswiftc -driver-time-compilation operates one level higher — at the compiler driver.
It shows how long each compilation job takes, which is useful when investigating scheduling, parallelization, or unexpectedly repeated compile tasks.

⸻

And finally, -Xfrontend -stats-output-dir exports structured compiler statistics.
This is more advanced, but it allows teams to aggregate compilation metrics over time and build their own telemetry around build performance.

⸻

 -->


---

# Why Monoliths Are Bad for Incremental Builds

→ Hard for Xcode to understand the cause and effect and dependencies inside of the module.
→ Also, same for humans and AI.

---

# Enter Modularization

![bg right:33%](./images/nice-architecture-inverted.jpg)

<!-- _paginate: false -->

---

# Other great tools

---

# Tuist

→ 

---

# Bazel & Buck

→ 

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

![bg left:33%](./images/sea-beasts-inverted.jpg)

→ Cocoapods are deprecated.
→ Also, cocoapods have a significant issue with asset catalog compilation
→ https://gera.cx/posts/cocoapods-resources

---

# Thank you!

![bg right:33%](./images/happy-inverted.jpg)

→ Art Institute of Chicago
→ Adrien Olichon 
→ Some AI for style transfer

<!-- _paginate: false -->
<!-- - Dnio by Alvaro Reyes / Unsplash 
- Sunflower by Wolfgang Hasselmann / Unsplash-->
