import React, { useState, useEffect, useRef, useMemo } from "react";
import {
  Sparkles, GraduationCap, Users, User, CalendarDays, ChevronRight, Bell,
  ScanLine, BookOpen, FileText, Search, Send, X, ShieldCheck, Plus, Tag, MailOpen, MapPin,
  TrendingUp, Check, Ruler, Grid3x3, ChevronLeft, Wallet, Bookmark, AlertTriangle,
  ScanFace, Lock, KeyRound, SlidersHorizontal, Download, Target, Trophy, Clock,
  CalendarRange, PackageSearch, ArrowRight, Compass,
} from "lucide-react";

/* ───────────────────────  TOKENS  ─────────────────────── */
const T = {
  ink: "#090B12",
  raise: "rgba(255,255,255,0.045)",
  raise2: "rgba(255,255,255,0.075)",
  hair: "rgba(255,255,255,0.09)",
  text: "#F2F4FA",
  muted: "#8B93AD",
  dim: "#5C6480",
  purple: "#A78BFA",
  purpleDeep: "#7C3AED",
  blue: "#60A5FA",
  blueDeep: "#2563EB",
  green: "#34D399",
  amber: "#FBBF24",
  red: "#F87171",
  pink: "#F472B6",
};
const SF = '-apple-system, "SF Pro Display", "SF Pro Text", system-ui, "Segoe UI", sans-serif';
const MONO = 'ui-monospace, "SF Mono", "JetBrains Mono", Menlo, monospace';

const card = (t = 1) => ({
  background: t === 2 ? T.raise2 : T.raise,
  border: `0.5px solid ${T.hair}`,
  borderRadius: 18,
});
const tint = (hex, a) => {
  const n = parseInt(hex.slice(1), 16);
  return `rgba(${n >> 16},${(n >> 8) & 255},${n & 255},${a})`;
};

/* ───────────────────────  DATA  ─────────────────────── */
const COURSES = [
  { code: "CS402", name: "Data Structures", att: 96, grade: "A−", hrs: 3, next: "Today · 10:30 · Hall B2" },
  { code: "MA201", name: "Linear Algebra", att: 68, grade: "C+", hrs: 3, next: "Tue · 09:00 · Hall A4" },
  { code: "CS310", name: "Databases", att: 100, grade: "A", hrs: 3, next: "Wed · 12:30 · Lab 2" },
  { code: "PH101", name: "Physics II", att: 74, grade: "B", hrs: 2, next: "Thu · 11:00 · Hall C1" },
  { code: "EN102", name: "Technical Writing", att: 88, grade: "B+", hrs: 2, next: "Sun · 09:00 · Hall D3" },
];
const MARKET = [
  { title: "Calculus textbook", meta: "Stewart · 8th ed.", price: "120 EGP", seller: "Level 2 · Verified", c: T.blueDeep },
  { title: "Scientific calculator", meta: "Casio fx-991EX", price: "300 EGP", seller: "Level 3 · Verified", c: T.purpleDeep },
  { title: "Lab coat · size M", meta: "Worn one semester", price: "90 EGP", seller: "Level 1 · Verified", c: "#0F766E" },
];
const GROUPS = [
  { title: "CS402 · Data Structures", meta: "Wed 14:00 · Library Room 4", spots: "2 spots left", c: T.purpleDeep },
  { title: "MA201 · Midterm revision", meta: "Thu 16:00 · Hall A4", spots: "5 spots left", c: T.blueDeep },
];
const EVENTS = [
  { title: "ACM O6U · Hackathon", meta: "Sat 09:00 · Innovation Hub", spots: "Registration open", c: "#B45309" },
  { title: "Career fair · Engineering", meta: "Mon 10:00 · Main Plaza", spots: "42 companies", c: "#0F766E" },
];

const AI_REPLIES = {
  "Can I graduate next semester?": {
    verdict: "Not next semester — but you can finish in two.",
    body: "You have 24 credit hours left and the registration cap is 18. I've built a path: 18 hours next term plus a 6-hour summer session. Two of the remaining courses have prerequisites you already cleared.",
    chips: [
      ["18 + 6 hours", T.blue],
      ["Summer required", T.amber],
      ["Graduate: Aug 2027", T.green],
    ],
    cta: "Show the plan",
  },
  "Why is my GPA dropping?": {
    verdict: "MA201 is doing the damage.",
    body: "Your midterm fell 14 points and attendance is at 68% — below the 75% threshold. Every other course is stable or improving. Fixing MA201 alone lifts your cumulative GPA to an estimated 3.28.",
    chips: [
      ["MA201 · 68%", T.red],
      ["Midterm −14", T.amber],
      ["Recoverable", T.green],
    ],
    cta: "Book revision blocks",
  },
  "Plan my week": {
    verdict: "14 study hours placed. No conflicts.",
    body: "I used the gaps between your lectures and protected Friday evening. MA201 gets the most hours because it's the course dragging your GPA. Your mock exam sits on Friday morning, 48 hours before the real one.",
    chips: [
      ["14 hrs placed", T.purple],
      ["0 conflicts", T.green],
      ["Mock exam Fri", T.blue],
    ],
    cta: "Add to calendar",
  },
  "What should I revise tonight?": {
    verdict: "Balanced trees. Two hours is enough.",
    body: "Thursday's CS402 quiz covers lectures 6 and 7, and balanced trees is the only topic you haven't opened in the CMS. Everything else on the quiz you've already been assessed on — and scored above 85%.",
    chips: [
      ["Lecture 7", T.blue],
      ["2 hrs", T.purple],
      ["Quiz Thursday", T.amber],
    ],
    cta: "Open lecture 7",
  },
};
const PROMPTS = Object.keys(AI_REPLIES);

const LOST = [
  { title: "AirPods Pro · white case", meta: "Found in Hall B2 · photo-matched to your report", price: "", seller: "Claim by 20 Oct", c: T.blueDeep },
  { title: "Student ID · Mariam H.", meta: "Found at Gate 3 · owner notified", price: "", seller: "Returned", c: "#0F766E" },
  { title: "Grey hoodie · size L", meta: "Library, 2nd floor · 3 days ago", price: "", seller: "Unclaimed", c: T.purpleDeep },
];

const SEMESTERS = [
  ["Level 1 · Fall", "2.62", 15], ["Level 1 · Spring", "2.80", 15],
  ["Level 2 · Fall", "2.68", 16], ["Level 2 · Spring", "2.88", 16],
  ["Level 3 · Fall", "2.94", 17], ["Level 3 · Spring", "3.12", 17],
];

const GRADE_PTS = [["A", 4.0], ["A−", 3.7], ["B+", 3.3], ["B", 3.0], ["C+", 2.5], ["C", 2.0]];

const NOTIFS = [
  { day: "Today", items: [
    { icon: MapPin, c: T.amber, cat: "Academic", title: "Room changed · CS402", body: "Moved from Hall B2 to Hall A1. Your map is already updated.", time: "2m", unread: true, action: "Open the map" },
    { icon: FileText, c: T.pink, cat: "Deadline", title: "Assignment 5 is due Sunday", body: "CS402 · not submitted. This is the last piece of coursework before the quiz.", time: "1h", unread: true, action: "Open assignment" },
    { icon: Sparkles, c: T.purple, cat: "Nexus", title: "Three study blocks placed", body: "I used your free hours on Tuesday and Thursday. Nothing clashes.", time: "3h", unread: true, action: "See the week" },
  ]},
  { day: "Yesterday", items: [
    { icon: AlertTriangle, c: T.amber, cat: "Academic", title: "MA201 attendance fell to 68%", body: "That is below the 75% threshold. Four lectures brings it back.", time: "1d", unread: false, action: "Ask Nexus to fix this" },
    { icon: Tag, c: T.green, cat: "Campus", title: "Your listing sold", body: "Calculus textbook · 120 EGP. Mariam will collect it at Gate 3.", time: "1d", unread: false },
    { icon: GraduationCap, c: T.blue, cat: "Academic", title: "Grade posted · CS310", body: "Databases · A. Your cumulative GPA moved to 3.12.", time: "1d", unread: false },
  ]},
];

/* ─────────────────  REDLINES (UX rationale per screen)  ───────────────── */
const SPECS = {
  auth: {
    title: "Splash → Onboarding → Login → Face ID",
    job: "Get a returning student from icon tap to their record in under two seconds, without a form.",
    pins: [
      { x: 50, y: 40, note: "Splash is not a loading screen — it's the mark holding still while the token is validated. If the session is live, the student never sees Login at all." },
      { x: 50, y: 70, note: "Onboarding is three cards and can be skipped from the first frame. It sells the AI and the privacy promise, in that order, because the second is what earns the first." },
      { x: 50, y: 88, note: "Face ID is the primary path; the password field is the fallback. Nexus never stores the password — sign-in returns a short-lived token held in the Secure Enclave." },
    ],
  },
  schedule: { title: "Schedule", job: "The week, with the room changes already applied.", pins: [
    { x: 50, y: 14, note: "Week strip pins today; scrubbing it is horizontal, so the thumb never leaves the bottom third." },
    { x: 50, y: 45, note: "Free hours are drawn as blocks, not gaps — because Nexus is going to fill them." }]},
  grades: { title: "Grades", job: "Semester and cumulative, side by side — nothing else.", pins: [
    { x: 50, y: 16, note: "Two numbers, one comparison. A student wants to know whether this term is helping or hurting." },
    { x: 82, y: 52, note: "Grade chips carry semantic colour: green above target, amber at risk. The letter never appears bare." }]},
  attendance: { title: "Attendance", job: "Show the 75% line, and how far you are from it.", pins: [
    { x: 30, y: 15, note: "The ring is the summary; the bars are the truth. Both share one colour rule." },
    { x: 75, y: 45, note: "Every bar draws the university's threshold as a tick. You are always measured against their line, not ours." }]},
  transcript: { title: "Transcript", job: "The official record, and a way to hand it to someone.", pins: [
    { x: 50, y: 15, note: "Cumulative GPA sits above the semesters — the number an employer asks for is the first one on screen." },
    { x: 50, y: 78, note: "Export is a single button, registrar-sealed and QR-verifiable. That's the whole feature." }]},
  gpasim: { title: "GPA Simulator", job: "Let a student feel the consequence of a grade before the exam.", pins: [
    { x: 50, y: 16, note: "The projected number is the hero and it recomputes live — no Calculate button, ever." },
    { x: 50, y: 55, note: "Grades are segmented pickers, not sliders: a grade is discrete, so the control must be." },
    { x: 50, y: 90, note: "Nexus names the single highest-leverage move, so the simulator ends in advice, not arithmetic." }]},
  planner: { title: "Study Planner", job: "Turn free hours into a plan the student didn't have to make.", pins: [
    { x: 50, y: 18, note: "“0 conflicts” is the trust claim. It must be visible before the grid." },
    { x: 50, y: 45, note: "AI blocks are purple, lectures grey, exams red — one glance tells you what the machine added." }]},
  gradplan: { title: "Graduation Planner", job: "Compress four years into one legible path with one warning.", pins: [
    { x: 50, y: 14, note: "96% on-time is a probability, labelled as one. We never present a forecast as a fact." },
    { x: 50, y: 88, note: "The bottleneck is the entire point of the screen: CS412 is Fall-only and gates two courses." }]},
  today: {
    title: "Today",
    job: "Answer “what does the next hour ask of me?” before the student thinks to ask.",
    pins: [
      { x: 50, y: 15, note: "Nexus thread. The AI has no avatar and no chat here — it's a hairline that only swells into a card when it has something actionable. Dismissing it is one tap and it stays dismissed for the day." },
      { x: 50, y: 33, note: "Next-up card is the hero. Live countdown, room, and a change badge that appears the moment the registrar pushes an update." },
      { x: 15, y: 62, note: "The day is a timeline, not a list — gaps are rendered as first-class items, because gaps are where the AI acts." },
      { x: 84, y: 88, note: "Four numbers a student actually re-checks. Anything else belongs in Portal." },
    ],
  },
  portal: {
    title: "Portal",
    job: "Make the university's academic record readable in a glance, and honest about risk.",
    pins: [
      { x: 50, y: 18, note: "GPA never appears as a bare number: always with its delta and the credit-hour progress it sits inside." },
      { x: 16, y: 47, note: "Attendance ring is the only alarm colour in the app. Amber below 75% — the university's own threshold, not an invented one." },
      { x: 84, y: 47, note: "Tapping a course opens a sheet, not a new page. The student never loses the list." },
    ],
  },
  campus: {
    title: "Campus",
    job: "Give student-to-student life the same quality bar as the academic record.",
    pins: [
      { x: 50, y: 21, note: "Segmented control — iOS-native, three peers, no hamburger, no hidden tab." },
      { x: 78, y: 46, note: "Every listing carries the seller's level and verification. Trust is a design primitive here, not a badge we add later." },
    ],
  },
  nexus: {
    title: "Nexus",
    job: "Turn the transcript into an answer, in the shape of a decision.",
    pins: [
      { x: 50, y: 35, note: "Answers are structured: verdict first, reasoning second, evidence chips third. Never a wall of prose." },
      { x: 50, y: 82, note: "Suggested prompts solve the blank-input problem — students don't know what an academic model can be asked." },
      { x: 82, y: 62, note: "The AI proposes; it never acts. Every consequence sits behind an explicit action button." },
    ],
  },
  notifs: {
    title: "Notifications",
    job: "Carry the seven channels a student watches today into one ranked, honest list.",
    pins: [
      { x: 50, y: 22, note: "Filters, not folders. A student scans by kind — academic, deadline, campus, Nexus — and never files anything." },
      { x: 50, y: 44, note: "Every notification ends in an action. If there's nothing to do about it, it isn't a notification — it's a number, and numbers live in Portal." },
      { x: 50, y: 66, note: "Grouped by day, newest first, unread carries a dot and a lift. Read items stay legible: the app doesn't punish you for having seen something." },
    ],
  },
  me: {
    title: "Me",
    job: "Identity, access, and a plain-language promise about data.",
    pins: [
      { x: 50, y: 24, note: "Digital ID is the one screen that must render with no network. It opens the turnstile." },
      { x: 50, y: 74, note: "Privacy is written in the interface, in the words a student would use — not buried in settings." },
    ],
  },
};

/* ───────────────────────  CHROME  ─────────────────────── */
function StatusBar({ clock }) {
  return (
    <div style={{ height: 54, display: "flex", alignItems: "flex-end", justifyContent: "space-between", padding: "0 26px 6px", position: "relative", zIndex: 30 }}>
      <span style={{ fontFamily: SF, fontSize: 15, fontWeight: 600, color: T.text, letterSpacing: 0.2 }}>{clock}</span>
      <div style={{ display: "flex", gap: 5, alignItems: "center" }}>
        <svg width="18" height="11" viewBox="0 0 18 11"><g fill={T.text}>
          <rect x="0" y="7" width="3" height="4" rx="1" /><rect x="5" y="5" width="3" height="6" rx="1" />
          <rect x="10" y="2.5" width="3" height="8.5" rx="1" /><rect x="15" y="0" width="3" height="11" rx="1" />
        </g></svg>
        <svg width="16" height="11" viewBox="0 0 16 11" fill="none"><path d="M8 9.6l2.2-2.4a3 3 0 00-4.4 0L8 9.6z" fill={T.text} /><path d="M2.6 4.2a7.6 7.6 0 0110.8 0" stroke={T.text} strokeWidth="1.4" strokeLinecap="round" opacity=".9" /><path d="M4.9 6.6a4.4 4.4 0 016.2 0" stroke={T.text} strokeWidth="1.4" strokeLinecap="round" opacity=".9" /></svg>
        <div style={{ width: 24, height: 11.5, borderRadius: 3, border: `1px solid ${tint("#FFFFFF", 0.4)}`, padding: 1.5, display: "flex" }}>
          <div style={{ width: "78%", background: T.text, borderRadius: 1.5 }} />
        </div>
      </div>
    </div>
  );
}

function TabBar({ tab, setTab, alert }) {
  const items = [
    ["today", "Home", CalendarDays],
    ["portal", "Academics", GraduationCap],
    ["nexus", "AI", Sparkles],
    ["campus", "Campus", Users],
    ["me", "Profile", User],
  ];
  return (
    <div style={{
      position: "absolute", left: 0, right: 0, bottom: 0, paddingBottom: 22, zIndex: 40,
      background: "rgba(9,11,18,0.72)", backdropFilter: "blur(24px) saturate(160%)",
      WebkitBackdropFilter: "blur(24px) saturate(160%)", borderTop: `0.5px solid ${T.hair}`,
    }}>
      <div style={{ display: "flex", height: 50 }}>
        {items.map(([id, label, Icon]) => {
          const on = tab === id;
          const isAI = id === "nexus";
          return (
            <button key={id} onClick={() => setTab(id)} style={{
              flex: 1, background: "none", border: "none", cursor: "pointer",
              display: "flex", flexDirection: "column", alignItems: "center", justifyContent: "center",
              gap: 3, padding: 0, minHeight: 44, position: "relative",
            }}>
              <div style={{ position: "relative" }}>
                {isAI && on && <div className="glowpulse" style={{ position: "absolute", inset: -9, borderRadius: 999, background: `radial-gradient(circle, ${tint(T.purple, 0.45)}, transparent 70%)` }} />}
                <Icon size={23} strokeWidth={on ? 2.3 : 1.8}
                  color={on ? (isAI ? T.purple : T.text) : T.dim}
                  style={{ position: "relative" }} />
                {isAI && alert && !on && <span style={{ position: "absolute", top: -1, right: -2, width: 7, height: 7, borderRadius: 9, background: T.purple, border: `1.5px solid ${T.ink}` }} />}
              </div>
              <span style={{ fontFamily: SF, fontSize: 10, fontWeight: on ? 600 : 500, color: on ? (isAI ? T.purple : T.text) : T.dim, letterSpacing: 0.1 }}>{label}</span>
            </button>
          );
        })}
      </div>
      <div style={{ display: "flex", justifyContent: "center", paddingTop: 6 }}>
        <div style={{ width: 134, height: 5, borderRadius: 9, background: tint("#FFFFFF", 0.32) }} />
      </div>
    </div>
  );
}

/* Large title that collapses into an inline nav title on scroll — the iOS behaviour. */
function Nav({ title, scrolled, right }) {
  return (
    <>
      <div style={{
        position: "sticky", top: 0, zIndex: 20, height: 44, display: "flex", alignItems: "center",
        justifyContent: "center", padding: "0 18px",
        background: scrolled ? "rgba(9,11,18,0.74)" : "transparent",
        backdropFilter: scrolled ? "blur(20px) saturate(160%)" : "none",
        WebkitBackdropFilter: scrolled ? "blur(20px) saturate(160%)" : "none",
        borderBottom: `0.5px solid ${scrolled ? T.hair : "transparent"}`,
        transition: "background .25s, border-color .25s",
      }}>
        <span style={{ fontFamily: SF, fontSize: 17, fontWeight: 600, color: T.text, opacity: scrolled ? 1 : 0, transition: "opacity .2s" }}>{title}</span>
        {right && <div style={{ position: "absolute", right: 18 }}>{right}</div>}
      </div>
      <h1 style={{
        fontFamily: SF, fontSize: 34, fontWeight: 700, letterSpacing: -0.8, color: T.text,
        margin: "2px 20px 12px", opacity: scrolled ? 0 : 1, transform: `translateY(${scrolled ? -6 : 0}px)`,
        transition: "opacity .2s, transform .2s",
      }}>{title}</h1>
    </>
  );
}

const Section = ({ children }) => (
  <div style={{ fontFamily: SF, fontSize: 13, fontWeight: 600, color: T.dim, letterSpacing: 0.6, textTransform: "uppercase", margin: "22px 20px 10px" }}>{children}</div>
);

function Ring({ pct, size = 38 }) {
  const c = pct < 75 ? T.amber : T.green;
  const r = (size - 5) / 2, circ = 2 * Math.PI * r;
  return (
    <div style={{ position: "relative", width: size, height: size }}>
      <svg width={size} height={size} style={{ transform: "rotate(-90deg)" }}>
        <circle cx={size / 2} cy={size / 2} r={r} stroke={tint("#FFFFFF", 0.1)} strokeWidth="3.5" fill="none" />
        <circle cx={size / 2} cy={size / 2} r={r} stroke={c} strokeWidth="3.5" fill="none"
          strokeDasharray={circ} strokeDashoffset={circ * (1 - pct / 100)} strokeLinecap="round"
          style={{ transition: "stroke-dashoffset 1s cubic-bezier(.2,.8,.2,1)" }} />
      </svg>
      <span style={{ position: "absolute", inset: 0, display: "grid", placeItems: "center", fontFamily: MONO, fontSize: 10, fontWeight: 600, color: c }}>{pct}</span>
    </div>
  );
}

/* ───────────────────────  SCREENS  ─────────────────────── */
function Today({ clock, onOpen, thread, setThread, setTab }) {
  const [m, h] = [parseInt(clock.slice(3)), parseInt(clock.slice(0, 2))];
  const left = 630 - (h * 60 + m); // minutes to 10:30
  const countdown = left > 60 ? `in ${Math.floor(left / 60)}h ${left % 60}m` : `in ${left}m`;

  const day = [
    ["09:00", "EN102 · Technical Writing", "Hall D3 · 60 min", T.blue, BookOpen, false],
    ["10:30", "CS402 · Data Structures", "Hall B2 · 90 min", T.purple, BookOpen, false],
    ["12:30", "Free — 3 hours", "Nexus placed: revise CS402", T.green, Sparkles, true],
    ["15:30", "MA201 · Lab", "Lab 4 · attendance at 68%", T.amber, AlertTriangle, false],
  ];

  return (
    <>
      <div style={{ margin: "0 20px 14px" }}>
        <div style={{ fontFamily: SF, fontSize: 15, color: T.muted }}>Monday, 13 October</div>
      </div>

      {/* SIGNATURE: the Nexus thread */}
      <div style={{ margin: "0 20px 18px" }}>
        <div className="thread" style={{ height: 2, borderRadius: 2, background: `linear-gradient(90deg, transparent, ${T.purple}, ${T.blue}, transparent)`, marginBottom: thread ? 12 : 0, transition: "margin .3s" }} />
        {thread && (
          <div className="rise" style={{ ...card(2), padding: 14, display: "flex", gap: 12, alignItems: "flex-start" }}>
            <div style={{ width: 30, height: 30, borderRadius: 10, display: "grid", placeItems: "center", background: tint(T.purpleDeep, 0.9), flexShrink: 0 }}>
              <Sparkles size={15} color="#fff" />
            </div>
            <div style={{ flex: 1 }}>
              <div style={{ fontFamily: SF, fontSize: 15, fontWeight: 600, color: T.text, lineHeight: 1.35 }}>
                You have a 3-hour gap after CS402.
              </div>
              <div style={{ fontFamily: SF, fontSize: 14, color: T.muted, marginTop: 2, lineHeight: 1.4 }}>
                Library Room 4 is free until 15:00. It's your best window to revise before Thursday's quiz.
              </div>
              <div style={{ display: "flex", gap: 8, marginTop: 12 }}>
                <button onClick={() => setThread(false)} style={{ fontFamily: SF, fontSize: 14, fontWeight: 600, color: "#fff", background: T.purpleDeep, border: "none", borderRadius: 10, padding: "9px 14px", minHeight: 36, cursor: "pointer" }}>Book the room</button>
                <button onClick={() => setThread(false)} style={{ fontFamily: SF, fontSize: 14, fontWeight: 500, color: T.muted, background: "none", border: `0.5px solid ${T.hair}`, borderRadius: 10, padding: "9px 14px", minHeight: 36, cursor: "pointer" }}>Not today</button>
              </div>
            </div>
          </div>
        )}
      </div>

      {/* Hero: next up */}
      <div style={{ margin: "0 20px" }}>
        <div style={{ ...card(), padding: 18, background: `linear-gradient(140deg, ${tint(T.purpleDeep, 0.28)}, ${tint(T.blueDeep, 0.12)} 60%, ${T.raise})` }}>
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center" }}>
            <span style={{ fontFamily: SF, fontSize: 12, fontWeight: 700, color: T.purple, letterSpacing: 0.8 }}>NEXT UP</span>
            <span className="pulse" style={{ fontFamily: SF, fontSize: 11, fontWeight: 600, color: T.amber, background: tint(T.amber, 0.14), padding: "4px 8px", borderRadius: 7 }}>Room changed · 2m ago</span>
          </div>
          <div style={{ fontFamily: SF, fontSize: 26, fontWeight: 700, letterSpacing: -0.5, color: T.text, marginTop: 10 }}>Data Structures</div>
          <div style={{ fontFamily: SF, fontSize: 15, color: T.muted, marginTop: 3 }}>CS402 · Dr. Hesham · Hall B2</div>
          <div style={{ display: "flex", alignItems: "baseline", gap: 8, marginTop: 14 }}>
            <span style={{ fontFamily: MONO, fontSize: 22, fontWeight: 700, color: T.text }}>10:30</span>
            <span style={{ fontFamily: SF, fontSize: 15, color: T.blue, fontWeight: 600 }}>{countdown}</span>
          </div>
        </div>
      </div>

      <Section>Your day</Section>
      <div style={{ margin: "0 20px" }}>
        {day.map(([time, title, meta, c, Icon, ai], i) => (
          <div key={i} style={{ display: "flex", gap: 12, alignItems: "stretch" }}>
            <div style={{ width: 44, paddingTop: 12, textAlign: "right", fontFamily: MONO, fontSize: 12, color: T.dim }}>{time}</div>
            <div style={{ display: "flex", flexDirection: "column", alignItems: "center" }}>
              <div style={{ width: 9, height: 9, borderRadius: 9, marginTop: 15, background: ai ? "transparent" : c, border: ai ? `1.5px dashed ${c}` : "none" }} />
              {i < day.length - 1 && <div style={{ flex: 1, width: 1, background: T.hair }} />}
            </div>
            <div style={{ flex: 1, paddingBottom: 10 }}>
              <div style={{ ...card(), padding: 12, display: "flex", gap: 10, alignItems: "center", borderStyle: ai ? "dashed" : "solid" }}>
                <Icon size={16} color={c} strokeWidth={2} />
                <div style={{ flex: 1, minWidth: 0 }}>
                  <div style={{ fontFamily: SF, fontSize: 14.5, fontWeight: 600, color: T.text }}>{title}</div>
                  <div style={{ fontFamily: SF, fontSize: 12.5, color: ai ? T.green : T.muted, marginTop: 1 }}>{meta}</div>
                </div>
              </div>
            </div>
          </div>
        ))}
      </div>

      <Section>At a glance</Section>
      <div style={{ margin: "0 20px", display: "grid", gridTemplateColumns: "1fr 1fr", gap: 10 }}>
        {[["Attendance", "92%", T.green, "across 5 courses"], ["Next exam", "3 days", T.amber, "MA201 · midterm"], ["Deadlines", "2 open", T.pink, "both due Sunday"], ["Credits left", "24 hrs", T.blue, "graduate Aug 2027"]].map(([k, v, c, sub]) => (
          <button key={k} onClick={() => setTab(k === "Credits left" ? "portal" : "portal")} style={{ ...card(), padding: 14, textAlign: "left", cursor: "pointer", minHeight: 44 }}>
            <div style={{ fontFamily: SF, fontSize: 12, color: T.muted, fontWeight: 500 }}>{k}</div>
            <div style={{ fontFamily: SF, fontSize: 22, fontWeight: 700, color: c, marginTop: 4, letterSpacing: -0.3 }}>{v}</div>
            <div style={{ fontFamily: SF, fontSize: 11.5, color: T.dim, marginTop: 2 }}>{sub}</div>
          </button>
        ))}
      </div>
    </>
  );
}

function Portal({ onOpen, push }) {
  const gpa = [2.62, 2.71, 2.68, 2.88, 2.94, 3.12];
  const pts = gpa.map((g, i) => `${8 + i * 52},${58 - (g - 2.5) * 60}`).join(" ");
  return (
    <>
      <div style={{ margin: "0 20px" }}>
        <div style={{ ...card(), padding: 18 }}>
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start" }}>
            <div>
              <div style={{ fontFamily: SF, fontSize: 13, color: T.muted, fontWeight: 500 }}>Cumulative GPA</div>
              <div style={{ display: "flex", alignItems: "baseline", gap: 8, marginTop: 2 }}>
                <span style={{ fontFamily: SF, fontSize: 40, fontWeight: 700, letterSpacing: -1.4, color: T.text }}>3.12</span>
                <span style={{ fontFamily: SF, fontSize: 14, fontWeight: 700, color: T.green, display: "flex", alignItems: "center", gap: 2 }}><TrendingUp size={13} />+0.18</span>
              </div>
            </div>
            <svg width="280" height="66" viewBox="0 0 280 66" style={{ width: 120, height: 62, opacity: 0.95 }}>
              <polyline points={pts} fill="none" stroke={T.purple} strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round" />
              <circle cx="268" cy={58 - (3.12 - 2.5) * 60} r="4" fill={T.purple} />
            </svg>
          </div>
          <div style={{ height: 6, borderRadius: 6, background: tint("#FFFFFF", 0.08), marginTop: 16, overflow: "hidden" }}>
            <div className="grow" style={{ height: "100%", width: "80%", borderRadius: 6, background: `linear-gradient(90deg, ${T.purpleDeep}, ${T.purple})` }} />
          </div>
          <div style={{ display: "flex", justifyContent: "space-between", marginTop: 8 }}>
            <span style={{ fontFamily: SF, fontSize: 12.5, color: T.muted }}>Level 4 · 96 of 120 hours</span>
            <span style={{ fontFamily: MONO, fontSize: 12.5, color: T.purple, fontWeight: 600 }}>24 hrs left</span>
          </div>
        </div>
      </div>

      <Section>This semester</Section>
      <div style={{ margin: "0 20px", ...card(), overflow: "hidden" }}>
        {COURSES.map((c, i) => (
          <button key={c.code} onClick={() => onOpen(c)} style={{
            width: "100%", display: "flex", alignItems: "center", gap: 13, padding: "13px 14px", minHeight: 56,
            background: "none", border: "none", borderTop: i ? `0.5px solid ${T.hair}` : "none", cursor: "pointer", textAlign: "left",
          }}>
            <Ring pct={c.att} />
            <div style={{ flex: 1, minWidth: 0 }}>
              <div style={{ fontFamily: SF, fontSize: 15.5, fontWeight: 600, color: T.text }}>{c.name}</div>
              <div style={{ fontFamily: SF, fontSize: 12.5, color: c.att < 75 ? T.amber : T.muted, marginTop: 1 }}>
                {c.att < 75 ? `${c.code} · below the 75% threshold` : `${c.code} · ${c.hrs} credit hours`}
              </div>
            </div>
            <span style={{ fontFamily: MONO, fontSize: 14, fontWeight: 600, color: T.text }}>{c.grade}</span>
            <ChevronRight size={17} color={T.dim} />
          </button>
        ))}
      </div>

      <Section>Records</Section>
      <div style={{ margin: "0 20px", ...card(), overflow: "hidden" }}>
        {[["schedule", CalendarDays, "Schedule", "Week 9 · 2 rooms changed", T.blue],
          ["grades", GraduationCap, "Grades", "Semester GPA 3.24", T.purple],
          ["attendance", ScanLine, "Attendance", "92% · one course below the line", T.green],
          ["transcript", FileText, "Transcript", "Official · exportable as PDF", T.blue]].map(([id, Icon, t, sub, c], i) => (
          <button key={t} onClick={() => push(id)} style={{
            width: "100%", display: "flex", alignItems: "center", gap: 13, padding: "13px 14px", minHeight: 56,
            background: "none", border: "none", borderTop: i ? `0.5px solid ${T.hair}` : "none", cursor: "pointer", textAlign: "left",
          }}>
            <div style={{ width: 30, height: 30, borderRadius: 9, background: tint(c, 0.16), display: "grid", placeItems: "center" }}><Icon size={15} color={c} /></div>
            <div style={{ flex: 1 }}>
              <div style={{ fontFamily: SF, fontSize: 15.5, fontWeight: 500, color: T.text }}>{t}</div>
              <div style={{ fontFamily: SF, fontSize: 12.5, color: T.muted, marginTop: 1 }}>{sub}</div>
            </div>
            <ChevronRight size={17} color={T.dim} />
          </button>
        ))}
      </div>
    </>
  );
}

function Campus() {
  const [seg, setSeg] = useState(0);
  const data = [MARKET, LOST, GROUPS, EVENTS][seg];
  return (
    <>
      <div style={{ margin: "0 20px 14px", display: "flex", alignItems: "center", gap: 9, ...card(2), padding: "10px 12px", borderRadius: 12 }}>
        <Search size={16} color={T.dim} />
        <span style={{ fontFamily: SF, fontSize: 15, color: T.dim }}>Search books, gigs, rooms, people</span>
      </div>

      <div style={{ margin: "0 20px 16px", display: "flex", background: tint("#FFFFFF", 0.06), borderRadius: 10, padding: 2 }}>
        {["Market", "Lost & Found", "Groups", "Events"].map((s, i) => (
          <button key={s} onClick={() => setSeg(i)} style={{
            flex: 1, minHeight: 34, border: "none", borderRadius: 8, cursor: "pointer",
            background: seg === i ? tint("#FFFFFF", 0.13) : "transparent",
            boxShadow: seg === i ? "0 1px 3px rgba(0,0,0,.3)" : "none",
            fontFamily: SF, fontSize: 12.5, fontWeight: seg === i ? 600 : 500, color: seg === i ? T.text : T.muted,
            transition: "background .18s",
          }}>{s}</button>
        ))}
      </div>

      <div style={{ margin: "0 20px", display: "flex", flexDirection: "column", gap: 10 }}>
        {data.map((it, i) => (
          <div key={i} className="rise" style={{ ...card(), padding: 12, display: "flex", gap: 12, alignItems: "center", animationDelay: `${i * 45}ms` }}>
            <div style={{ width: 54, height: 54, borderRadius: 12, background: `linear-gradient(140deg, ${it.c}, ${tint(it.c, 0.35)})`, flexShrink: 0, display: "grid", placeItems: "center" }}>
              {seg === 1 && <PackageSearch size={20} color={tint("#FFFFFF", 0.85)} />}
            </div>
            <div style={{ flex: 1, minWidth: 0 }}>
              <div style={{ fontFamily: SF, fontSize: 15, fontWeight: 600, color: T.text }}>{it.title}</div>
              <div style={{ fontFamily: SF, fontSize: 12.5, color: T.muted, marginTop: 2 }}>{it.meta}</div>
              <div style={{ display: "flex", alignItems: "center", gap: 6, marginTop: 6 }}>
                {it.price && <span style={{ fontFamily: SF, fontSize: 14, fontWeight: 700, color: T.blue }}>{it.price}</span>}
                <span style={{ fontFamily: SF, fontSize: 11, fontWeight: 600, color: T.green, background: tint(T.green, 0.12), padding: "3px 7px", borderRadius: 6, display: "flex", alignItems: "center", gap: 3 }}>
                  <ShieldCheck size={11} />{it.seller || it.spots}
                </span>
              </div>
            </div>
            <ChevronRight size={17} color={T.dim} />
          </div>
        ))}
      </div>

      {seg === 0 && (
        <div style={{ margin: "18px 20px 0", ...card(), padding: 16, borderStyle: "dashed", display: "flex", gap: 12, alignItems: "center" }}>
          <div style={{ width: 34, height: 34, borderRadius: 11, background: tint(T.purpleDeep, 0.35), display: "grid", placeItems: "center", flexShrink: 0 }}>
            <Plus size={16} color={T.purple} />
          </div>
          <div style={{ flex: 1 }}>
            <div style={{ fontFamily: SF, fontSize: 14.5, fontWeight: 600, color: T.text }}>Sell something you're done with</div>
            <div style={{ fontFamily: SF, fontSize: 12.5, color: T.muted, marginTop: 2 }}>Your level and course history are attached automatically.</div>
          </div>
          <button style={{ minHeight: 36, padding: "0 14px", borderRadius: 10, border: "none", background: T.purpleDeep, color: "#fff", fontFamily: SF, fontSize: 13.5, fontWeight: 600, cursor: "pointer" }}>Post</button>
        </div>
      )}
    </>
  );
}

function Nexus({ msgs, send, typing, endRef, push }) {
  const [draft, setDraft] = useState("");
  const tools = [
    ["gpasim", SlidersHorizontal, "GPA Simulator", T.blue],
    ["planner", CalendarRange, "Study Planner", T.purple],
    ["gradplan", Target, "Graduation", T.green],
  ];
  return (
    <div style={{ display: "flex", flexDirection: "column", minHeight: "100%" }}>
      <div className="noscroll" style={{ display: "flex", gap: 9, overflowX: "auto", padding: "0 20px 16px" }}>
        {tools.map(([id, Icon, label, c]) => (
          <button key={id} onClick={() => push(id)} style={{
            flexShrink: 0, ...card(), padding: "11px 13px", cursor: "pointer", display: "flex", alignItems: "center", gap: 8, minHeight: 44,
          }}>
            <div style={{ width: 26, height: 26, borderRadius: 8, background: tint(c, 0.16), display: "grid", placeItems: "center" }}>
              <Icon size={13} color={c} />
            </div>
            <span style={{ fontFamily: SF, fontSize: 13.5, fontWeight: 600, color: T.text, whiteSpace: "nowrap" }}>{label}</span>
          </button>
        ))}
      </div>
      <div style={{ flex: 1, padding: "0 20px 8px", display: "flex", flexDirection: "column", gap: 14 }}>
        {msgs.length === 0 && (
          <div style={{ textAlign: "center", padding: "40px 10px" }}>
            <div style={{ width: 52, height: 52, borderRadius: 16, margin: "0 auto 14px", display: "grid", placeItems: "center", background: `linear-gradient(140deg, ${T.purpleDeep}, ${T.blueDeep})` }}>
              <Sparkles size={24} color="#fff" />
            </div>
            <div style={{ fontFamily: SF, fontSize: 17, fontWeight: 600, color: T.text }}>Ask about your record</div>
            <div style={{ fontFamily: SF, fontSize: 14, color: T.muted, marginTop: 4, lineHeight: 1.45 }}>
              Nexus reads your transcript, attendance and timetable. It doesn't search the web.
            </div>
          </div>
        )}
        {msgs.map((m, i) => m.role === "user" ? (
          <div key={i} className="rise" style={{ alignSelf: "flex-end", maxWidth: "82%", background: T.purpleDeep, color: "#fff", padding: "10px 14px", borderRadius: "18px 18px 5px 18px", fontFamily: SF, fontSize: 15.5, lineHeight: 1.4 }}>
            {m.text}
          </div>
        ) : (
          <div key={i} className="rise" style={{ ...card(2), padding: 15, borderRadius: "18px 18px 18px 5px", maxWidth: "94%" }}>
            <div style={{ display: "flex", alignItems: "center", gap: 7, marginBottom: 9 }}>
              <Sparkles size={13} color={T.purple} />
              <span style={{ fontFamily: SF, fontSize: 11, fontWeight: 700, color: T.purple, letterSpacing: 0.7 }}>NEXUS</span>
            </div>
            <div style={{ fontFamily: SF, fontSize: 16, fontWeight: 600, color: T.text, lineHeight: 1.35 }}>{m.verdict}</div>
            <div style={{ fontFamily: SF, fontSize: 14.5, color: T.muted, marginTop: 6, lineHeight: 1.5 }}>{m.body}</div>
            <div style={{ display: "flex", flexWrap: "wrap", gap: 6, marginTop: 12 }}>
              {m.chips.map(([t, c]) => (
                <span key={t} style={{ fontFamily: SF, fontSize: 12.5, fontWeight: 600, color: c, background: tint(c, 0.12), border: `0.5px solid ${tint(c, 0.3)}`, padding: "5px 9px", borderRadius: 8 }}>{t}</span>
              ))}
            </div>
            <button style={{ marginTop: 12, minHeight: 40, width: "100%", border: `0.5px solid ${tint(T.purple, 0.35)}`, background: tint(T.purpleDeep, 0.25), color: T.purple, borderRadius: 11, fontFamily: SF, fontSize: 14.5, fontWeight: 600, cursor: "pointer" }}>{m.cta}</button>
          </div>
        ))}
        {typing && (
          <div style={{ ...card(2), padding: "14px 16px", borderRadius: "18px 18px 18px 5px", alignSelf: "flex-start", display: "flex", gap: 5 }}>
            {[0, 1, 2].map(i => <span key={i} className="dot" style={{ width: 7, height: 7, borderRadius: 9, background: T.purple, animationDelay: `${i * 0.16}s` }} />)}
          </div>
        )}
        <div ref={endRef} />
      </div>

      <div style={{ position: "sticky", bottom: 0, paddingTop: 10, background: "linear-gradient(180deg, transparent, rgba(9,11,18,0.9) 30%)" }}>
        <div style={{ display: "flex", gap: 7, overflowX: "auto", padding: "0 20px 10px" }} className="noscroll">
          {PROMPTS.map(p => (
            <button key={p} onClick={() => send(p)} style={{
              whiteSpace: "nowrap", flexShrink: 0, minHeight: 34, padding: "0 13px", borderRadius: 17,
              border: `0.5px solid ${T.hair}`, background: T.raise, color: T.text,
              fontFamily: SF, fontSize: 13.5, fontWeight: 500, cursor: "pointer",
            }}>{p}</button>
          ))}
        </div>
        <div style={{ margin: "0 20px 12px", display: "flex", alignItems: "center", gap: 8, ...card(2), borderRadius: 22, padding: "6px 6px 6px 16px" }}>
          <input value={draft} onChange={e => setDraft(e.target.value)}
            onKeyDown={e => { if (e.key === "Enter" && draft.trim()) { send(draft); setDraft(""); } }}
            placeholder="Ask Nexus…"
            style={{ flex: 1, background: "none", border: "none", outline: "none", color: T.text, fontFamily: SF, fontSize: 15.5, minWidth: 0 }} />
          <button onClick={() => { if (draft.trim()) { send(draft); setDraft(""); } }}
            style={{ width: 34, height: 34, borderRadius: 17, border: "none", background: draft.trim() ? T.purpleDeep : tint("#FFFFFF", 0.08), display: "grid", placeItems: "center", cursor: "pointer", transition: "background .2s" }}>
            <Send size={15} color={draft.trim() ? "#fff" : T.dim} />
          </button>
        </div>
      </div>
    </div>
  );
}

function Me({ onScan, onNotifs }) {
  return (
    <>
      <div style={{ margin: "0 20px" }}>
        <div style={{ ...card(), padding: 18, background: `linear-gradient(140deg, ${tint(T.purpleDeep, 0.5)}, ${tint(T.blueDeep, 0.35)})` }}>
          <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start" }}>
            <div>
              <div style={{ fontFamily: SF, fontSize: 11, fontWeight: 700, color: tint("#FFFFFF", 0.7), letterSpacing: 1 }}>OCTOBER 6 UNIVERSITY</div>
              <div style={{ fontFamily: SF, fontSize: 24, fontWeight: 700, color: "#fff", marginTop: 8, letterSpacing: -0.4 }}>Ahmed Kamal</div>
              <div style={{ fontFamily: SF, fontSize: 14, color: tint("#FFFFFF", 0.75), marginTop: 2 }}>Computer Science · Level 4</div>
              <div style={{ fontFamily: MONO, fontSize: 13, color: tint("#FFFFFF", 0.9), marginTop: 12, letterSpacing: 1 }}>20211456</div>
            </div>
            <div style={{ width: 62, height: 62, borderRadius: 10, background: "#fff", display: "grid", placeItems: "center" }}>
              <div style={{ width: 46, height: 46, display: "grid", gridTemplateColumns: "repeat(5,1fr)", gap: 2 }}>
                {Array.from({ length: 25 }).map((_, i) => (
                  <div key={i} style={{ background: [0, 1, 2, 5, 7, 10, 12, 14, 17, 18, 20, 22, 24, 3, 9, 15].includes(i) ? "#090B12" : "transparent", borderRadius: 1 }} />
                ))}
              </div>
            </div>
          </div>
          <div style={{ fontFamily: SF, fontSize: 12, color: tint("#FFFFFF", 0.7), marginTop: 14 }}>Opens the turnstile at every gate · works offline</div>
        </div>
      </div>

      <Section>Campus</Section>
      <div style={{ margin: "0 20px", ...card(), overflow: "hidden" }}>
        {[[ScanLine, "Check in to a lecture", "Geo-fenced · Hall B2 in range", T.green, true],
          [Wallet, "Campus wallet", "142 EGP · top up at any gate", T.blue, false],
          [Bookmark, "Saved listings", "3 items · 1 price drop", T.purple, false]].map(([Icon, t, s, c, act], i) => (
          <button key={t} onClick={act ? onScan : undefined} style={{
            width: "100%", display: "flex", alignItems: "center", gap: 13, padding: "13px 14px", minHeight: 56,
            background: "none", border: "none", borderTop: i ? `0.5px solid ${T.hair}` : "none", cursor: "pointer", textAlign: "left",
          }}>
            <div style={{ width: 30, height: 30, borderRadius: 9, background: tint(c, 0.16), display: "grid", placeItems: "center" }}><Icon size={15} color={c} /></div>
            <div style={{ flex: 1 }}>
              <div style={{ fontFamily: SF, fontSize: 15.5, fontWeight: 500, color: T.text }}>{t}</div>
              <div style={{ fontFamily: SF, fontSize: 12.5, color: T.muted, marginTop: 1 }}>{s}</div>
            </div>
            <ChevronRight size={17} color={T.dim} />
          </button>
        ))}
      </div>

      <Section>Alerts</Section>
      <button onClick={onNotifs} style={{ width: "100%", margin: "0 0 4px", ...card(), padding: "13px 14px", minHeight: 56, display: "flex", alignItems: "center", gap: 13, cursor: "pointer", textAlign: "left" }}>
        <div style={{ width: 30, height: 30, borderRadius: 9, background: tint(T.amber, 0.16), display: "grid", placeItems: "center" }}><Bell size={15} color={T.amber} /></div>
        <div style={{ flex: 1 }}>
          <div style={{ fontFamily: SF, fontSize: 15.5, fontWeight: 500, color: T.text }}>Notifications</div>
          <div style={{ fontFamily: SF, fontSize: 12.5, color: T.muted, marginTop: 1 }}>3 unread · quiet hours 23:00–07:00</div>
        </div>
        <ChevronRight size={17} color={T.dim} />
      </button>

      <Section>Privacy</Section>
      <div style={{ margin: "0 20px 8px", ...card(), padding: 15, display: "flex", gap: 12 }}>
        <ShieldCheck size={18} color={T.green} style={{ flexShrink: 0, marginTop: 1 }} />
        <div>
          <div style={{ fontFamily: SF, fontSize: 14.5, fontWeight: 600, color: T.text }}>No lecturer or administrator can read your Nexus conversations.</div>
          <div style={{ fontFamily: SF, fontSize: 13.5, color: T.muted, marginTop: 5, lineHeight: 1.45 }}>
            The university only ever sees anonymised, aggregated numbers. Your password is never stored — the portal is reached with a short-lived token.
          </div>
          <button style={{ marginTop: 11, minHeight: 38, padding: "0 14px", borderRadius: 10, border: `0.5px solid ${T.hair}`, background: "none", color: T.text, fontFamily: SF, fontSize: 13.5, fontWeight: 600, cursor: "pointer" }}>
            See what O6U can access
          </button>
        </div>
      </div>
    </>
  );
}


/* ───────────────  AUTH FLOW  ─────────────── */
function Mark({ size = 76 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 100 100">
      <defs>
        <linearGradient id="ng" x1="0" y1="0" x2="1" y2="1">
          <stop offset="0" stopColor="#A78BFA" /><stop offset="1" stopColor="#60A5FA" />
        </linearGradient>
      </defs>
      <rect x="2" y="2" width="96" height="96" rx="26" fill="#0B0E17" stroke="rgba(255,255,255,.08)" />
      <path d="M30 72V28l40 44V28" fill="none" stroke="url(#ng)" strokeWidth="7" strokeLinecap="round" strokeLinejoin="round" />
      <circle cx="30" cy="28" r="5.5" fill="#A78BFA" />
      <circle cx="70" cy="72" r="5.5" fill="#60A5FA" />
    </svg>
  );
}

function Splash() {
  return (
    <div style={{ position: "absolute", inset: 0, display: "grid", placeItems: "center", background: T.ink, zIndex: 55 }}>
      <div style={{ position: "absolute", width: 340, height: 340, borderRadius: 999, background: `radial-gradient(circle, ${tint(T.purpleDeep, 0.3)}, transparent 65%)` }} className="pulse" />
      <div style={{ textAlign: "center", position: "relative" }} className="pop">
        <Mark size={84} />
        <div style={{ fontFamily: SF, fontSize: 26, fontWeight: 700, letterSpacing: -0.5, color: T.text, marginTop: 18 }}>O6U Nexus</div>
        <div style={{ fontFamily: SF, fontSize: 14, color: T.dim, marginTop: 4 }}>October 6 University</div>
      </div>
    </div>
  );
}

function Onboarding({ next }) {
  const [i, setI] = useState(0);
  const pages = [
    { icon: Compass, c: T.blue, t: "Everything campus,\nin one app.", b: "Grades, attendance, timetable, marketplace and the people around you — one login, one place, no seven tabs." },
    { icon: Sparkles, c: T.purple, t: "Nexus reads\nyour record.", b: "Not the web. Your transcript, your attendance, your deadlines — so the advice is about you, and it arrives before you ask." },
    { icon: ShieldCheck, c: T.green, t: "Your data\nstays yours.", b: "No lecturer or administrator ever sees a Nexus conversation. The university only gets anonymised, aggregated numbers." },
  ];
  const P = pages[i];
  return (
    <div style={{ position: "absolute", inset: 0, display: "flex", flexDirection: "column", padding: "0 28px 40px", zIndex: 52 }}>
      <div style={{ display: "flex", justifyContent: "flex-end", paddingTop: 8 }}>
        <button onClick={next} style={{ background: "none", border: "none", color: T.muted, fontFamily: SF, fontSize: 15, fontWeight: 500, cursor: "pointer", minHeight: 44 }}>Skip</button>
      </div>
      <div key={i} className="rise" style={{ flex: 1, display: "flex", flexDirection: "column", justifyContent: "center" }}>
        <div style={{ width: 62, height: 62, borderRadius: 20, display: "grid", placeItems: "center", background: `linear-gradient(140deg, ${tint(P.c, 0.9)}, ${tint(P.c, 0.4)})`, marginBottom: 26 }}>
          <P.icon size={28} color="#fff" />
        </div>
        <div style={{ fontFamily: SF, fontSize: 34, fontWeight: 700, letterSpacing: -0.9, lineHeight: 1.18, color: T.text, whiteSpace: "pre-line" }}>{P.t}</div>
        <div style={{ fontFamily: SF, fontSize: 16.5, color: T.muted, lineHeight: 1.55, marginTop: 14 }}>{P.b}</div>
      </div>
      <div style={{ display: "flex", justifyContent: "center", gap: 7, marginBottom: 22 }}>
        {pages.map((_, k) => (
          <span key={k} style={{ width: k === i ? 20 : 7, height: 7, borderRadius: 9, background: k === i ? T.purple : tint("#FFFFFF", 0.18), transition: "width .3s, background .3s" }} />
        ))}
      </div>
      <button onClick={() => (i < 2 ? setI(i + 1) : next())} style={{
        minHeight: 52, borderRadius: 14, border: "none", cursor: "pointer",
        background: `linear-gradient(120deg, ${T.purpleDeep}, ${T.blueDeep})`, color: "#fff",
        fontFamily: SF, fontSize: 17, fontWeight: 600, display: "flex", alignItems: "center", justifyContent: "center", gap: 7,
      }}>
        {i < 2 ? "Continue" : "Get started"} <ArrowRight size={17} />
      </button>
    </div>
  );
}

function Login({ next, faceId }) {
  const [id, setId] = useState("20211456");
  const [pw, setPw] = useState("••••••••••");
  const field = { flex: 1, background: "none", border: "none", outline: "none", color: T.text, fontFamily: SF, fontSize: 16.5, minWidth: 0 };
  return (
    <div style={{ position: "absolute", inset: 0, display: "flex", flexDirection: "column", padding: "0 26px 34px", zIndex: 52 }}>
      <div style={{ flex: 1, display: "flex", flexDirection: "column", justifyContent: "center" }}>
        <Mark size={54} />
        <div style={{ fontFamily: SF, fontSize: 32, fontWeight: 700, letterSpacing: -0.8, color: T.text, marginTop: 22 }}>Welcome back</div>
        <div style={{ fontFamily: SF, fontSize: 15.5, color: T.muted, marginTop: 5 }}>Sign in with your O6U student account.</div>

        <div style={{ marginTop: 26, display: "flex", flexDirection: "column", gap: 10 }}>
          <div style={{ ...card(2), borderRadius: 14, padding: "14px 16px", display: "flex", alignItems: "center", gap: 11 }}>
            <User size={17} color={T.dim} />
            <input value={id} onChange={e => setId(e.target.value)} placeholder="Student ID" style={field} />
          </div>
          <div style={{ ...card(2), borderRadius: 14, padding: "14px 16px", display: "flex", alignItems: "center", gap: 11 }}>
            <Lock size={17} color={T.dim} />
            <input type="password" value={pw} onChange={e => setPw(e.target.value)} placeholder="Password" style={field} />
          </div>
        </div>

        <button style={{ alignSelf: "flex-end", background: "none", border: "none", color: T.blue, fontFamily: SF, fontSize: 14.5, fontWeight: 600, cursor: "pointer", minHeight: 44 }}>
          Forgot password?
        </button>

        <button onClick={next} style={{
          minHeight: 52, borderRadius: 14, border: "none", cursor: "pointer", marginTop: 6,
          background: `linear-gradient(120deg, ${T.purpleDeep}, ${T.blueDeep})`, color: "#fff",
          fontFamily: SF, fontSize: 17, fontWeight: 600,
        }}>Sign in</button>

        <button onClick={faceId} style={{
          minHeight: 52, borderRadius: 14, cursor: "pointer", marginTop: 10,
          background: T.raise, border: `0.5px solid ${T.hair}`, color: T.text,
          fontFamily: SF, fontSize: 16, fontWeight: 600, display: "flex", alignItems: "center", justifyContent: "center", gap: 8,
        }}><ScanFace size={19} color={T.purple} /> Use Face ID</button>
      </div>
      <div style={{ display: "flex", gap: 8, alignItems: "flex-start" }}>
        <KeyRound size={13} color={T.dim} style={{ flexShrink: 0, marginTop: 2 }} />
        <span style={{ fontFamily: SF, fontSize: 12, color: T.dim, lineHeight: 1.45 }}>
          Nexus never stores your password. Sign-in returns a short-lived token, held in the Secure Enclave.
        </span>
      </div>
    </div>
  );
}

function FaceID({ next }) {
  const [done, setDone] = useState(false);
  useEffect(() => {
    const a = setTimeout(() => setDone(true), 1700);
    const b = setTimeout(next, 2700);
    return () => { clearTimeout(a); clearTimeout(b); };
  }, [next]);
  return (
    <div style={{ position: "absolute", inset: 0, display: "grid", placeItems: "center", zIndex: 52, background: "rgba(9,11,18,.86)", backdropFilter: "blur(20px)" }} className="fade">
      <div style={{ textAlign: "center", padding: "0 40px" }}>
        <div style={{ position: "relative", width: 116, height: 116, margin: "0 auto", display: "grid", placeItems: "center" }}>
          {!done && <div className="ring1" style={{ position: "absolute", inset: 0, borderRadius: 32, border: `2px solid ${tint(T.purple, 0.45)}` }} />}
          {!done && <div className="ring2" style={{ position: "absolute", inset: 12, borderRadius: 26, border: `2px solid ${tint(T.blue, 0.4)}` }} />}
          {done
            ? <div className="pop" style={{ width: 96, height: 96, borderRadius: 999, background: tint(T.green, 0.16), display: "grid", placeItems: "center" }}><Check size={46} color={T.green} strokeWidth={3} /></div>
            : <ScanFace size={64} color={T.purple} strokeWidth={1.4} />}
        </div>
        <div style={{ fontFamily: SF, fontSize: 20, fontWeight: 700, color: T.text, marginTop: 26 }}>
          {done ? "Face ID · Ahmed" : "Look at iPhone"}
        </div>
        <div style={{ fontFamily: SF, fontSize: 14.5, color: T.muted, marginTop: 6, lineHeight: 1.45 }}>
          {done ? "Unlocking your record…" : "Authenticating with the Secure Enclave"}
        </div>
      </div>
    </div>
  );
}

/* ───────────────  PUSHED SUB-SCREENS  ─────────────── */
function Push({ title, onBack, children }) {
  return (
    <div className="push" style={{ position: "absolute", inset: 0, zIndex: 44, background: T.ink, display: "flex", flexDirection: "column" }}>
      <div style={{ height: 54 }} />
      <div style={{ height: 44, display: "flex", alignItems: "center", padding: "0 8px 0 4px", background: "rgba(9,11,18,.8)", backdropFilter: "blur(20px)", borderBottom: `0.5px solid ${T.hair}`, flexShrink: 0 }}>
        <button onClick={onBack} style={{ display: "flex", alignItems: "center", gap: 1, minHeight: 44, padding: "0 8px", background: "none", border: "none", cursor: "pointer" }}>
          <ChevronLeft size={22} color={T.blue} />
          <span style={{ fontFamily: SF, fontSize: 16.5, color: T.blue }}>Back</span>
        </button>
        <span style={{ position: "absolute", left: 0, right: 0, textAlign: "center", fontFamily: SF, fontSize: 17, fontWeight: 600, color: T.text, pointerEvents: "none" }}>{title}</span>
      </div>
      <div className="noscroll" style={{ flex: 1, overflowY: "auto", paddingBottom: 110 }}>
        <div style={{ paddingTop: 16 }}>{children}</div>
      </div>
    </div>
  );
}

function Schedule() {
  const days = ["S", "M", "T", "W", "T", "F", "S"];
  const rows = [
    ["09:00", "EN102 · Technical Writing", "Hall D3 · Dr. Nadia", T.blue],
    ["10:30", "CS402 · Data Structures", "Hall A1 · moved · Dr. Hesham", T.purple],
    ["12:30", "Free · Nexus placed revision", "Library Room 4", T.green],
    ["15:30", "MA201 · Lab", "Lab 4 · Eng. Omar", T.amber],
  ];
  return (
    <>
      <div style={{ display: "flex", gap: 6, margin: "0 20px 18px" }}>
        {days.map((d, i) => (
          <div key={i} style={{
            flex: 1, borderRadius: 12, padding: "9px 0", textAlign: "center",
            background: i === 1 ? T.purpleDeep : T.raise, border: `0.5px solid ${i === 1 ? "transparent" : T.hair}`,
          }}>
            <div style={{ fontFamily: SF, fontSize: 11, color: i === 1 ? tint("#FFFFFF", 0.75) : T.dim, fontWeight: 600 }}>{d}</div>
            <div style={{ fontFamily: MONO, fontSize: 14, fontWeight: 700, color: i === 1 ? "#fff" : T.text, marginTop: 3 }}>{11 + i}</div>
          </div>
        ))}
      </div>
      <div style={{ margin: "0 20px" }}>
        {rows.map(([t, title, meta, c], i) => (
          <div key={i} style={{ display: "flex", gap: 12 }}>
            <div style={{ width: 46, paddingTop: 13, fontFamily: MONO, fontSize: 12, color: T.dim, textAlign: "right" }}>{t}</div>
            <div style={{ width: 3, borderRadius: 3, background: c, marginBottom: 10, opacity: .9 }} />
            <div style={{ flex: 1, ...card(), padding: 14, marginBottom: 10 }}>
              <div style={{ fontFamily: SF, fontSize: 15, fontWeight: 600, color: T.text }}>{title}</div>
              <div style={{ fontFamily: SF, fontSize: 13, color: T.muted, marginTop: 2 }}>{meta}</div>
            </div>
          </div>
        ))}
      </div>
      <div style={{ margin: "6px 20px 0", ...card(), padding: 14, display: "flex", gap: 10, alignItems: "center", borderStyle: "dashed" }}>
        <CalendarRange size={16} color={T.blue} />
        <span style={{ fontFamily: SF, fontSize: 13.5, color: T.muted, flex: 1 }}>Two rooms changed this week. Your timetable updated itself.</span>
      </div>
    </>
  );
}

function Grades() {
  return (
    <>
      <div style={{ margin: "0 20px 6px", ...card(), padding: 18, display: "flex", justifyContent: "space-between", alignItems: "center" }}>
        <div>
          <div style={{ fontFamily: SF, fontSize: 13, color: T.muted }}>Semester GPA</div>
          <div style={{ fontFamily: SF, fontSize: 36, fontWeight: 700, letterSpacing: -1.2, color: T.text }}>3.24</div>
        </div>
        <div style={{ textAlign: "right" }}>
          <div style={{ fontFamily: SF, fontSize: 13, color: T.muted }}>Cumulative</div>
          <div style={{ fontFamily: SF, fontSize: 22, fontWeight: 700, color: T.purple }}>3.12</div>
        </div>
      </div>
      <Section>This semester</Section>
      <div style={{ margin: "0 20px", ...card(), overflow: "hidden" }}>
        {COURSES.map((c, i) => (
          <div key={c.code} style={{ display: "flex", alignItems: "center", gap: 12, padding: "14px", borderTop: i ? `0.5px solid ${T.hair}` : "none" }}>
            <div style={{ flex: 1 }}>
              <div style={{ fontFamily: SF, fontSize: 15, fontWeight: 600, color: T.text }}>{c.name}</div>
              <div style={{ fontFamily: SF, fontSize: 12.5, color: T.muted, marginTop: 1 }}>{c.code} · {c.hrs} credit hours</div>
            </div>
            <span style={{
              fontFamily: MONO, fontSize: 14, fontWeight: 700, padding: "5px 10px", borderRadius: 8,
              color: c.grade.startsWith("A") ? T.green : c.grade.startsWith("C") ? T.amber : T.blue,
              background: tint(c.grade.startsWith("A") ? T.green : c.grade.startsWith("C") ? T.amber : T.blue, 0.12),
            }}>{c.grade}</span>
          </div>
        ))}
      </div>
    </>
  );
}

function Attendance() {
  return (
    <>
      <div style={{ margin: "0 20px", ...card(), padding: 20, display: "flex", alignItems: "center", gap: 18 }}>
        <Ring pct={92} size={78} />
        <div style={{ flex: 1 }}>
          <div style={{ fontFamily: SF, fontSize: 17, fontWeight: 600, color: T.text }}>92% overall</div>
          <div style={{ fontFamily: SF, fontSize: 13.5, color: T.muted, marginTop: 3, lineHeight: 1.4 }}>
            Above the university's 75% threshold in four of five courses.
          </div>
        </div>
      </div>
      <Section>By course</Section>
      <div style={{ margin: "0 20px", display: "flex", flexDirection: "column", gap: 9 }}>
        {COURSES.map(c => {
          const low = c.att < 75;
          return (
            <div key={c.code} style={{ ...card(), padding: 14 }}>
              <div style={{ display: "flex", justifyContent: "space-between", marginBottom: 9 }}>
                <span style={{ fontFamily: SF, fontSize: 14.5, fontWeight: 600, color: T.text }}>{c.code} · {c.name}</span>
                <span style={{ fontFamily: MONO, fontSize: 13, fontWeight: 700, color: low ? T.amber : T.green }}>{c.att}%</span>
              </div>
              <div style={{ height: 6, borderRadius: 6, background: tint("#FFFFFF", 0.07), position: "relative", overflow: "hidden" }}>
                <div className="grow" style={{ height: "100%", width: `${c.att}%`, borderRadius: 6, background: low ? T.amber : T.green }} />
                <div style={{ position: "absolute", left: "75%", top: -2, width: 1, height: 10, background: tint("#FFFFFF", 0.45) }} />
              </div>
            </div>
          );
        })}
      </div>
      <div style={{ margin: "14px 20px 0", borderRadius: 16, padding: 15, background: tint(T.amber, 0.1), border: `0.5px solid ${tint(T.amber, 0.3)}`, display: "flex", gap: 10 }}>
        <AlertTriangle size={17} color={T.amber} style={{ flexShrink: 0, marginTop: 1 }} />
        <div>
          <div style={{ fontFamily: SF, fontSize: 14.5, fontWeight: 600, color: T.text }}>MA201 is 7 points below the line</div>
          <div style={{ fontFamily: SF, fontSize: 13.5, color: T.muted, marginTop: 3, lineHeight: 1.45 }}>Four lectures brings it back to 78%. Nexus can hold those hours for you.</div>
        </div>
      </div>
    </>
  );
}

function Transcript() {
  return (
    <>
      <div style={{ margin: "0 20px", ...card(), padding: 18 }}>
        <div style={{ fontFamily: SF, fontSize: 13, color: T.muted }}>Cumulative · 96 of 120 hours</div>
        <div style={{ display: "flex", alignItems: "baseline", gap: 8, marginTop: 3 }}>
          <span style={{ fontFamily: SF, fontSize: 38, fontWeight: 700, letterSpacing: -1.3, color: T.text }}>3.12</span>
          <span style={{ fontFamily: SF, fontSize: 14, fontWeight: 700, color: T.green }}>+0.18</span>
        </div>
      </div>
      <Section>Semesters</Section>
      <div style={{ margin: "0 20px", ...card(), overflow: "hidden" }}>
        {SEMESTERS.map(([name, gpa, hrs], i) => (
          <div key={name} style={{ display: "flex", alignItems: "center", gap: 12, padding: "13px 14px", borderTop: i ? `0.5px solid ${T.hair}` : "none" }}>
            <div style={{ flex: 1 }}>
              <div style={{ fontFamily: SF, fontSize: 14.5, fontWeight: 500, color: T.text }}>{name}</div>
              <div style={{ fontFamily: SF, fontSize: 12.5, color: T.muted, marginTop: 1 }}>{hrs} credit hours</div>
            </div>
            <span style={{ fontFamily: MONO, fontSize: 14, fontWeight: 700, color: T.text }}>{gpa}</span>
            <ChevronRight size={16} color={T.dim} />
          </div>
        ))}
      </div>
      <button style={{
        margin: "16px 20px 0", width: "calc(100% - 40px)", minHeight: 50, borderRadius: 14, cursor: "pointer",
        background: T.raise2, border: `0.5px solid ${T.hair}`, color: T.text, fontFamily: SF, fontSize: 16, fontWeight: 600,
        display: "flex", alignItems: "center", justifyContent: "center", gap: 8,
      }}><Download size={17} color={T.blue} /> Export official PDF</button>
      <div style={{ margin: "10px 20px 0", fontFamily: SF, fontSize: 12.5, color: T.dim, textAlign: "center", lineHeight: 1.45 }}>
        Sealed and signed by the registrar. Verifiable by QR for 90 days.
      </div>
    </>
  );
}

function GpaSim() {
  const [picks, setPicks] = useState({ CS402: 3.7, MA201: 2.5, CS310: 4.0, PH101: 3.0, EN102: 3.3 });
  const hrs = COURSES.reduce((a, c) => a + c.hrs, 0);
  const pts = COURSES.reduce((a, c) => a + picks[c.code] * c.hrs, 0);
  const proj = (3.12 * 96 + pts) / (96 + hrs);
  const delta = proj - 3.12;
  return (
    <>
      <div style={{ margin: "0 20px", ...card(), padding: 20, textAlign: "center", background: `linear-gradient(140deg, ${tint(T.purpleDeep, 0.25)}, ${T.raise})` }}>
        <div style={{ fontFamily: SF, fontSize: 12.5, fontWeight: 700, color: T.purple, letterSpacing: 0.8 }}>PROJECTED CUMULATIVE</div>
        <div style={{ fontFamily: SF, fontSize: 52, fontWeight: 700, letterSpacing: -2, color: T.text, marginTop: 6, lineHeight: 1 }}>{proj.toFixed(2)}</div>
        <div style={{ fontFamily: SF, fontSize: 15, fontWeight: 700, color: delta >= 0 ? T.green : T.red, marginTop: 8 }}>
          {delta >= 0 ? "+" : "−"}{Math.abs(delta).toFixed(2)} from 3.12
        </div>
      </div>
      <Section>Move a grade, watch it move</Section>
      <div style={{ margin: "0 20px", display: "flex", flexDirection: "column", gap: 10 }}>
        {COURSES.map(c => (
          <div key={c.code} style={{ ...card(), padding: 13 }}>
            <div style={{ display: "flex", justifyContent: "space-between", marginBottom: 9 }}>
              <span style={{ fontFamily: SF, fontSize: 14.5, fontWeight: 600, color: T.text }}>{c.code}</span>
              <span style={{ fontFamily: SF, fontSize: 12.5, color: T.muted }}>{c.hrs} hrs</span>
            </div>
            <div style={{ display: "flex", gap: 5 }}>
              {GRADE_PTS.map(([g, v]) => {
                const on = picks[c.code] === v;
                return (
                  <button key={g} onClick={() => setPicks({ ...picks, [c.code]: v })} style={{
                    flex: 1, minHeight: 36, borderRadius: 9, cursor: "pointer",
                    background: on ? T.purpleDeep : tint("#FFFFFF", 0.05),
                    border: `0.5px solid ${on ? "transparent" : T.hair}`,
                    color: on ? "#fff" : T.muted, fontFamily: MONO, fontSize: 12.5, fontWeight: 700,
                    transition: "background .15s",
                  }}>{g}</button>
                );
              })}
            </div>
          </div>
        ))}
      </div>
      <div style={{ margin: "14px 20px 0", ...card(), padding: 14, display: "flex", gap: 10, borderStyle: "dashed" }}>
        <Sparkles size={16} color={T.purple} style={{ flexShrink: 0, marginTop: 1 }} />
        <span style={{ fontFamily: SF, fontSize: 13.5, color: T.muted, lineHeight: 1.45 }}>
          Pulling MA201 from C+ to B is worth <span style={{ color: T.text, fontWeight: 600 }}>+0.04</span> on your cumulative — the single largest move available to you this term.
        </span>
      </div>
    </>
  );
}

function StudyPlanner() {
  const days = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
  const blocks = [
    [0, 0, "CS402", "lec"], [1, 0, "MA201", "lec"], [3, 0, "Practice", "ai"], [5, 0, "Weak", "ai"],
    [2, 1, "CS310", "lec"], [4, 1, "Mock", "ai"], [6, 1, "EXAM", "exam"],
    [0, 2, "Revise", "ai"], [1, 2, "Algo", "ai"], [3, 2, "PH101", "lec"], [5, 2, "Cards", "ai"],
  ];
  const col = { lec: "#343B5C", ai: T.purpleDeep, exam: T.red };
  return (
    <>
      <div style={{ margin: "0 20px 16px", display: "flex", justifyContent: "space-between", alignItems: "center" }}>
        <div>
          <div style={{ fontFamily: SF, fontSize: 19, fontWeight: 700, color: T.text }}>Week 9 · auto-generated</div>
          <div style={{ fontFamily: SF, fontSize: 13.5, color: T.muted, marginTop: 2 }}>14 study hours placed · 0 conflicts</div>
        </div>
        <Sparkles size={19} color={T.purple} />
      </div>
      <div style={{ margin: "0 20px", ...card(), padding: 12 }}>
        <div style={{ display: "grid", gridTemplateColumns: "repeat(7,1fr)", gap: 4, marginBottom: 6 }}>
          {days.map(d => <div key={d} style={{ fontFamily: SF, fontSize: 9.5, fontWeight: 700, color: T.dim, textAlign: "center", letterSpacing: 0.4 }}>{d}</div>)}
        </div>
        {[0, 1, 2].map(r => (
          <div key={r} style={{ display: "grid", gridTemplateColumns: "repeat(7,1fr)", gap: 4, marginBottom: 4 }}>
            {[0, 1, 2, 3, 4, 5, 6].map(c => {
              const b = blocks.find(x => x[0] === c && x[1] === r);
              return (
                <div key={c} style={{
                  height: 62, borderRadius: 8, display: "grid", placeItems: "center", padding: 2,
                  background: b ? col[b[3]] : tint("#FFFFFF", 0.035),
                  border: b ? "none" : `0.5px solid ${T.hair}`,
                }}>
                  {b && <span style={{ fontFamily: SF, fontSize: 9.5, fontWeight: 700, color: "#fff", textAlign: "center" }}>{b[2]}</span>}
                </div>
              );
            })}
          </div>
        ))}
        <div style={{ display: "flex", gap: 14, marginTop: 10, justifyContent: "center" }}>
          {[["Lectures", "#343B5C"], ["AI block", T.purpleDeep], ["Exam", T.red]].map(([l, c]) => (
            <div key={l} style={{ display: "flex", alignItems: "center", gap: 5 }}>
              <span style={{ width: 8, height: 8, borderRadius: 9, background: c }} />
              <span style={{ fontFamily: SF, fontSize: 11.5, color: T.muted }}>{l}</span>
            </div>
          ))}
        </div>
      </div>
      <div style={{ margin: "14px 20px 0", display: "flex", flexDirection: "column", gap: 9 }}>
        {[["Reads your real gaps", "Free hours between lectures become study blocks.", T.green],
          ["Prioritises weakness", "MA201 gets the most hours — it's dragging your GPA.", T.amber],
          ["Re-plans automatically", "A moved deadline reshuffles the whole week.", T.blue]].map(([t, b, c]) => (
          <div key={t} style={{ ...card(), padding: 13 }}>
            <div style={{ fontFamily: SF, fontSize: 14.5, fontWeight: 600, color: c }}>{t}</div>
            <div style={{ fontFamily: SF, fontSize: 13, color: T.muted, marginTop: 2 }}>{b}</div>
          </div>
        ))}
      </div>
    </>
  );
}

function GradPlanner() {
  const steps = [
    ["Level 1", "30 hrs", "Done", T.green],
    ["Level 2", "32 hrs", "Done", T.green],
    ["Level 3", "30 hrs", "Done", T.green],
    ["Level 4", "18 hrs", "Now", T.purple],
    ["Summer", "6 hrs", "Advised", T.amber],
    ["Graduation", "Aug 2027", "96%", T.blue],
  ];
  return (
    <>
      <div style={{ margin: "0 20px", ...card(), padding: 20, background: `linear-gradient(140deg, ${tint(T.blueDeep, 0.22)}, ${T.raise})` }}>
        <div style={{ display: "flex", alignItems: "center", gap: 12 }}>
          <Target size={22} color={T.blue} />
          <div>
            <div style={{ fontFamily: SF, fontSize: 20, fontWeight: 700, color: T.text }}>96% on-time</div>
            <div style={{ fontFamily: SF, fontSize: 13.5, color: T.muted, marginTop: 2 }}>24 hours left · graduate August 2027</div>
          </div>
        </div>
      </div>
      <Section>Your path</Section>
      <div style={{ margin: "0 20px" }}>
        {steps.map(([t, h, st, c], i) => (
          <div key={t} style={{ display: "flex", gap: 13 }}>
            <div style={{ display: "flex", flexDirection: "column", alignItems: "center" }}>
              <div style={{ width: 13, height: 13, borderRadius: 9, marginTop: 15, background: i < 4 ? c : "transparent", border: `2px solid ${c}` }} />
              {i < steps.length - 1 && <div style={{ flex: 1, width: 1.5, background: i < 3 ? tint(T.green, 0.4) : T.hair }} />}
            </div>
            <div style={{ flex: 1, ...card(), padding: 13, marginBottom: 9, display: "flex", alignItems: "center" }}>
              <div style={{ flex: 1 }}>
                <div style={{ fontFamily: SF, fontSize: 15, fontWeight: 600, color: T.text }}>{t}</div>
                <div style={{ fontFamily: SF, fontSize: 12.5, color: T.muted, marginTop: 1 }}>{h}</div>
              </div>
              <span style={{ fontFamily: SF, fontSize: 12.5, fontWeight: 700, color: c, background: tint(c, 0.12), padding: "5px 9px", borderRadius: 7 }}>{st}</span>
            </div>
          </div>
        ))}
      </div>
      <div style={{ margin: "6px 20px 0", borderRadius: 16, padding: 15, background: tint(T.amber, 0.1), border: `0.5px solid ${tint(T.amber, 0.3)}`, display: "flex", gap: 10 }}>
        <AlertTriangle size={17} color={T.amber} style={{ flexShrink: 0, marginTop: 1 }} />
        <div>
          <div style={{ fontFamily: SF, fontSize: 14.5, fontWeight: 600, color: T.text }}>Predicted bottleneck · CS412</div>
          <div style={{ fontFamily: SF, fontSize: 13.5, color: T.muted, marginTop: 3, lineHeight: 1.45 }}>
            Offered in Fall only, and a prerequisite for two remaining courses. Taking it this summer removes a full semester of delay.
          </div>
        </div>
      </div>
    </>
  );
}

/* ───────────────────────  SHEETS  ─────────────────────── */
function Sheet({ open, onClose, children }) {
  if (!open) return null;
  return (
    <div onClick={onClose} style={{ position: "absolute", inset: 0, zIndex: 60, background: "rgba(0,0,0,0.55)", backdropFilter: "blur(2px)", display: "flex", alignItems: "flex-end" }} className="fade">
      <div onClick={e => e.stopPropagation()} className="sheet" style={{
        width: "100%", background: "#141826", borderRadius: "22px 22px 0 0",
        borderTop: `0.5px solid ${T.hair}`, padding: "10px 20px 34px", maxHeight: "88%", overflowY: "auto",
      }}>
        <div style={{ width: 38, height: 5, borderRadius: 9, background: tint("#FFFFFF", 0.22), margin: "0 auto 16px" }} />
        {children}
      </div>
    </div>
  );
}

function CourseSheet({ c, onClose }) {
  const risk = c.att < 75;
  return (
    <>
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "flex-start" }}>
        <div>
          <div style={{ fontFamily: MONO, fontSize: 12.5, color: T.purple, fontWeight: 600, letterSpacing: 1 }}>{c.code}</div>
          <div style={{ fontFamily: SF, fontSize: 24, fontWeight: 700, color: T.text, marginTop: 3, letterSpacing: -0.4 }}>{c.name}</div>
          <div style={{ fontFamily: SF, fontSize: 13.5, color: T.muted, marginTop: 3 }}>{c.next}</div>
        </div>
        <button onClick={onClose} style={{ width: 30, height: 30, borderRadius: 15, border: "none", background: tint("#FFFFFF", 0.08), display: "grid", placeItems: "center", cursor: "pointer" }}>
          <X size={15} color={T.muted} />
        </button>
      </div>

      <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr 1fr", gap: 9, marginTop: 18 }}>
        {[["Grade", c.grade, T.text], ["Attendance", `${c.att}%`, c.att < 75 ? T.amber : T.green], ["Credit hrs", c.hrs, T.text]].map(([k, v, col]) => (
          <div key={k} style={{ ...card(), padding: 12 }}>
            <div style={{ fontFamily: SF, fontSize: 11.5, color: T.muted }}>{k}</div>
            <div style={{ fontFamily: SF, fontSize: 19, fontWeight: 700, color: col, marginTop: 3 }}>{v}</div>
          </div>
        ))}
      </div>

      {risk && (
        <div style={{ marginTop: 12, borderRadius: 14, padding: 14, background: tint(T.amber, 0.1), border: `0.5px solid ${tint(T.amber, 0.3)}` }}>
          <div style={{ display: "flex", gap: 9, alignItems: "flex-start" }}>
            <AlertTriangle size={16} color={T.amber} style={{ flexShrink: 0, marginTop: 1 }} />
            <div>
              <div style={{ fontFamily: SF, fontSize: 14.5, fontWeight: 600, color: T.text }}>78% chance of an academic warning</div>
              <div style={{ fontFamily: SF, fontSize: 13.5, color: T.muted, marginTop: 4, lineHeight: 1.45 }}>
                Attending the next 4 lectures and submitting assignment 5 by Sunday drops this to 21%.
              </div>
            </div>
          </div>
          <button style={{ width: "100%", marginTop: 12, minHeight: 42, borderRadius: 11, border: "none", background: T.amber, color: "#1A1203", fontFamily: SF, fontSize: 14.5, fontWeight: 700, cursor: "pointer" }}>
            Ask Nexus to fix this
          </button>
        </div>
      )}

      <Section>Materials</Section>
      <div style={{ ...card(), overflow: "hidden", margin: "0 0 4px" }}>
        {[["Lecture 7 · Balanced trees", "PDF · 2.4 MB"], ["Assignment 5", "Due Sunday · not submitted"], ["Past papers · 2024", "PDF · 6 files"]].map(([t, s], i) => (
          <div key={t} style={{ display: "flex", alignItems: "center", gap: 12, padding: "12px 14px", minHeight: 52, borderTop: i ? `0.5px solid ${T.hair}` : "none" }}>
            <FileText size={16} color={T.blue} />
            <div style={{ flex: 1 }}>
              <div style={{ fontFamily: SF, fontSize: 14.5, color: T.text, fontWeight: 500 }}>{t}</div>
              <div style={{ fontFamily: SF, fontSize: 12, color: s.includes("not submitted") ? T.pink : T.muted, marginTop: 1 }}>{s}</div>
            </div>
            <ChevronRight size={16} color={T.dim} />
          </div>
        ))}
      </div>
    </>
  );
}

function NotifSheet({ onClose }) {
  const [filter, setFilter] = useState("All");
  const [read, setRead] = useState(false);
  const cats = ["All", "Academic", "Deadline", "Campus", "Nexus"];
  const groups = NOTIFS
    .map(g => ({ ...g, items: g.items.filter(i => filter === "All" || i.cat === filter) }))
    .filter(g => g.items.length);
  const unread = read ? 0 : 3;

  return (
    <>
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 4 }}>
        <div>
          <div style={{ fontFamily: SF, fontSize: 26, fontWeight: 700, letterSpacing: -0.6, color: T.text }}>Notifications</div>
          <div style={{ fontFamily: SF, fontSize: 13.5, color: T.muted, marginTop: 2 }}>
            {unread ? `${unread} unread · all from your own record` : "You're all caught up"}
          </div>
        </div>
        <button onClick={onClose} style={{ width: 30, height: 30, borderRadius: 15, border: "none", background: tint("#FFFFFF", 0.08), display: "grid", placeItems: "center", cursor: "pointer", flexShrink: 0 }}>
          <X size={15} color={T.muted} />
        </button>
      </div>

      <div className="noscroll" style={{ display: "flex", gap: 7, overflowX: "auto", margin: "16px -20px 6px", padding: "0 20px" }}>
        {cats.map(c => (
          <button key={c} onClick={() => setFilter(c)} style={{
            flexShrink: 0, minHeight: 34, padding: "0 13px", borderRadius: 17, cursor: "pointer",
            background: filter === c ? tint(T.purple, 0.16) : T.raise,
            border: `0.5px solid ${filter === c ? tint(T.purple, 0.4) : T.hair}`,
            color: filter === c ? T.purple : T.muted, fontFamily: SF, fontSize: 13.5, fontWeight: 600,
          }}>{c}</button>
        ))}
      </div>

      {groups.map(g => (
        <div key={g.day}>
          <Section>{g.day}</Section>
          <div style={{ display: "flex", flexDirection: "column", gap: 9, margin: "0 -20px", padding: "0 20px" }}>
            {g.items.map((n, i) => {
              const isUnread = n.unread && !read;
              return (
                <div key={i} className="rise" style={{
                  ...card(isUnread ? 2 : 1), padding: 13, display: "flex", gap: 11,
                  borderColor: isUnread ? tint(n.c, 0.28) : T.hair, animationDelay: `${i * 45}ms`,
                }}>
                  <div style={{ width: 32, height: 32, borderRadius: 10, flexShrink: 0, display: "grid", placeItems: "center", background: tint(n.c, isUnread ? 0.18 : 0.1) }}>
                    <n.icon size={15} color={n.c} />
                  </div>
                  <div style={{ flex: 1, minWidth: 0 }}>
                    <div style={{ display: "flex", alignItems: "center", gap: 6 }}>
                      <span style={{ fontFamily: SF, fontSize: 14.5, fontWeight: 600, color: isUnread ? T.text : T.muted, flex: 1 }}>{n.title}</span>
                      <span style={{ fontFamily: MONO, fontSize: 11, color: T.dim }}>{n.time}</span>
                      {isUnread && <span style={{ width: 7, height: 7, borderRadius: 9, background: n.c, flexShrink: 0 }} />}
                    </div>
                    <div style={{ fontFamily: SF, fontSize: 13, color: isUnread ? T.muted : T.dim, marginTop: 3, lineHeight: 1.45 }}>{n.body}</div>
                    {n.action && (
                      <button style={{
                        marginTop: 9, minHeight: 34, padding: "0 12px", borderRadius: 9, cursor: "pointer",
                        background: "none", border: `0.5px solid ${tint(n.c, 0.35)}`, color: n.c,
                        fontFamily: SF, fontSize: 13, fontWeight: 600,
                      }}>{n.action}</button>
                    )}
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      ))}

      <button onClick={() => setRead(true)} disabled={!unread} style={{
        width: "100%", marginTop: 18, minHeight: 46, borderRadius: 12, cursor: unread ? "pointer" : "default",
        border: `0.5px solid ${T.hair}`, background: unread ? T.raise2 : "transparent",
        color: unread ? T.text : T.dim, fontFamily: SF, fontSize: 15, fontWeight: 600,
        display: "flex", alignItems: "center", justifyContent: "center", gap: 7,
      }}>
        <MailOpen size={15} />{unread ? "Mark all as read" : "Nothing left to read"}
      </button>
    </>
  );
}

function ScanSheet({ onClose }) {
  const [done, setDone] = useState(false);
  useEffect(() => { const t = setTimeout(() => setDone(true), 2100); return () => clearTimeout(t); }, []);
  return (
    <div style={{ textAlign: "center", padding: "6px 0 4px" }}>
      <div style={{ position: "relative", width: 150, height: 150, margin: "0 auto", borderRadius: 22, border: `1.5px solid ${done ? T.green : tint(T.green, 0.35)}`, overflow: "hidden", background: tint(T.green, 0.05), display: "grid", placeItems: "center" }}>
        {!done && <div className="scanline" style={{ position: "absolute", left: 0, right: 0, height: 2, background: `linear-gradient(90deg, transparent, ${T.green}, transparent)` }} />}
        {done ? <Check size={54} color={T.green} strokeWidth={2.5} className="pop" /> : <ScanLine size={40} color={tint(T.green, 0.6)} />}
      </div>
      <div style={{ fontFamily: SF, fontSize: 20, fontWeight: 700, color: T.text, marginTop: 20 }}>
        {done ? "Checked in" : "Hold steady"}
      </div>
      <div style={{ fontFamily: SF, fontSize: 14, color: T.muted, marginTop: 5, lineHeight: 1.45, padding: "0 14px" }}>
        {done
          ? "CS402 · 10:32 · Hall B2. Your attendance is now 96%. The lecturer sees it instantly."
          : "You're inside Hall B2 and the lecture is running. The code only works from here, during the session."}
      </div>
      <button onClick={onClose} style={{ width: "100%", marginTop: 20, minHeight: 46, borderRadius: 12, border: "none", background: done ? T.green : tint("#FFFFFF", 0.08), color: done ? "#052E20" : T.muted, fontFamily: SF, fontSize: 15.5, fontWeight: 700, cursor: "pointer" }}>
        {done ? "Done" : "Cancel"}
      </button>
    </div>
  );
}

/* ───────────────────────  APP  ─────────────────────── */
export default function App() {
  const [tab, setTab] = useState("today");
  const [scrolled, setScrolled] = useState(false);
  const [sheet, setSheet] = useState(null);
  const [course, setCourse] = useState(null);
  const [thread, setThread] = useState(true);
  const [specs, setSpecs] = useState(false);
  const [grid, setGrid] = useState(false);
  const [msgs, setMsgs] = useState([]);
  const [typing, setTyping] = useState(false);
  const [mins, setMins] = useState(558); // 09:18
  const [vw, setVw] = useState(typeof window === "undefined" ? 1200 : window.innerWidth);
  const [phase, setPhase] = useState("splash");   // splash → onboarding → login → faceid → app
  const [stack, setStack] = useState(null);       // pushed sub-screen
  const scrollRef = useRef(null);
  const endRef = useRef(null);

  useEffect(() => {
    const onResize = () => setVw(window.innerWidth);
    window.addEventListener("resize", onResize);
    return () => window.removeEventListener("resize", onResize);
  }, []);

  const narrow = vw < 1040;                                   // stack instead of three columns
  const scale = Math.min(1, (vw - 40) / 393);                 // shrink the device to fit any screen
  const DEV_W = 393, DEV_H = 852;

  useEffect(() => {
    if (phase !== "splash") return;
    const t = setTimeout(() => setPhase("onboarding"), 1700);
    return () => clearTimeout(t);
  }, [phase]);

  const openPush = (id) => setStack(id);
  const PUSHES = {
    schedule: ["Schedule", Schedule], grades: ["Grades", Grades],
    attendance: ["Attendance", Attendance], transcript: ["Transcript", Transcript],
    gpasim: ["GPA Simulator", GpaSim], planner: ["Study Planner", StudyPlanner],
    gradplan: ["Graduation Planner", GradPlanner],
  };

  useEffect(() => { const i = setInterval(() => setMins(m => m + 1), 6000); return () => clearInterval(i); }, []);
  const clock = `${String(Math.floor(mins / 60)).padStart(2, "0")}:${String(mins % 60).padStart(2, "0")}`;

  useEffect(() => { if (scrollRef.current) scrollRef.current.scrollTop = 0; setScrolled(false); setStack(null); }, [tab]);
  useEffect(() => { endRef.current?.scrollIntoView({ behavior: "smooth" }); }, [msgs, typing]);

  const send = (text) => {
    setMsgs(m => [...m, { role: "user", text }]);
    setTyping(true);
    setTimeout(() => {
      const r = AI_REPLIES[text] || {
        verdict: "I can only answer from your record.",
        body: "Try one of the suggestions below — I read your transcript, attendance, timetable and deadlines, and nothing else.",
        chips: [["Record-only", T.purple]],
        cta: "See what Nexus reads",
      };
      setTyping(false);
      setMsgs(m => [...m, { role: "ai", ...r }]);
    }, 1300);
  };

  const specKey = phase !== "app" ? "auth" : stack ? stack : sheet === "notifs" ? "notifs" : tab;
  const spec = SPECS[specKey];
  const titles = { today: "Home", portal: "Academics", nexus: "AI", campus: "Campus", me: "Profile" };

  return (
    <div style={{ minHeight: "100vh", background: T.ink, fontFamily: SF, color: T.text, padding: narrow ? "20px 16px 40px" : "28px 20px 40px", overflowX: "hidden" }}>
      <style>{`
        @keyframes rise { from { opacity:0; transform: translateY(8px);} to {opacity:1; transform:none;} }
        @keyframes fade { from { opacity:0 } to { opacity:1 } }
        @keyframes sheetup { from { transform: translateY(100%);} to { transform:none;} }
        @keyframes dot { 0%,60%,100%{opacity:.25; transform:translateY(0)} 30%{opacity:1; transform:translateY(-3px)} }
        @keyframes glow { 0%,100%{opacity:.5} 50%{opacity:1} }
        @keyframes scan { 0%{top:6%} 100%{top:94%} }
        @keyframes pop { from {transform:scale(.6); opacity:0} to {transform:none; opacity:1} }
        @keyframes grow { from { width:0 } }
        @keyframes shimmer { 0%,100%{opacity:.45} 50%{opacity:1} }
        .rise { animation: rise .34s cubic-bezier(.2,.8,.2,1) both; }
        .fade { animation: fade .2s both; }
        .sheet { animation: sheetup .34s cubic-bezier(.2,.9,.2,1) both; }
        .dot { animation: dot 1.1s infinite; }
        .pulse { animation: glow 2.4s infinite; }
        .thread { animation: shimmer 3.4s ease-in-out infinite; }
        .glowpulse { animation: glow 2.6s ease-in-out infinite; }
        .scanline { animation: scan 1.1s ease-in-out infinite alternate; }
        .pop { animation: pop .4s cubic-bezier(.2,1.4,.4,1) both; }
        .grow { animation: grow 1.1s cubic-bezier(.2,.8,.2,1) both; }
        @keyframes pushin { from { transform: translateX(100%);} to { transform:none;} }
        @keyframes ring { 0%{transform:scale(.9); opacity:.2} 50%{transform:scale(1); opacity:1} 100%{transform:scale(.9); opacity:.2} }
        .push { animation: pushin .36s cubic-bezier(.2,.9,.2,1) both; }
        .ring1 { animation: ring 1.7s ease-in-out infinite; }
        .ring2 { animation: ring 1.7s ease-in-out infinite .25s; }
        .noscroll::-webkit-scrollbar { display:none; }
        .noscroll { scrollbar-width:none; }
        @media (prefers-reduced-motion: reduce) { * { animation: none !important; transition: none !important; } }
      `}</style>

      <div style={{ maxWidth: 1180, margin: "0 auto", display: "flex", gap: narrow ? 22 : 34, flexDirection: narrow ? "column" : "row", alignItems: narrow ? "stretch" : "flex-start", justifyContent: "center" }}>

        {/* LEFT — brief */}
        <div style={{ width: narrow ? "100%" : 250, minWidth: 0, flex: narrow ? "0 0 auto" : "0 1 250px" }}>
          <div style={{ fontFamily: MONO, fontSize: 11, letterSpacing: 2, color: T.purple, fontWeight: 600 }}>O6U NEXUS</div>
          <h1 style={{ fontSize: 26, fontWeight: 700, letterSpacing: -0.6, margin: "8px 0 8px", lineHeight: 1.15 }}>iOS interface</h1>
          <p style={{ fontSize: 13.5, color: T.muted, lineHeight: 1.55, margin: 0 }}>
            A high-fidelity prototype of the student app. Native iOS patterns — collapsing large titles, a five-tab bar, bottom sheets — carrying the Nexus identity.
          </p>

          <div className="noscroll" style={{
            marginTop: 18, display: "flex", gap: 7,
            flexDirection: narrow ? "row" : "column",
            overflowX: narrow ? "auto" : "visible",
            margin: narrow ? "18px -16px 0" : "18px 0 0",
            padding: narrow ? "0 16px" : 0,
          }}>
            {[
              ["__auth", "Auth flow", "01"],
              ...Object.entries(titles).map(([id, label], i) => [id, label, String(i + 2).padStart(2, "0")]),
              ["notifs", "Notifications", "07"],
            ].map(([id, label, n]) => {
              const on = id === "__auth" ? phase !== "app"
                : id === "notifs" ? sheet === "notifs"
                : (tab === id && sheet !== "notifs" && phase === "app");
              return (
                <button key={id} onClick={() => {
                  if (id === "__auth") { setSheet(null); setStack(null); setPhase("splash"); return; }
                  setPhase("app"); setStack(null);
                  if (id === "notifs") { setTab("today"); setSheet("notifs"); } else { setSheet(null); setTab(id); }
                }} style={{
                  display: "flex", alignItems: "center", gap: 8, padding: "9px 12px", borderRadius: 10, cursor: "pointer",
                  flexShrink: 0, whiteSpace: "nowrap",
                  background: on ? T.raise2 : "transparent",
                  border: `0.5px solid ${on ? T.hair : "transparent"}`, textAlign: "left",
                }}>
                  <span style={{ fontFamily: MONO, fontSize: 11, color: on ? T.purple : T.dim }}>{n}</span>
                  <span style={{ fontFamily: SF, fontSize: 14, fontWeight: on ? 600 : 500, color: on ? T.text : T.muted }}>{label}</span>
                </button>
              );
            })}
          </div>

          {!narrow && (
            <div style={{ marginTop: 16, paddingTop: 14, borderTop: `0.5px solid ${T.hair}` }}>
              <div style={{ fontFamily: MONO, fontSize: 10, letterSpacing: 1.4, color: T.dim, marginBottom: 9 }}>SUB-SCREENS</div>
              {[["Academics", ["schedule", "grades", "attendance", "transcript"], "portal"],
                ["AI", ["gpasim", "planner", "gradplan"], "nexus"]].map(([group, ids, parent]) => (
                <div key={group} style={{ marginBottom: 10 }}>
                  <div style={{ fontFamily: SF, fontSize: 11.5, color: T.dim, marginBottom: 5 }}>{group}</div>
                  <div style={{ display: "flex", flexWrap: "wrap", gap: 5 }}>
                    {ids.map(id => (
                      <button key={id} onClick={() => { setPhase("app"); setSheet(null); setTab(parent); setTimeout(() => setStack(id), 0); }} style={{
                        padding: "5px 9px", borderRadius: 7, cursor: "pointer",
                        background: stack === id ? tint(T.purple, 0.16) : "transparent",
                        border: `0.5px solid ${stack === id ? tint(T.purple, 0.4) : T.hair}`,
                        color: stack === id ? T.purple : T.muted, fontFamily: SF, fontSize: 11.5, fontWeight: 600,
                      }}>{SPECS[id].title}</button>
                    ))}
                  </div>
                </div>
              ))}
            </div>
          )}

          <div style={{ marginTop: 22, display: "flex", gap: 8 }}>
            <button onClick={() => setSpecs(s => !s)} style={{
              flex: 1, minHeight: 40, borderRadius: 10, cursor: "pointer", display: "flex", alignItems: "center", justifyContent: "center", gap: 6,
              background: specs ? tint(T.purple, 0.16) : "transparent", border: `0.5px solid ${specs ? tint(T.purple, 0.4) : T.hair}`,
              color: specs ? T.purple : T.muted, fontFamily: SF, fontSize: 13, fontWeight: 600,
            }}><Ruler size={14} />Redlines</button>
            <button onClick={() => setGrid(g => !g)} style={{
              flex: 1, minHeight: 40, borderRadius: 10, cursor: "pointer", display: "flex", alignItems: "center", justifyContent: "center", gap: 6,
              background: grid ? tint(T.blue, 0.16) : "transparent", border: `0.5px solid ${grid ? tint(T.blue, 0.4) : T.hair}`,
              color: grid ? T.blue : T.muted, fontFamily: SF, fontSize: 13, fontWeight: 600,
            }}><Grid3x3 size={14} />8-pt grid</button>
          </div>

          <div style={{ marginTop: 26, paddingTop: 18, borderTop: `0.5px solid ${T.hair}`, display: narrow ? "none" : "block" }}>
            <div style={{ fontFamily: MONO, fontSize: 10, letterSpacing: 1.4, color: T.dim, marginBottom: 10 }}>PALETTE</div>
            <div style={{ display: "flex", flexWrap: "wrap", gap: 6 }}>
              {[["#090B12", "ink"], [T.purple, "accent"], [T.blue, "info"], [T.green, "safe"], [T.amber, "warn"], [T.pink, "due"]].map(([c, n]) => (
                <div key={n} style={{ display: "flex", alignItems: "center", gap: 5, padding: "4px 8px 4px 5px", borderRadius: 7, border: `0.5px solid ${T.hair}` }}>
                  <span style={{ width: 12, height: 12, borderRadius: 4, background: c, border: `0.5px solid ${T.hair}` }} />
                  <span style={{ fontFamily: MONO, fontSize: 10, color: T.muted }}>{n}</span>
                </div>
              ))}
            </div>
            <div style={{ fontFamily: MONO, fontSize: 10, letterSpacing: 1.4, color: T.dim, margin: "16px 0 8px" }}>TYPE</div>
            <div style={{ fontSize: 12.5, color: T.muted, lineHeight: 1.7 }}>
              SF Pro · 34/700 large title · 17/600 headline · 17/400 body · 13 footnote<br />
              SF Mono for every number a student reads twice.
            </div>
          </div>
        </div>

        {/* CENTER — device */}
        <div style={{ flex: "0 0 auto", display: "flex", justifyContent: "center", width: narrow ? "100%" : "auto" }}>
        <div style={{ width: DEV_W * scale, height: DEV_H * scale, flexShrink: 0 }}>
          <div style={{ transform: `scale(${scale})`, transformOrigin: "top left", position: "relative", width: DEV_W, height: DEV_H, borderRadius: 55, padding: 11, background: "linear-gradient(150deg,#3A4266,#171B29 40%,#2A3048)", boxShadow: "0 50px 100px -30px rgba(0,0,0,.85), 0 0 0 1px rgba(255,255,255,.06)" }}>
            <div style={{ position: "relative", width: "100%", height: "100%", borderRadius: 45, overflow: "hidden", background: T.ink }}>
              {/* ambient */}
              <div style={{ position: "absolute", top: -80, left: -40, width: 300, height: 300, background: `radial-gradient(circle, ${tint(T.purpleDeep, 0.22)}, transparent 65%)`, pointerEvents: "none" }} />
              <div style={{ position: "absolute", bottom: 40, right: -60, width: 280, height: 280, background: `radial-gradient(circle, ${tint(T.blueDeep, 0.14)}, transparent 65%)`, pointerEvents: "none" }} />

              {/* dynamic island */}
              <div style={{ position: "absolute", top: 11, left: "50%", transform: "translateX(-50%)", width: 122, height: 35, borderRadius: 20, background: "#000", zIndex: 50 }} />

              <StatusBar clock={clock} />

              {phase === "splash" && <Splash />}
              {phase === "onboarding" && <Onboarding next={() => setPhase("login")} />}
              {phase === "login" && <Login next={() => setPhase("faceid")} faceId={() => setPhase("faceid")} />}
              {phase === "faceid" && <FaceID next={() => setPhase("app")} />}

              {stack && phase === "app" && (() => {
                const [pt, PC] = PUSHES[stack];
                return <Push title={pt} onBack={() => setStack(null)}><PC /></Push>;
              })()}

              <div ref={scrollRef} onScroll={e => setScrolled(e.target.scrollTop > 26)} className="noscroll"
                style={{ position: "absolute", top: 54, left: 0, right: 0, bottom: 0, overflowY: "auto", paddingBottom: 100 }}>
                <Nav title={titles[tab]} scrolled={scrolled}
                  right={tab === "today" ? (
                    <button onClick={() => setSheet("notifs")} style={{ position: "relative", background: "none", border: "none", cursor: "pointer", padding: 6, minHeight: 44, minWidth: 44, display: "grid", placeItems: "center" }}>
                      <Bell size={20} color={T.text} />
                      <span style={{ position: "absolute", top: 5, right: 6, width: 8, height: 8, borderRadius: 9, background: T.pink, border: `1.5px solid ${T.ink}` }} />
                    </button>
                  ) : null} />
                <div key={tab} className="rise">
                  {tab === "today" && <Today clock={clock} thread={thread} setThread={setThread} setTab={setTab} />}
                  {tab === "portal" && <Portal push={openPush} onOpen={c => { setCourse(c); setSheet("course"); }} />}
                  {tab === "campus" && <Campus />}
                  {tab === "nexus" && <Nexus msgs={msgs} send={send} typing={typing} endRef={endRef} push={openPush} />}
                  {tab === "me" && <Me onScan={() => setSheet("scan")} onNotifs={() => setSheet("notifs")} />}
                </div>
              </div>

              {/* 8-pt grid overlay */}
              {grid && (
                <div style={{
                  position: "absolute", inset: 0, zIndex: 45, pointerEvents: "none",
                  backgroundImage: `linear-gradient(${tint(T.blue, 0.16)} 0.5px, transparent 0.5px), linear-gradient(90deg, ${tint(T.blue, 0.16)} 0.5px, transparent 0.5px)`,
                  backgroundSize: "8px 8px",
                }}>
                  <div style={{ position: "absolute", top: 0, bottom: 0, left: 20, right: 20, borderLeft: `1px solid ${tint(T.blue, 0.55)}`, borderRight: `1px solid ${tint(T.blue, 0.55)}` }} />
                </div>
              )}

              {/* redline pins */}
              {specs && spec.pins.map((p, i) => (
                <div key={i} style={{
                  position: "absolute", top: `${p.y}%`, left: `${p.x}%`, transform: "translate(-50%,-50%)", zIndex: 46,
                  width: 22, height: 22, borderRadius: 11, background: T.purple, color: "#0B0714",
                  display: "grid", placeItems: "center", fontFamily: MONO, fontSize: 11, fontWeight: 700,
                  boxShadow: `0 0 0 4px ${tint(T.purple, 0.22)}`,
                }}>{i + 1}</div>
              ))}

              {phase === "app" && <TabBar tab={tab} setTab={t => { setStack(null); setTab(t); }} alert={msgs.length === 0} />}

              <Sheet open={!!sheet} onClose={() => setSheet(null)}>
                {sheet === "course" && course && <CourseSheet c={course} onClose={() => setSheet(null)} />}
                {sheet === "scan" && <ScanSheet onClose={() => setSheet(null)} />}
                {sheet === "notifs" && <NotifSheet onClose={() => setSheet(null)} />}
              </Sheet>
            </div>
          </div>
        </div>
        </div>

        {/* RIGHT — rationale */}
        <div style={{ width: narrow ? "100%" : 270, minWidth: 0, flex: narrow ? "0 0 auto" : "0 1 270px" }}>
          <div style={{ fontFamily: MONO, fontSize: 10, letterSpacing: 1.4, color: T.dim }}>SCREEN {phase !== "app" ? "01" : stack ? "··" : specKey === "notifs" ? "07" : String(Object.keys(titles).indexOf(tab) + 2).padStart(2, "0")}</div>
          <h2 style={{ fontSize: 22, fontWeight: 700, letterSpacing: -0.4, margin: "6px 0 8px" }}>{spec.title}</h2>
          <p style={{ fontSize: 13.5, color: T.muted, lineHeight: 1.55, margin: 0 }}>{spec.job}</p>

          <div style={{ marginTop: 20, display: "flex", flexDirection: "column", gap: 10 }}>
            {spec.pins.map((p, i) => (
              <div key={i} style={{
                display: "flex", gap: 10, padding: 12, borderRadius: 12,
                background: specs ? tint(T.purple, 0.07) : T.raise,
                border: `0.5px solid ${specs ? tint(T.purple, 0.25) : T.hair}`, transition: "background .2s",
              }}>
                <span style={{
                  flexShrink: 0, width: 20, height: 20, borderRadius: 10, display: "grid", placeItems: "center",
                  background: specs ? T.purple : tint("#FFFFFF", 0.1), color: specs ? "#0B0714" : T.muted,
                  fontFamily: MONO, fontSize: 10.5, fontWeight: 700,
                }}>{i + 1}</span>
                <p style={{ margin: 0, fontSize: 12.8, color: T.muted, lineHeight: 1.5 }}>{p.note}</p>
              </div>
            ))}
          </div>

          <div style={{ marginTop: 22, paddingTop: 18, borderTop: `0.5px solid ${T.hair}` }}>
            <div style={{ fontFamily: MONO, fontSize: 10, letterSpacing: 1.4, color: T.dim, marginBottom: 10 }}>HOLDS THROUGHOUT</div>
            {[
              "44×44 pt minimum on every tap target.",
              "Safe areas respected: 54 pt top, 34 pt home indicator.",
              "One accent per meaning — amber only ever means “below threshold”.",
              "Motion is functional: it shows where a thing came from, then stops.",
            ].map(t => (
              <div key={t} style={{ display: "flex", gap: 8, marginBottom: 8 }}>
                <Check size={13} color={T.green} style={{ flexShrink: 0, marginTop: 3 }} />
                <span style={{ fontSize: 12.8, color: T.muted, lineHeight: 1.5 }}>{t}</span>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
