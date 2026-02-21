---
marp: true
header: ''
footer: ''
paginate: true
transition: coverflow
---

<style>
@font-face {
    font-family: "Outfit";
    src: url("theme/fonts/Outfit-Regular.ttf");
}
@font-face {
    font-family: "Outfit";
    src: url("theme/fonts/Outfit-Bold.ttf");
    font-weight: bold;
}
section {
  background: white;
  font-family: "Outfit";
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

Today, a Mobile Engineer at ElevenLabs:
<<ElevenLabs>>
<!-- _header: '' -->
<!-- _footer: '' -->
<!-- _paginate: false -->

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

# Compiling Swift is slow

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

# Optimizing 

---

# How hard it can be?

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

# Enter Modularization

---

# Tuist

---

# Bazel & Buck

---

# Resources packaging

---

# Thank you!

- Dnio by Alvaro Reyes / Unsplash
