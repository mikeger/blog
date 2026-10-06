---
marp: true
paginate: true
size: 16:9
header: ''
footer: ''
---

<!--
Think Local · Builders & Brews Berlin · 5 minutes
Slide plan:
  1  Cover (wave hero)
  2  ElevenLabs (headline + body)
  3  Before: sailors got lost
  4  After: everyone's wrist
  5  Before: mother's punch cards
  6  After: father's landline / your iPhone
  7  The pattern
  8  Right now (cloud → device)
  9  Blank page
  10 Close
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

/* Standard content title */
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

/* Fixed brand footer bar */
section::before {
  content: "IIElevenLabs";
  position: absolute;
  left: 60px;
  bottom: 34px;
  font-weight: 800;
  font-size: 20px;
  letter-spacing: -0.5px;
  color: #111111;
  z-index: 10;
}

/* Marp header/footer styling */
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

/* Section / Page label (top-left) */
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

/* ===== COVER ===== */
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

/* ===== STORY / PAIR slides (before / after) ===== */
section.story {
  padding: 60px 60px 100px 60px;
}

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

section.story h1 {
  margin-top: 60px;
  font-size: 58px;
  max-width: 15ch;
}

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

/* ===== BIG typography section ===== */
section.big {
  padding: 80px 60px 120px 60px;
}

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

/* ===== RIGHT-NOW slide with wave ===== */
section.now {
  background-image: url('assets/waves/image3.jpg');
  background-repeat: no-repeat;
  background-position: center bottom;
  background-size: 100% 45%;
}

section.now h1 {
  font-size: 62px;
  max-width: 14ch;
  margin-top: 40px;
  position: relative;
  z-index: 2;
}

section.now .body {
  margin-top: 24px;
  font-size: 22px;
  line-height: 1.5;
  max-width: 40ch;
  position: relative;
  z-index: 2;
}

/* ===== CHAPTER divider ===== */
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

/* ===== BLANK slide ===== */
section.blank {
  background: #FFFFFF;
}

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

/* ===== CLOSE ===== */
section.close h1 {
  font-size: 88px;
  line-height: 1.02;
  letter-spacing: -2px;
  margin-top: 30vh;
  max-width: 16ch;
}

section.close .cta {
  margin-top: 30px;
  font-size: 22px;
  color: #333;
  max-width: none;
}

section.close .link {
  margin-top: 8px;
  font-size: 20px;
  font-weight: 700;
  color: #111;
}

section.close {
  background-image: url('assets/waves/image4.jpg');
  background-repeat: no-repeat;
  background-position: center top;
  background-size: 100% auto;
}

section.close > * { position: relative; z-index: 2; }

/* Hide the standard footer/paginate on cover + blank */
section.cover header, section.cover footer { display: none !important; }
section.blank header, section.blank footer { display: none !important; }

.footnotes1 {
  font-size: 12pt;
}

</style>

<!-- _class: cover -->
<!-- _paginate: false -->

# Think Local

<div class="subtitle">
<h2>Michael Gerasymenko<br></h2>
Builders &amp; Brews · Berlin · 2026
</div>

<!--
Hey builders. My name is Michael Gerasymenko. Incredibly happy to speak here today!

I have only five minutes here, so will go fast. If you have any questions afterwards, catch me afterwards or connect on LinkedIn. 

I've been building mobile apps since 2009, so you might see where are all the historical references would be coming from.

I think you might have heared about the company where I work:...
-->

---

<div class="label">ELEVENLABS / CONTEXT</div>

# ElevenLabs

- The Voice AI · over $600M ARR · valued at $22B
- I started here six months ago, company went from 400 to 800 people
- I'm on the Mobile team, working on ElevenReader
- We are hiring, also remote
- Opinions are my own

<!--
ElevenLabs! It is a voice AI company. Since I've started here six months ago, we doubled the headcount. This means, we are hiring. Many internal products are run like startups, so reach out with your ideas as well.

For this presentation, I must share a waiver: Opinions are my own, so don't see it as a company position, but as my own one.

I'm working on the ElevenReader product, which is simply aweseome, I recommend checking it out. If you catch me afterwards I can add you on an annual subscription, but in that case you must share with me the bug reports. IF you find any!

But first, there were some news I must share:

-->

---
<!-- _class: chapter -->



# ElevenLabs TTS V4

https://elevenlabs.io/v4 

live on 28th of September

<!--

I think it would be fair to say that the TTS is one of the foundational blocks of ElevenLabs, and we have a new version to share. Luckily, I don't have to talk, as it would be presenting itself -Play-

-->

---

<!-- _class: chapter -->

<div class="num">Chapter I</div>

# Time

<!--

It's ironic that I have only five minutes to talk about time, even less now, but here we are. I promise to be on time!
-->

---

<!-- _class: story -->

<div class="kicker">BEFORE / Chapter I</div>

# Precise time

<div class="body">

</div>

<img class="art" src="assets/big-ben.jpg" />

<!--

We frequently have not enough time, but in the past people had a trouble with time that was even worse. 

If you think about a tall medieval city building, you've probably noticed that people tend to put huge clocks on them. Or bells ringing at the specifc times throughout the day. There were even people going door to door to wake people up. This was done to a big extent out of necessity. 

Problem was, they could not determine the exact current time. Until people invented precise home and then pocket watch, only reliable way to count time was to use the sun height above the horizon in a combination with the local observations or local geographical coordinates.

A medieval dweller was unable to determine exact time without those huge clocks or bells.

-->

---
<!-- _class: story -->

<div class="kicker">BEFORE / Chapter I</div>

# Sailors got lost at sea

<img class="art" src="assets/sailors.png" />

<!--

In 1714, the British Empire was losing ships — not to storms, not to enemies, but because sailors literally can't tell where they are.

To know your longitude at sea, you need to know the exact time back at your home port. And no clock existed that could survive an ocean voyage.

So Parliament offers £20,000 — millions today — to anyone who can build one.

-->

---

<!-- _class: story -->

<div class="kicker">AFTER / Chapter I</div>

# Time moved onto your wrist

<img class="art" src="assets/wristwatch.png" />

<!--

So why I am telling you about all this? If you are going to put yourself in the shoes of a medieval person, a peasant or an inventor, they would never in their live imagine having a source of a precise time.

The centralized time source is what they knew. They might have anticipated the coming of better tower clocks, may be with a highlighted face, or having more of them. But never in their live they anticipated having a personal pocket watch.

-->


---

<!-- _class: chapter -->

<div class="num">Chapter II</div>

# Computer Time

<!-- 

Luckily, we have more time here. So let's continue

-->

---

<!-- _class: story -->

<div class="kicker">BEFORE / Chapter II</div>

# You walked to the computer


<img class="art" src="assets/punch-cards.png" />

<!--
My mother, in the 1970s, wrote her university assignments on punch cards, then she walked to the university building's cellar, handed them to an operator. Then, the task was executed on the machine during the night. She came back the next day to pick up a printout, sometimes just to find one letter bug in the punch card.

Computing lived in a room. You visited it. Same shape as the town clock.

Some visionaries at the time across the ocean were already imaginigng the compact computers. But I assure you those visionaries did really great later on.

-->

---

<!-- _class: story -->

<div class="kicker">AFTER / Chapter II</div>

# The computer walked into your pocket


<img class="art" src="assets/iphone-2g.jpg" />

<!--
Then it moved. First onto desks. Then into pockets. I started building for iPhone in 2009.

When Steve Jobs held up the phone in 2007, nobody in that room said "the killer app will be a photo-filter service." Nobody said "we'll summon strangers' cars." Nobody said "we'll replace SMS with a chat app."

Those products appeared because the technology moved to the person. And whole social patterns died — waiting by the landline for a call you couldn't miss is a genre that has evaporated.

-->

---

<!-- _class: chapter -->

<div class="num">Chapter III</div>

# Next Revolution

---

<!-- _class: big -->

<div class="label">THE PATTERN</div>

<h1>It happens again. <br> It happens faster.</h1>



<!--
400 years · 50 years · 20 years · 15 years · ?
400 years for clocks. 50 years for factory power. 20 years for computers. 15 for mobile.
Every wave, faster. Every wave, we underestimated what people would do with the capability once it became not centralized but personal and private.

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
Which brings us to right now. If you want to think with AI, you send your prompt to a data center owned by someone else, and you pay for the round trip by the token. Your ideas, your users' voices, your customers' medical records — they all go on a trip.

Soon, "wait, you had to send your data to a server?" will sound as antique as "wait, you had to be home to receive a phone call?"

The technology will move. Physics, economics, privacy — all three point the same way. That part is not my prediction. It's inevitable.
-->

---

<!-- _class: blank -->
<!-- _paginate: false -->

<div class="caption">THIS PAGE IS INTENTIONALLY LEFT BLANK</div>

<!--
[Pause. Let the silence sit for a beat.]

What is not inevitable is what you build with it. Nobody predicted Spotify from watching a musician play in a Victorian parlor. Nobody predicted Instagram from an iPhone announcement.
The product is a blank page. Your job — as builders in this room, today — is to be the person who creates what goes on it.
-->


---

<!-- _class: close -->

#

<br>
<br>
<br>
<br>

## Thank you!

<div class="cta">We're hiring people who want to figure out what<br> happens next.</div>

<div class="link">elevenlabs.io/careers · come say hi</div>
<br>
<br>
<div class="footnotes1">Some images AI-generated. Thanks to Unsplash users Sophia Stark and Enrico Bet</div>

<!--
The clock is coming.
If any of this made you think about tomorrow instead of today — we're hiring people who want to figure out what happens next.
Find me at the coffee. Thanks Berlin.
-->
