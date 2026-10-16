---
marp: true
paginate: true
size: 16:9
header: ''
footer: ''
html: true
---

<!--
Think Local: Magic at your fingertips · NextApp DevCon Swift · 45 minutes
Slide plan:
  1   Cover
  2-4 Intro: who I am, ElevenLabs
  5-13 Historical inspiration (same arc as 5-min deck)
  14  Chapter IV: Under the hood (ML demystified)
  15-21 ML fundamentals (intuitive, non-mathy)
  22  Chapter V: iOS
  23-32 iOS platform deep dive (filled from subagent findings)
  33  Chapter VI: The frontier
  34-36 Security close
  37  Blank page
  38  Thank you
-->


<style>

section {
  background: #FFFFFF;
  color: #111111;
  font-family: "Roboto", -apple-system, "Helvetica Neue", Arial, sans-serif;
  font-size: 28px;
  line-height: 1.4;
  padding: 60px 60px 100px 60px;
  position: relative;
}

h1 {
  font-size: 66px;
  line-height: 1.05;
  font-weight: 800;
  letter-spacing: -1px;
  margin: 0 0 24px 0;
  color: #111111;
}

h2 {
  font-size: 34px;
  line-height: 1.2;
  font-weight: 700;
  margin: 0 0 16px 0;
  color: #111111;
}

h3 {
  font-size: 24px;
  line-height: 1.3;
  font-weight: 700;
  margin: 0 0 8px 0;
  color: #111111;
  letter-spacing: 0.5px;
  text-transform: uppercase;
}

p {
  margin: 14px 0 0 0;
  color: #333333;
  max-width: 30ch;
}

strong { font-weight: 700; color: #000000; }
em { font-style: italic; color: #555555; }

code {
  font-family: "SF Mono", "Menlo", monospace;
  font-size: 0.85em;
  background: #F2F2F2;
  padding: 2px 8px;
  border-radius: 4px;
  color: #111;
}

pre {
  background: #F2F2F2;
  padding: 20px;
  border-radius: 8px;
  font-size: 20px;
  line-height: 1.4;
  overflow-x: auto;
}

pre code {
  background: transparent;
  padding: 0;
}

section::before {
  content: "";
  position: absolute;
  left: 60px;
  bottom: 34px;
  font-weight: 800;
  font-size: 20px;
  letter-spacing: -0.5px;
  color: #111111;
  z-index: 10;
}

section.cover::before,
section.close::before {
  content: "IIElevenLabs";
}

header, footer {
  color: #9A9A9A;
  font-size: 12px;
  font-weight: 700;
  letter-spacing: 1.5px;
  text-align: center;
  width: 100%;
  bottom: 40px;
}

section::after {
  color: #9A9A9A;
  font-size: 14px;
  font-weight: 500;
  right: 60px;
  bottom: 34px;
}

.label {
  position: absolute;
  top: 40px;
  left: 60px;
  font-size: 13px;
  font-weight: 700;
  letter-spacing: 1.8px;
  color: #9A9A9A;
  text-transform: uppercase;
}

section.cover {
  padding: 60px 60px;
  background-image: url('assets/waves/image7.jpg');
  background-repeat: no-repeat;
  background-position: center 55%;
  background-size: 110% auto;
}

section.cover h1 {
  font-size: 130px;
  line-height: 0.95;
  letter-spacing: -3px;
  margin-top: 0;
  max-width: 12ch;
  position: relative;
  z-index: 2;
}

section.cover .subtitle {
  position: absolute;
  left: 60px;
  bottom: 90px;
  font-size: 18px;
  color: #555555;
  font-weight: 500;
  line-height: 1.5;
  max-width: none;
  z-index: 2;
}

section.cover::before {
  color: #111111;
  font-size: 24px;
  z-index: 3;
}

section.story { padding: 60px 60px 100px 60px; }

section.story .kicker {
  position: absolute;
  top: 40px;
  left: 60px;
  font-size: 13px;
  font-weight: 800;
  letter-spacing: 2px;
  color: #9A9A9A;
  text-transform: uppercase;
}

section.story h1 { margin-top: 60px; font-size: 58px; max-width: 15ch; }

section.story .body {
  margin-top: 20px;
  font-size: 22px;
  line-height: 1.5;
  color: #333333;
  max-width: 42ch;
}

section.story .art {
  position: absolute;
  right: 0;
  top: 0;
  width: 42%;
  height: 100%;
  object-fit: cover;
  object-position: center;
}

section.big { padding: 80px 60px 120px 60px; }

section.big h1 {
  font-size: 96px;
  line-height: 1.05;
  letter-spacing: -2px;
  margin-top: 25vh;
  max-width: 100%;
}

section.big .sub {
  font-size: 22px;
  color: #666;
  margin-top: 40px;
  font-weight: 500;
  letter-spacing: 3px;
  text-transform: uppercase;
}

section.now {
  background-image: url('assets/waves/image3.jpg');
  background-repeat: no-repeat;
  background-position: center bottom;
  background-size: 100% 45%;
}

section.now h1 { font-size: 62px; max-width: 14ch; margin-top: 40px; position: relative; z-index: 2; }
section.now .body { margin-top: 24px; font-size: 22px; line-height: 1.5; max-width: 40ch; position: relative; z-index: 2; }

section.chapter {
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 60px 60px 100px 60px;
}

section.chapter .num {
  font-size: 16px;
  font-weight: 800;
  letter-spacing: 3px;
  text-transform: uppercase;
  color: #9A9A9A;
  margin: 0 0 12px 0;
}

section.chapter h1 {
  font-size: 140px;
  line-height: 1;
  letter-spacing: -3px;
  margin: 0;
  color: #111111;
}

section.subchapter {
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 60px 60px 100px 60px;
}

section.subchapter .num {
  font-size: 14px;
  font-weight: 700;
  letter-spacing: 2.5px;
  text-transform: uppercase;
  color: #9A9A9A;
  margin: 0 0 10px 0;
}

section.subchapter h1 {
  font-size: 80px;
  line-height: 1;
  letter-spacing: -2px;
  margin: 0;
  color: #111111;
}

section.blank { background: #FFFFFF; }
section.blank::before, section.blank::after { content: ""; }

section.blank .caption {
  position: absolute;
  left: 0;
  right: 0;
  bottom: 40px;
  text-align: center;
  color: #B8B8B8;
  font-size: 13px;
  font-weight: 500;
  letter-spacing: 1.5px;
}

section.close h1 {
  font-size: 88px;
  line-height: 1.02;
  letter-spacing: -2px;
  margin-top: 30vh;
  max-width: 16ch;
}

section.close .cta { margin-top: 30px; font-size: 22px; color: #333; max-width: none; }
section.close .link { margin-top: 8px; font-size: 20px; font-weight: 700; color: #111; }

section.close {
  background-image: url('assets/waves/image4.jpg');
  background-repeat: no-repeat;
  background-position: center top;
  background-size: 100% 45%;
  padding-top: 34vh;
}

section.close h2 {
  font-size: 64px;
  line-height: 1.05;
  letter-spacing: -1.5px;
  color: #111;
  margin: 0 0 16px 0;
}

section.close > * { position: relative; z-index: 2; }

section.cover header, section.cover footer { display: none !important; }
section.blank header, section.blank footer { display: none !important; }

.footnotes {
  font-size: 12px;
  color: #999;
  margin-top: 40px;
}

section.close .footnotes {
  position: absolute;
  left: 220px;
  right: 220px;
  bottom: 34px;
  margin: 0;
  text-align: center;
  font-size: 11px;
  line-height: 1.4;
}

section.demo {
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 60px 60px 100px 60px;
  background: #050505;
  color: #FFFFFF;
}

section.demo::before, section.demo::after { content: ""; }
section.demo header, section.demo footer { display: none !important; }

section.demo h1 {
  font-size: 180px;
  line-height: 0.95;
  letter-spacing: -4px;
  margin: 0 0 32px 0;
  color: #FFFFFF;
}

section.demo .cue {
  font-size: 22px;
  color: #AAA;
  letter-spacing: 2px;
  text-transform: uppercase;
  font-weight: 700;
  margin-top: 24px;
}

section.demo .hints {
  position: absolute;
  bottom: 60px;
  right: 60px;
  text-align: right;
  font-size: 16px;
  color: #666;
  letter-spacing: 1px;
  line-height: 1.6;
}

section.demo .credit {
  margin-top: 24px;
  font-size: 16px;
  color: #777;
  letter-spacing: 1px;
  font-weight: 500;
  line-height: 1.5;
}

section.demo .credit strong {
  color: #BBB;
  font-weight: 700;
}

section.anim {
  padding: 0;
  background: #FFFFFF;
  overflow: hidden;
}

section.anim iframe {
  width: 100%;
  height: 100%;
  border: 0;
  display: block;
}

section.anim::before, section.anim::after { content: ""; }
section.anim header, section.anim footer { display: none !important; }

.two-col {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 40px;
  margin-top: 30px;
}

.two-col > div h3 { color: #111; }
.two-col p { font-size: 20px; max-width: none; margin-top: 8px; }

/* ===== Pre-start notice (headphones + channel) ===== */
section.notice {
  background: #050505;
  color: #FFFFFF;
  padding: 0;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
}
section.notice::before, section.notice::after { content: ""; }
section.notice header, section.notice footer { display: none !important; }
section.notice h1 {
  font-size: 150px;
  line-height: 1;
  letter-spacing: -3px;
  margin: 0 0 40px 0;
  color: #FFFFFF;
}
section.notice h2 {
  font-size: 72px;
  font-weight: 700;
  letter-spacing: -1px;
  margin: 0 0 60px 0;
  color: #FFD12A;
}
section.notice .ch-badge {
  display: inline-block;
  padding: 12px 28px;
  background: #FFD12A;
  color: #050505;
  font-size: 44px;
  font-weight: 800;
  letter-spacing: -1px;
  border-radius: 12px;
  margin-top: 16px;
}
section.notice p {
  font-size: 20px;
  color: #999;
  margin-top: 40px;
  letter-spacing: 1px;
  font-weight: 500;
  text-align: center;
  max-width: none;
}

/* ===== Elevator doors with parallax (3 vertical sections per side) ===== */
.elevator-doors {
  position: absolute;
  inset: 0;
  z-index: 100;
  pointer-events: none;
  display: flex;
  overflow: hidden;
}
.elevator-doors .door {
  flex: 1;
  display: flex;
  position: relative;
}
.elevator-doors .door.left { flex-direction: row; }
.elevator-doors .door.right { flex-direction: row; }

.elevator-doors .panel {
  flex: 1;
  background: linear-gradient(135deg, #8a8a8a 0%, #5a5a5a 50%, #747474 100%);
  box-shadow: inset 0 0 60px rgba(0, 0, 0, 0.4);
  border-right: 2px solid #3a3a3a;
  position: relative;
  animation-fill-mode: forwards;
  animation-delay: 1.3s;
  animation-timing-function: cubic-bezier(0.65, 0, 0.35, 1);
}
.elevator-doors .panel::before {
  content: "";
  position: absolute;
  inset: 0;
  background: linear-gradient(to bottom, rgba(255,255,255,0.07), transparent 15%, transparent 85%, rgba(0,0,0,0.15));
}

/* Telescoping: all panels start together, same duration, but DIFFERENT distances.
   Inner panel travels furthest (3× its width), middle 2×, outer 1×.
   Inner appears to move first because it is the fastest. All finish stacked in the pocket. */
.elevator-doors .door .panel { animation-duration: 2.0s; }

.elevator-doors .door.left  .inner  { animation-name: elev-inner-left;  border-right: 1px solid #2a2a2a; }
.elevator-doors .door.left  .middle { animation-name: elev-middle-left; }
.elevator-doors .door.left  .outer  { animation-name: elev-outer-left; }

.elevator-doors .door.right .inner  { animation-name: elev-inner-right;  border-left: 1px solid #2a2a2a; border-right: 2px solid #3a3a3a; }
.elevator-doors .door.right .middle { animation-name: elev-middle-right; }
.elevator-doors .door.right .outer  { animation-name: elev-outer-right;  border-right: none; }

@keyframes elev-inner-left   { to { transform: translateX(-300%); } }
@keyframes elev-middle-left  { to { transform: translateX(-200%); } }
@keyframes elev-outer-left   { to { transform: translateX(-100%); } }
@keyframes elev-inner-right  { to { transform: translateX(300%); } }
@keyframes elev-middle-right { to { transform: translateX(200%); } }
@keyframes elev-outer-right  { to { transform: translateX(100%); } }

</style>

<script>
// Marp bridge: when a slide becomes active (bespoke-marp-active), postMessage
// to every iframe inside it so iframe animations can reset and replay.
// Needed because file:// iframes are cross-origin to the parent, so iframes
// can't observe parent slide classes directly.
(function(){
  if (window.__marpSlideBridge) return;
  window.__marpSlideBridge = true;
  function wire() {
    var slides = document.querySelectorAll('svg.bespoke-marp-slide');
    if (!slides.length) { setTimeout(wire, 150); return; }
    slides.forEach(function(slide){
      if (slide.__wired) return;
      slide.__wired = true;
      function broadcast() {
        slide.querySelectorAll('iframe').forEach(function(f){
          try { f.contentWindow.postMessage('bespoke:active', '*'); } catch(e) {}
        });
      }
      new MutationObserver(function(){
        if (slide.classList.contains('bespoke-marp-active')) broadcast();
      }).observe(slide, { attributes: true, attributeFilter: ['class'] });
      if (slide.classList.contains('bespoke-marp-active')) broadcast();
    });
  }
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', wire);
  } else {
    wire();
  }
})();
</script>

<!-- _class: notice -->
<!-- _paginate: false -->

# Wear headphones

## Audio channel

<div class="ch-badge">8</div>

<p>audio runs through the venue system · talk starts shortly</p>

<!--
Pre-start slide. Leave on screen while the audience arrives and finds seats. Only advance when ready to begin.
-->

---

<!-- _class: cover -->
<!-- _paginate: false -->

<div class="elevator-doors">
  <div class="door left">
    <div class="panel outer"></div>
    <div class="panel middle"></div>
    <div class="panel inner"></div>
  </div>
  <div class="door right">
    <div class="panel inner"></div>
    <div class="panel middle"></div>
    <div class="panel outer"></div>
  </div>
</div>

# Think Local

<div class="subtitle">
Magic at your fingertips<br>
Michael Gerasymenko · ElevenLabs<br>
next.app devCon Swift · 2026
</div>

<!--
[Elevator doors close the screen for ~1.3s, then slide open over 2s to reveal the title. Matches the industrial elevator the projection sits above.]

Hey everyone. My name is Michael Gerasymenko. Thanks for having me.

Next forty-five minutes: on-device AI. What it is, what runs today, what breaks, where it goes.

I'll start with some history. Then we go under the hood: what a model actually is, how the Apple stack handles it. Then the walls I hit shipping on iOS. We close on the frontier.

Hold questions for the end. Or catch me in the hallway. Or on LinkedIn.
-->

---

# Who am I

- Building mobile apps since **2009**
- Readdle, Wire, CaraCare, Feeld, now ElevenLabs
- Author of **mikeger/XcodeSelectiveTesting**
- Originally from **Ukraine**, living and working in **Berlin**
- Blog: [gera.cx](https://gera.cx)

<!--
Building iOS since 2009, when the SDK first dropped. Readdle, Wire, CaraCare, Feeld, now ElevenLabs. Also maintain an open-source tool, XcodeSelectiveTesting, for test optimisation.

Originally from Ukraine, living in Berlin for a few years now. Which, by the way, is where this conference is, so hello neighbours.

Point being: when I talk about mobile shifts later, I watched them happen.
-->

---

<!-- _class: company -->

<div class="label">ELEVENLABS / CONTEXT</div>

# IIElevenLabs

- The Voice AI
- Started here seven months ago, company went 400 → 800 people
- I'm on the Mobile team, working on **ElevenReader**
- We're hiring, also remote
- *Opinions are my own*

<!--
I work at ElevenLabs. The voice AI company. Our CEO Mati keeps saying voice will be the interface for AI, and the numbers back it up.

Joined seven months ago. We doubled headcount in that time. Mobile team is hiring, remote is fine.

I work on ElevenReader. If you want to see what the research team ships, that's the app. Catch me after and I can set you up with a free annual subscription. Small catch: tell me about any bugs.

Opinions here are my own.
-->

---

<!-- _class: chapter -->

<div class="num">Part One</div>

# Under the Hood

<!--
Before we talk about where this is going, let me show you how it actually works today. What is a model that we're running? Why does it need compiling? Why is Apple's stack different from everyone else's?

Next ten minutes, I'll demystify it. I'm not teaching you ML. Just enough mental model that when someone throws words at you (quantization, NPU, fp16), you have intuition for what they mean.
-->

---

# A model is a function

```swift
func model(input: [Float]) -> [Float] {
    // billions of multiplications later
    return output
}
```

<!--
Start here. A machine learning model is a function. Takes an array of numbers in. Returns an array of numbers out.

That is it. No magic.

Text-to-speech: input encodes the text, output encodes a waveform. Image classifier: input is pixels, output is "this is seventy-three percent a cat."

The entire intelligence of the model lives in the numbers it uses to transform input into output. Those numbers are called weights.
-->

---

<div class="label">PRIMER</div>

# Vector + matrix

<div class="primer">
<style>
.primer { display: flex; align-items: flex-start; justify-content: center; gap: 90px; margin-top: 50px; }
.primer .box { display: flex; flex-direction: column; align-items: center; }
.primer .cap { font-size: 15px; font-weight: 700; letter-spacing: 2px; color: #999; text-transform: uppercase; margin-bottom: 18px; }
.primer .vector-grid { display: grid; grid-template-columns: 70px; grid-template-rows: repeat(4, 70px); gap: 6px; }
.primer .matrix-wrap { display: grid; grid-template-columns: 36px 1fr; grid-template-rows: 36px 1fr; gap: 10px; }
.primer .matrix-grid { display: grid; grid-template-columns: repeat(4, 70px); grid-template-rows: repeat(3, 70px); gap: 6px; }
.primer .cell { display: flex; align-items: center; justify-content: center; border: 1.5px solid #BBB; border-radius: 6px; color: #333; font-size: 22px; font-weight: 500; background: #FFF; }
.primer .row-labels { display: grid; grid-template-rows: repeat(3, 70px); gap: 6px; align-items: center; font-size: 12px; font-weight: 700; color: #999; text-align: right; padding-right: 4px; letter-spacing: 1px; }
.primer .col-labels { display: grid; grid-template-columns: repeat(4, 70px); gap: 6px; justify-items: center; font-size: 12px; font-weight: 700; color: #999; letter-spacing: 1px; }
.primer .corner { }
.primer .shape { font-size: 13px; color: #AAA; margin-top: 14px; font-weight: 500; letter-spacing: 1px; }
</style>

<div class="box">
  <div class="cap">Vector</div>
  <div class="vector-grid">
    <div class="cell">x₁</div>
    <div class="cell">x₂</div>
    <div class="cell">x₃</div>
    <div class="cell">x₄</div>
  </div>
  <div class="shape">ordered list · 4 numbers</div>
</div>

<div class="box">
  <div class="cap">Matrix</div>
  <div class="matrix-wrap">
    <div class="corner"></div>
    <div class="col-labels"><span>col 1</span><span>col 2</span><span>col 3</span><span>col 4</span></div>
    <div class="row-labels"><span>row 1</span><span>row 2</span><span>row 3</span></div>
    <div class="matrix-grid">
      <div class="cell">w</div><div class="cell">w</div><div class="cell">w</div><div class="cell">w</div>
      <div class="cell">w</div><div class="cell">w</div><div class="cell">w</div><div class="cell">w</div>
      <div class="cell">w</div><div class="cell">w</div><div class="cell">w</div><div class="cell">w</div>
    </div>
  </div>
  <div class="shape">grid · 3 rows × 4 columns</div>
</div>
</div>

<!--
Twenty seconds of maths, for anyone who last saw this in school.

A vector is an ordered list of numbers. A matrix is a grid of numbers, laid out in rows and columns. The weights of a model live in matrices like this.

The operation inside every ML model: multiply a vector by a matrix, get a vector back. Then do it a few billion more times.
-->

---

<!-- _class: anim -->

<iframe src="assets/anim/matmul.html"></iframe>

<!--
Here is what one of those multiplications looks like. One row of the weight matrix, dot-producted with the input vector, lights up one cell of the output. Repeat for each row. That is one layer.

A modern model does billions of these every second.
-->

---

# Weights are the model

- Billions of numbers in a specific layout
- Stored as **floats** (fp32, fp16, bf16) or **ints** (int8, int4)
- A file couple of hundreds of MB to several GB
- This is what you ship to the device

<!--
When we say "ship the model to the device," we mean ship a file with those billions of numbers in it.

They can be stored at different precisions. Thirty-two-bit floats are accurate and huge. Half-precision cuts the size in half with usually imperceptible quality loss. Quantization squeezes further, to eight-bit integers or smaller. Much smaller file, much faster, usually some quality cost.

A model that is two gigabytes in fp32 might be five hundred megabytes in fp16, one hundred and fifty quantized. Often the difference between "this fits in your app" and "this doesn't."
-->

---

<!-- _class: anim -->

<iframe src="assets/anim/weights-vs-activations.html"></iframe>

<!--
Mental model to keep. The grey grids are weights. They load once at session start and stay in memory. The red pulses are activations, the data flowing through the network on each inference. New data in, new data out, same weights the whole time.

Loading weights is a one-time cost. Running activations through them is what happens every time a user asks something.
-->

---

# Hardware does the math

<div class="two-col">
<div>
<h3>CPU</h3>
<p>General-purpose. SIMD (NEON on every ARM, AMX on Apple) for parallel math.</p>
</div>
<div>
<h3>GPU</h3>
<p>Thousands of small cores. Metal on Apple, Vulkan on Android. Great for big tensors.</p>
</div>
</div>

<div class="two-col">
<div>
<h3>NPU</h3>
<p>Fixed-function silicon. Apple ANE, Qualcomm Hexagon, Samsung ENN, Google Tensor. Fastest and most efficient.</p>
</div>
<div>
<h3>The tradeoff</h3>
<p>Each tier is faster but more constrained in what it can run.</p>
</div>
</div>

<!--
Three places math can happen on a modern phone. CPU, GPU, NPU.

CPU has SIMD instructions. NEON on every ARM chip. AMX on recent Apple ones. Many multiplications per cycle. Flexible, general.

GPU has thousands of small cores that multiply in parallel. Great for big tensor operations. Metal on Apple, Vulkan on Android.

NPU is purpose-built silicon for ML ops. Apple calls theirs the Neural Engine. Qualcomm has the Hexagon DSP. Samsung has ENN. Google has their Tensor Edge TPU. Each one has its own instruction set.

Fastest and most energy-efficient. Also the most constrained. If your model has a weird layer the NPU cannot run, the runtime falls back to GPU or CPU.
-->

---

<!-- _class: anim -->

<iframe src="assets/anim/hardware-compare.html"></iframe>

<!--
Same matrix operation on each of the three. CPU takes the longest, uses the most power. GPU is faster, uses less. NPU is fastest, uses the least. The tradeoff sits on the NPU side. It only accepts certain op shapes. An unsupported layer and it bounces back to GPU or CPU.
-->

---

# Compilation makes the model fit the hardware

- Model file arrives in a **portable format** (ONNX, Core ML Package)
- First time you load it: runtime **compiles** it for *this specific chip*
- Takes seconds to minutes
- Cached per device, per OS version

<!--
This trips people up. The model file you ship is portable, same bytes on every iPhone. But the operations in that model have to become actual GPU shaders or ANE instructions on the chip you are running on. That translation is called compilation.

It happens the first time the model loads on a device. Recent iPhone, a few seconds. Older iPhone, thirty seconds. The compiled result is cached, so subsequent launches skip it.

This is why on-device models often have a visible "preparing" moment the first time. We will come back to this.
-->

---

<!-- _class: anim -->

<iframe src="assets/anim/fragmentation.html"></iframe>

<!--
One source model, four target formats, four pieces of silicon. Each conversion is non-trivial. Each target has its own op coverage, its own quantization support, its own debugging tools. This is what "fragmentation" actually looks like.
-->


---

<!-- _class: demo -->

# Live.

<div class="cue">On-device · airplane mode · my phone</div>

<div class="credit"><strong>Model:</strong> ElevenLabs Lite V2 · <strong>Integration:</strong> Michael Gerasymenko</div>


<!--
[Walk to the device. Pause.]

Everything we just talked about, running on this phone. Airplane mode is on. No network. No cloud. Watch.

[Trigger synthesis. Thirty to sixty seconds. Let it speak for itself.]

That is what we are here to talk about.

-->

---

<!-- _class: chapter -->

<div class="num">Part Two</div>

# Lessons

<!--

-->

---

<div class="label">LESSON 1 · DISPATCH</div>

# Dispatch is a planner decision, not a contract

- You request a compute unit
- The runtime decides placement
- You might ask for the NPU and get the CPU
- **Measure actual placement with a profiler. There is no code API for it.**

<!--


The run destination is just a hint.

On both platforms: we asked for the NPU, the planner picked the CPU. On iOS the mature int8 kernels won. On Android the NPU delegate silently fell back for ops it couldn't lower.

Set computeUnits to cpuAndNeuralEngine on iOS. You are offering the system a budget. It runs its own cost model and picks what it thinks is best. On iPhone 15, we repeatedly saw Core ML's CPU int8 path beat the Core AI GPU path for our workload. Eight years of hand-tuned NEON and AMX kernels is a hard baseline to clear.

Android does the same thing. You hand a graph to the NPU delegate, it silently falls back to CPU for ops the NPU does not support.

"Did the NPU run my model" is a question you answer with Instruments or perfetto, not with code. There is no why-not-the-NPU tool today. Apple folks, this is my ask.
-->

---

<div class="label">LESSON 2 · SHAPES</div>

# NPUs demand static shapes

- NPUs plan memory and shaders at compile time
- Dynamic input shapes trigger a recompile. Every. Call.
- Seconds to tens of seconds on older silicon. On Qualcomm QNN, the compiler refuses outright.
- **Fix: pad inputs to a small set of fixed bucket sizes.**

<!--
Lesson three. NPUs need static shapes.

Dynamic shapes feel innocent in Python. On device they are brutal. Every new input shape triggers a recompile. On the Apple A16 chip that is five to twenty seconds. On Qualcomm QNN the compiler refuses dynamic shapes outright.

Second cost. The Apple GPU has a hard ceiling of thirty-two Metal residency sets. One per unique shape. Hit thirty-three, start evicting. On Android, each pad bucket ships as a separate compiled artefact in the APK.

Fix is the same on both platforms. Pad inputs to a small set of fixed bucket sizes. One compiled artefact per bucket. Waste some compute on padding. Still the right call.
-->

---

<!-- _class: anim -->

<iframe src="assets/anim/static-vs-dynamic.html"></iframe>

<!--
Both rows run ten inferences. Top: static shape, model compiles once, every inference is cheap. Bottom: dynamic shape, every new input triggers a recompile. Static finishes while dynamic is still working.
-->

---

<div class="label">LESSON 3 · FIRST LAUNCH</div>

# Cold compile is a UX event

- Portable model file → native code happens on first load
- Minutes on older silicon. Tens of seconds on new.
- Cached per device, per OS version
- **Pre-warm, or ship pre-compiled artefacts**

<!--
Lesson four. First-launch compile is a UX event.

The first time a model loads on a device, the runtime compiles it to native code for that chip. Simple classifier, fast. Serious multi-stage pipeline, less so.

On iPhone 17 Pro we saw about sixty seconds for one of our pipelines. On iPhone 15, several minutes. Older devices, worse.

Cache saves subsequent launches. First time, you need UI. "Preparing." Make it a feature.

Long-term fix. Compile ahead of time, during your app build, on CI. Apple ships `xcrun coreai-build compile` for this. On Android, QNN forces the AOT path anyway. We are moving towards that on iOS.
-->

---

<div class="label">LESSON 4 · MEMORY</div>

# Peak memory kills more models than latency

- Hybrid pipeline + fallback peaks **~1.4 GB** on a 6 GB device
- One variant was retired after OOMing at a **3 GB** during setup
- On low-RAM devices, split sub-models across CPU and NPU
- Memory warnings fire. Don't unload mid-session

<!--
Lesson five. Memory kills more models than latency does.

iPhone 15 is a six gigabyte device. Our hybrid pipeline plus a fallback peaks at about 1.4 gigabytes during setup. One variant OOMed at a three gigabyte watermark during specialisation. We retired it.

On devices with four and a half gigs of RAM or less, we route some pieces to CPU only to bound the NPU residency footprint. Worse latency, lower memory. Trade-off made.

We hook memory warnings. We do not unload mid-session. Reload is worse than the pressure. Pick your poison.
-->

---

<div class="label">LESSON 5 · PERF HYGIENE</div>

# Three things that silently cost you 30%

- **Debug builds.** Release is ~1.3× faster. Always benchmark Release.
- **File I/O in the hot path.** Even logging kills throughput. 30% in our case.
- **Diagnostic loops left behind.** A `minV/maxV/meanV` sanity check cost us 2× for a week.

<!--
Lesson six. Three universal perf traps.

Always benchmark Release. Debug is one-point-three times slower for inference. You will chase phantom regressions in Debug.

Never do file I/O in the inference hot path. Diagnostic file writes, thirty-nine per synthesis, cost us thirty percent throughput. Removed them. Got it back.

Discipline one. If you add a debug min, max, mean loop over the output tensor to sanity-check, remember to remove it. Mine cost two times for a week.

These are embarrassing but universal.
-->

---

<div class="label">LESSON 6 · THERMAL</div>

# The phone gets hot
## Sustained inference is a different workload

- Cold-phone benchmarks are the best case, not the common case
- ANE and Hexagon both clock down once skin temperature climbs
- Latency can double a minute into a long session
- Measure warm. Record device temperature next to your numbers.

<!--
Lesson seven. Thermal.

Easy trap. You benchmark at your desk, the phone is cool, numbers look great. User runs it for two minutes in a warm pocket and latency doubles. Both Apple silicon and Qualcomm throttle aggressively once skin temperature crosses roughly forty Celsius. The NPU is often the first to clock down because fixed-function silicon runs hot per square millimetre.

Rule we use. Always profile after at least sixty seconds of sustained load. Record skin temperature next to your numbers. A benchmark without a temperature reading is a marketing claim.
-->

---

<img src="assets/fridge.jpg" width=450>

---

<!-- _class: chapter -->

<div class="num">Part Three</div>

# iOS specifics

<!--
Three things that are iOS-only, worth knowing if you ship on this platform.
-->

---

<div class="label">VOCABULARY · SKIP IF COMFORTABLE</div>

# Terms you'll hear

<div class="two-col">
<div>
<h3>ANE</h3>
<p>Apple Neural Engine. Fixed-function ML silicon.</p>
</div>
<div>
<h3>Core ML</h3>
<p>Apple's ML runtime since iOS 11. Model format: <code>.mlpackage</code>.</p>
</div>
</div>

<div class="two-col">
<div>
<h3>Core AI</h3>
<p>New in iOS 27. Replaces Core ML for LLM-scale workloads. Model format: <code>.aimodel</code>.</p>
</div>
<div>
<h3>MLX</h3>
<p>Apple's PyTorch-like array framework. Research-first, Mac-shipping.</p>
</div>
</div>

<!--
Thirty-second anchor for anyone who has not shipped on this stack. Four terms will come up constantly. Skip ahead mentally if you know them.
-->

---

<div class="label">iOS · THE STACK SHIFT</div>

# Core AI is new in iOS 27

- Core ML since iOS 11 (`.mlpackage`). Mature kernels.
- **Core AI** landed in iOS 27 (`.aimodel`). LLM-scale workloads, better memory control.
- **The Swift API drifted between iOS 27 betas.** Build against the latest Xcode.

<!--
iOS-specific lesson one. The stack is shifting.

Core ML has been around since iOS 11. Mature, understood, fast. The default for most things.

Core AI landed in iOS 27 at WWDC. New runtime, new format, built for LLM-scale models. Palettization, better memory control, closer to where the industry is going. Replaces Core ML for the heavy workloads over time.

If you ship across iOS 17 to 27, you need both. Fence Core AI code with canImport CoreAI and available iOS 27. Expect the Swift API to drift in point releases. NDArray MutableView baseAddress moved to withUnsafeMutablePointer. AsyncValue ndArray became try await. Build against the latest Xcode.
-->

---

<div class="label">iOS · IP PROTECTION</div>

# FairPlay for Core ML

- Apple ships model encryption integrated with the Core ML load path
- Keys delivered through Apple's licensing infrastructure
- Pair with **App Attest** (device + binary attestation) + **Secure Enclave** (key wrapping)
- Together: a serious at-rest + load-time protection stack
- Doesn't close the final gap (see security section). Raises cost.

<!--
iOS-specific lesson two. On IP protection, Apple gives you more than Android does.

FairPlay for Core ML encrypts your model file at rest. Keys come through Apple's licensing infrastructure. Integrated with the Core ML load path, so decryption is transparent to your code.

Combined with App Attest, which attests your binary and device identity to your server, you can refuse to deliver a key to a jailbroken client. Secure Enclave wraps the keys in hardware.

That stack is the most mature on-device IP protection on any mobile platform today. It still has the fundamental gap we talked about in the security section, but it raises the cost of extraction materially.
-->

---

<div class="label">iOS · INTEGRATION</div>

# Swift concurrency around ML

```swift
@MainActor @Observable
final class TTSManager { ... }

nonisolated func synthesize(_ text: String) async throws -> AudioStream
```

- Manager is `@MainActor @Observable` for UI binding
- Inference is `nonisolated async throws`, off the main actor
- Inner engine `@unchecked Sendable` with init-time static config
- *Cancellation is weak. Core ML's `prediction` has no cancellation token.*

<!--
iOS-specific lesson three. Swift concurrency around ML.

The manager is MainActor Observable for UI binding. Inference is nonisolated async throws, so it does not block the main actor.

Internal engine is unchecked Sendable, with configuration that is write-once at init and read-only during inference. Pragmatic.

Cancellation is the weakest part of our setup. MLModel's prediction call does not take a cancellation token. If you want to cancel mid-synthesis, split the pipeline into cancellable chunks. Plan it in from the start.
-->

---

<!-- _class: chapter -->

<div class="num">Part Four</div>

# The Frontier

<!--
Honest tour done. Before we close, I want to show you where this all goes, and why I think it goes anywhere at all. Three short historical stories first. They are the whole reason I think on-device AI matters.
-->

---

<!-- _class: chapter -->

<div class="num">Chapter I</div>

# Time

---

<!-- _class: story -->

<div class="kicker">BEFORE / Chapter I</div>

# Precise time

<img class="art" src="assets/big-ben.jpg" />

<!--
We complain about not having enough time. People in the past had a worse problem. They couldn't tell what time it was.

Medieval European town. The biggest building has a huge clock on it. Bells ring at specific hours. Someone walks door to door to wake people up. Time was infrastructure. You looked up at the tower. If you couldn't see it, you didn't know.

Peasant, merchant, scholar. None of them had a way to privately know the exact time.
-->


---

<!-- _class: story -->

<div class="kicker">AFTER / Chapter I</div>

# Time moved onto your wrist

<img class="art" src="assets/wristwatch.png" />

<!--
John Harrison spent forty years building a chronometer that worked at sea. A century later, wristwatches were cheap for everyone.

If you asked a medieval peasant to imagine the future of time, they would have described a bigger clock tower. Maybe one with lights. They would never have imagined a personal pocket watch.

The centralised source was what they knew.
-->

---

<!-- _class: chapter -->

<div class="num">Chapter II</div>

# Computer Time

---

<!-- _class: story -->

<div class="kicker">BEFORE / Chapter II</div>

# You walked to the computer

<img class="art" src="assets/punch-cards.png" />

<!--
My mother, in the 1970s, wrote her university assignments on punch cards. Walked to the university basement. Handed them to an operator. The task ran overnight. She came back the next day. Sometimes to find a single letter wrong.

Computing lived in a room. You visited it.

Same shape as the town clock.
-->

---

<!-- _class: story -->

<div class="kicker">AFTER / Chapter II</div>

# The computer walked into your pocket

<img class="art" src="assets/iphone-2g.jpg" />

<!--
Then it moved. First onto desks. Then into pockets. I started building for iPhone in 2009.

When Steve Jobs held up that phone in 2007, nobody in that room predicted a billion-dollar photo filter app. Nobody predicted summoning strangers' cars. Nobody predicted replacing SMS with a chat app.

Those products appeared because the technology moved to the person. Social patterns died too. Waiting by the landline for a call you could not miss has evaporated for anyone under twenty-five.
-->

---

<!-- _class: big -->

<div class="label">THE PATTERN</div>

<h1>It happens again. <br> It happens faster.</h1>

<!--
Four hundred years for clocks. Fifty years for factory power. Twenty for computers. Fifteen for mobile.

Every wave is faster. Every wave, we underestimated what people would do with the capability once it was personal and private, instead of centralised.
-->

---

<!-- _class: now -->

<div class="label">RIGHT NOW</div>

# We rent thinking by the token

<div class="body">
Today, if you want to think with AI, you send your data to someone else's building and pay for the round trip.

<strong>This is the last decade you'll do that.</strong>
</div>

<!--
Which brings us to right now. If you want to think with AI, you send your prompt to a data centre in Virginia or Oregon, and you pay for the round trip by the token. Your users' voices. Your customers' medical records. Your own ideas.

Soon, "wait, you had to send your data to a server?" will sound as antique as "wait, you had to be home to receive a phone call?"

The technology will move. Physics, economics, privacy all point the same way. That shift is inevitable. Four pieces to the puzzle.
-->

---

<!-- _class: anim -->

<iframe src="assets/anim/path-to-gpt4.html#1"></iframe>

<!--
Before we close, the shape of the next few years. Four pieces to the puzzle.

Piece one: compute. Doubling about every two years. The dual-NPU iPhone 18 Pro roughly doubles the A19. Snapdragon on the same curve.
-->

---

<!-- _class: anim -->

<iframe src="assets/anim/path-to-gpt4.html#2"></iframe>

<!--
Piece two: memory bandwidth. The harder constraint for LLM inference. Jumped seventy percent on Apple in one generation. Snapdragon close behind.
-->

---

<!-- _class: anim -->

<iframe src="assets/anim/path-to-gpt4.html#3"></iframe>

<!--
Piece three: software. Five model-side techniques compound. Int4 quantization, four times smaller. Mixture of experts, roughly seven times effective capacity. Partial loading from flash, model streams on demand. Distillation, small models trained on big-model outputs. Sparsity, zero out and skip. Stacked together, ten to fifty times effective capacity on the same hardware.
-->

---

<!-- _class: anim -->

<iframe src="assets/anim/path-to-gpt4.html#4"></iframe>

<!--
Stack all of it together. GPT-4 class inference on a flagship phone, in airplane mode, is a 2028 problem. Not a decade away.

Both platforms. Both ecosystems get there within months of each other.
-->

---

# Security is the real blocker

<p style="text-align: center; max-width: 60ch; margin: 0 auto;">The model file is the asset. A trained model represents a big sum of dollars of compute, proprietary data, and years of research. Protecting it on an untrusted device is an unsolved problem.</p>

<!--
Six months ago I thought the hard problem was performance. It is not. Performance is a solvable engineering problem. The hard problem is protecting the model from the device it runs on.

For a company whose moat is its model, this is existential. For an open-source model, it does not matter. The gap between those two situations is where the next few years get decided.

[Pause.]
-->

---

<div class="label">THE THREAT MODEL</div>

# What an attacker can do

- Pull the model file out of app storage, over USB or ADB
- Hook the inference call with Frida or LLDB
- Dump decrypted weights from process memory
- Replay or clone the model on their own hardware
- Encryption at rest does nothing. The model has to decrypt to run.

<!--
If I ship my weights to your device, I have effectively handed them over. The license fiction doesn't help once the bits are inside your sandbox.

A motivated person can pull the model file out of the app sandbox over USB. They can hook into the running process with Frida or LLDB and watch the weights decrypt into RAM. They can dump memory and reconstruct the file.

Encryption at rest buys you nothing, because the model has to decrypt to run. The decrypted copy exists in RAM for the duration of inference. That is the window.
-->

---

<div class="label">THE PROTECTION LANDSCAPE</div>

# Tools that raise the cost

<div class="two-col">
<div>
<h3>RASP</h3>
<p>Runtime App Self-Protection. Anti-debug, anti-hook, integrity checks. Promon, Guardsquare, Jscrambler.</p>
</div>
<div>
<h3>App Attest</h3>
<p>Apple's attestation. Ties your binary and device identity to a server-issued token.</p>
</div>
</div>

<div class="two-col">
<div>
<h3>FairPlay for Core ML</h3>
<p>Apple's model encryption. Keys delivered by Apple servers. Integrated with Core ML load path.</p>
</div>
<div>
<h3>Secure Enclave</h3>
<p>Hardware key store. Kilobytes of memory. Can hold wrapping keys. Cannot hold the model.</p>
</div>
</div>

<!--
A stack of tools raises the cost of extraction.

RASP vendors sell runtime protection. Anti-debug, anti-hook, integrity checks. A determined attacker still gets through. The point is to make it expensive.

Apple's App Attest attests your binary and device identity to your server, so you can refuse to deliver a model key to a jailbroken or modified client.

FairPlay for Core ML encrypts the model file at rest, with keys delivered through Apple's licensing infrastructure. Clean integration with the Core ML load path.

The Secure Enclave is a hardware key store with kilobytes of memory. Big enough for a wrapping key that unwraps your model key. Nowhere near big enough for the model itself.

Stacked together, this is what a serious on-device deployment looks like today.
-->

---

<div class="label">THE GAP</div>

# What is still missing

- No developer-accessible trusted execution environment large enough for a model
- No hardware memory encryption that excludes a root-level reader on a jailbroken device
- No attested execution that binds (model hash, program hash, device identity) to a third-party key release
- This is why high-value proprietary models still live in the cloud.

<!--
Where the stack breaks down is at the last mile. Even with App Attest, FairPlay, Secure Enclave key wrapping, there is a moment during inference when the decrypted weights sit in GPU or NPU memory. A root-level process on a jailbroken device can read that memory.

What would close the gap: an attested trusted execution environment, big enough to hold a model, with hardware memory encryption on the accelerator buffers, and a way to release keys to it only when a known program is running on a known device. None of those exist today in a form developers can use.

This is why ElevenLabs, OpenAI, Anthropic, Google, Meta all keep their best models in the cloud. The compute to run them on-device is here. The protection story around them is still missing.
-->

---

# But open source changes the calculus

- You don't need **your** model on-device
- Hundreds of production-quality open models exist (Llama, Mistral, Whisper, Qwen, Gemma, ...)
- They're safe to ship
- **The product is what you build *around* the model.**

<!--
There is an opening. You do not need your own model on-device to build a great product. Hundreds of production-quality open models exist. Llama, Mistral, Whisper for speech-to-text, Qwen, Gemma. The Chinese labs ship monthly. All safe to deploy, because the weights are already public.

The IP sits in the product you build around the model. The UX. The data layer. The agentic logic. The integration with the rest of the user's device.

That is the design space that opens up when thinking shifts to the edge.
-->

---

<div class="label">WHERE THE WORLD IS HEADING</div>

# Models are becoming commodity

- Swap one frontier model for another. Most apps barely notice
- I moved from Opus to Grok 4.6 fast last week. Didn't feel it
- Model is a technology: Three years ago we used GPT-3.5 directly
- You cannot make a model smarter if the training data isn't
- Honed products eat raw models


<!--
Here is where I think the world is heading.

Models are becoming commodity. Last week I moved my daily coding workflow from Opus to Grok 4.6 fast. The difference was marginal. Three years ago we were all talking to GPT-3.5 directly, through a text box. Soon nobody will. The raw model is becoming infrastructure, not a product.

There is a ceiling on how smart a model can get if the training data does not get smarter. We are approaching that ceiling with internet-scale text. The next decade of value is not in better models, it is in better products built on commodity models.

Concrete example. The app I work on, ElevenReader, uses ElevenLabs TTS. In principle the TTS could be swapped for Kokoro or Piper or whatever ships next month. The product is not the TTS. It is the reading experience. The library. The voice selection. The way it handles long-form content. The UX.

Build products, not model wrappers.
-->

---

<div class="label">WHAT TO TRY MONDAY</div>

# Start somewhere

<div class="two-col">
<div>
<h3>If you have never shipped a model</h3>
<p>Open Foundation Models in iOS 26. One <code>LanguageModelSession</code>, text in, text out. Thirty minutes.</p>
</div>
<div>
<h3>If you want your own weights</h3>
<p>Try MLX Swift with a small open model (SmolLM, Qwen 0.5B). Native Swift, Mac-first.</p>
</div>
</div>

<div class="two-col">
<div>
<h3>If you want to go deep</h3>
<p>Convert a PyTorch model with CoreAI-Torch. Ship an <code>.aimodel</code>. Watch cold-compile with Instruments.</p>
</div>
<div>
<h3>If you want to understand IP</h3>
<p>Read Apple's App Attest docs. Then try to extract a model from your own binary. Humbling.</p>
</div>
</div>

<!--
Four entry points at different depths. Easiest to hardest. Pick the one that matches where you are. The point is to start, not to finish.
-->

---

<!-- _class: blank -->
<!-- _paginate: false -->

<div class="caption">THIS PAGE IS INTENTIONALLY LEFT BLANK</div>

<!--
[Pause.]

The product is a blank page. Your job as iOS engineers is to be among the first to figure out what goes on it.

[Longer pause before advancing.]
-->

---

<!-- _class: close -->

## Thank you

<div class="cta">If this made you think about tomorrow, we're hiring people to figure it out.</div>

<div class="link">elevenlabs.io/careers · gera.cx · come say hi</div>

<div class="footnotes">Some images AI-generated. Thanks to Unsplash users Sophia Stark and Enrico Bet.</div>

<!--
Thank you.

If any of this made you think about tomorrow instead of today, we are hiring iOS people at ElevenLabs. Find me after. Thanks NextApp.
-->
