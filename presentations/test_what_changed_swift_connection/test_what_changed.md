---
marp: true
header: 'Michael Gerasymenko ![height:40](images/logo_small.png)'
footer: 'Swift Connection 2025'
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

# Streamlining iOS Development with Selective Testing

#### Michael Gerasymenko

Comments
- Time is limited
- Introduction can be shorter (could be cut for time)
- Mention swift testing / XCTest compatibility
- 10 min session, 5 min Q/A

<!-- ![width:250](images/logo_dh_logistics.png) -->

<br>

Swift Connection 2025

<!-- ![bg right:42%](images/background_anim.gif) -->



<!-- _paginate: false -->

---

# Who I am

Hey, I'm Michael. I am originally from Ukraine 🇺🇦.

I started as an iOS engineer in 2009 at Readdle. Worked at Wire, Cara Care and Feeld.

Twitter: [@gk0io](https://twitter.com/gk0io)
Github: [mikeger](https://github.com/mikeger)
Email: mike@gera.cx
Web: https://gera.cx

![bg right:42%](images/mike-hat.jpg)

---

# What is happening?

My hometown local charity fund:

https://monstrov.org

![bg left:33%](images/Ukraine.jpg)

---

# Where I work

I am a Staff iOS engineer at Delivery Hero Logistics:

- Available in 70-something countries
- Serving over a million delivery drivers monthly

<!-- We are constantly hiring engineers. Reach out if you are interested. Or apply at https://careers.deliveryhero.com -->

---

![bg 110%](images/brands.png)

<!-- _header: '' -->
<!-- _footer: '' -->
<!-- _paginate: false -->

---

# Let's imagine you have a mobile application

There are some core jobs it is doing:

- Login and registration
- Preferences
- Home Interface
- Details Interface
- ...

---

# Growth

As your company is growing 🌱, so is your app. Over time, there would be multiple teams working on one application. Letting them **separate responsibilities** and allowing them to **own** their part of the application is crucial.

Each team can own a set of modules and some parts of the main application's code.

![bg right:33%](images/flower.jpg)

---

# Modular architecture

Modular architecture is a software design approach that prioritizes breaking down a program's functionality into **self-contained modules**. 

Each module encompasses all the required components to execute a specific aspect of the desired functionality.

 ![bg left:33%](images/nodes.webp)


---
<!--
# External dependencies

Your application probably already has some external dependencies, which are also modules:

- Crash reporting
- Analytics
- ...

---

# Some internal functionality can be separated as a module, too

For example:

- Dependency Injection
- Networking and Authentication
- Localization
- CommonUI, aka Design System

You can treat them as internally developed libraries.
-->

# Swift Package Manager or Projects/Targets?

SPM and Xcode support local packages, which allows for lightweight modularization:

```
Packages/
├── Networking/
│   ├── Package.swift
│   ├── Sources
│   └── Tests
├── Login/
...
```
<!-- _header: 'Mike Gerasymenko' -->

![bg height:300 right:33%](images/swift-package-manager.png)

---

# In Xcode

- First-class citizen treatment: `Designed by Apple in California`
- Xcode can handle many packages well
- Dependencies between packages are supported
- External dependencies are also supported

![bg left:33% height:300](images/xcode-spm.png)
<!-- _header: '' -->

---

# Wait, there's more

- Adding individual files to SPM packages does not cause project file to change: you can forget about `project.pbxproj` conflicts
- You can open individual packages in Xcode to speed up the development
- ... and you can do selective testing 🚀

![bg right:33%](images/dev_center1.jpg)

---

# Congratulations, now you have a modular application

![bg left:33%](images/legos.jpg)

---

> “Insanity is doing the same thing over and over and expecting different results.”

Albert Einstein, probably

---

# Modules

Imagine we have the following dependencies structure

![bg right:60% 90%](images/structure.png)
<!-- _header: 'Mike Gerasymenko' -->

---

![center width:230](images/bored.png)

# Running all those tests is taking so much time!

---

# Change

![center width:220](images/thinking.png)

If the _📦Login_ module is changed, it would only affect the _📦LoginUI_ and the _📱MainApp_.

![bg right:60% 90%](images/structure-changed.png)
<!-- _header: 'Mike Gerasymenko' -->
---


![center width:220](images/thinking.png)

# Does it make sense to test all the modules, if we know only the _📦Login_ module is changed?


<!-- 
---

![bg](images/nope0.gif) ![bg](images/nope1.gif)
![bg](images/nope2.gif) ![bg](images/nope3.gif)
-->
<!-- _header: '' -->
<!-- _footer: '' -->
<!-- _paginate: false -->

--- 

![left:33% width:200](images/idea.png)

# We can only run 50% of the tests and get the same results

![bg right:60% 90%](images/structure-changed-disabled.png)



<!-- _header: 'Mike Gerasymenko' -->
---

# But how can we know?

### 1. Detecting what is changed

Well, Git allows us to find what files were touched in the changeset. 

```bash
Root
├── Dependencies
│   └── Login
│       ├── ❗️LoginAssembly.swift
│       └── ...
├── MyProject.xcodeproj
└── Sources
```

---

### 2. Build the dependency graph

Going from the project to its dependencies, to its dependencies, to dependencies of the dependencies, ...

This can be achieved with _XcodeProj_ package from Tuist.

Dependencies between packages can be parsed with `swift package dump-package`.


<!--
![Alt text](../../public/images/wwdc22/dev_center1.jpg)
---

![](images/finally.gif)
-->
---

### 2.5. Save the list of files for each dependency

This is important so we'll know which files affect which targets.

---

## 3. Traverse the graph

Go from every changed dependency all the way up, and save a set of dependencies you've touched.

![bg right:60% 90%](images/structure.png)
<!-- _header: 'Mike Gerasymenko' -->
---

## 4. Disable tests that can be skipped in the scheme/test plan

This is the most challenging part. We are dealing with obscure Xcode formats. But if we get that far, we will not be scared by that.

---

# Overview

![](images/test-sequence.png)

---

# Sounds like fun, Mike

But I am not going to implement it now.

---

# Luckily, we implemented it already.

<!-- 
![bg](images/wow0.gif)
![bg](images/wow1.gif)
![bg](images/wow2.gif)
![bg](images/wow3.gif) -->

<!-- _header: '' -->
<!-- _footer: '' -->
<!-- _paginate: false -->

---

<style>
img[alt~="center"] {
  display: block;
  margin: 0 auto;
}
</style>

<!-- ![width:800 center](images/github.png) -->
![](images/repo-preview.png)

[github.com/mikeger/XcodeSelectiveTesting](https://github.com/mikeger/XcodeSelectiveTesting)


---

# Benefits

We observed 40-50% average CI time reduction when using XcodeSelectiveTesting

![](images/test-changed-stats-build.png)

---

![](images/test-changed-stats.png)

---

# Why testing fast and precise is important?

![bg right width:480](images/compiling.png)

- Faster CI run means consuming less natural resources
- Local test runs are saving developer hours
<!-- _header: '' -->

---

# Pitfails (TODO)

- Coverage reports
- Flaky tests

---

# Be an open-source maintainer!

---

# Honorable mentions

- Tuist

---

TODO: 

Also, can be cut for time

![](images/scale1.png)

---


![](images/scale2.png)

---


![](images/scale3.png)

---


![](images/scale4.png)

---


![](images/scale5.png)

---

# What's next?

--- 

# Questions

Slides: []()
