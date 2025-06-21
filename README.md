<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Aaditya – AI/ML & Software Developer</title>
  <!-- Favicon (add your .favicon file to the project root) -->
  <link rel="icon" href=".favicon" type="image/png" />

  <!-- Simple Icons CDN for crisp SVG logos -->
  <style>
    /* ---------------- Global Reset & Base ---------------- */
    * { margin:0; padding:0; box-sizing:border-box; }
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      line-height:1.6;
      background:#f5f5f5;
      color:#333;
      scroll-behavior: smooth;
    }
    a { text-decoration: none; }
    img { display: inline-block; vertical-align: middle; }

    /* ---------------- Centered Header ---------------- */
    header {
      text-align: center;
      padding: 3rem 1rem 2rem;
      background: #fff;
      box-shadow: 0 2px 5px rgba(0,0,0,0.05);
    }
    header h1 { font-size:2.5rem; margin-bottom:0.5rem; }
    header h3 { font-size:1.25rem; color:#555; }

    /* Wave animation for scroll hint */
    @keyframes wave {
      0%,100% { transform: translateY(0); opacity:1; }
      50%      { transform: translateY(8px); opacity:0.7; }
    }
    .wave {
      display:inline-block;
      font-size:1.1rem;
      margin-top:1rem;
      animation: wave 2s infinite;
    }

    /* ---------------- Sections ---------------- */
    section {
      max-width:800px;
      margin: 3rem auto;
      padding: 0 1rem;
    }
    h2 { margin-bottom:1rem; border-bottom:2px solid #ddd; padding-bottom:0.5rem; color:#222; }

    /* ---------------- Connect Icons ---------------- */
    .social-icons a {
      margin: 0 0.5rem;
      transition: transform 0.2s;
    }
    .social-icons a:hover { transform: scale(1.1); }

    /* ---------------- Tool Icons Grid ---------------- */
    .tools {
      display:grid;
      grid-template-columns: repeat(auto-fit, minmax(60px,1fr));
      gap:1rem;
      justify-items:center;
      margin-top:1rem;
    }
    .tools img { width:40px; height:40px; }

    /* ---------------- Reveal on scroll ---------------- */
    .reveal {
      opacity: 0;
      transform: translateY(30px);
      transition: all 0.6s ease-out;
    }
    .reveal.active {
      opacity: 1;
      transform: translateY(0);
    }

    /* ---------------- GitHub Stats ---------------- */
    .stats-container {
      text-align:center;
      background:#fff;
      padding:2rem 1rem;
      box-shadow: 0 2px 5px rgba(0,0,0,0.05);
    }
  </style>
</head>
<body>

  <!-- HEADER -->
  <header>
    <h1>👋 Hi, I'm Aaditya</h1>
    <h3>A passionate AI/ML & Software Developer from India</h3>
    <p>
      <img src="https://komarev.com/ghpvc/?username=aadik1ng&label=Profile%20views&color=0e75b6&style=flat" alt="Profile views" />
      &nbsp;
      <img src="https://github-profile-trophy.vercel.app/?username=aadik1ng&theme=onedark" alt="Trophies" />
    </p>
    <div class="wave">👇 Scroll to see what I’m up to! 👇</div>
  </header>

  <!-- CONNECT -->
  <section class="reveal">
    <h2>🤝 Connect with me</h2>
    <div class="social-icons" align="center">
      <a href="https://www.linkedin.com/in/aaditya-a-b95254214" target="_blank">
        <img src="https://cdn.jsdelivr.net/npm/simple-icons@v10/icons/linkedin.svg" alt="LinkedIn" title="LinkedIn"/>
      </a>
      <a href="https://www.leetcode.com/aadik1ng" target="_blank">
        <img src="https://cdn.jsdelivr.net/npm/simple-icons@v10/icons/leetcode.svg" alt="LeetCode" title="LeetCode"/>
      </a>
      <!-- add more as needed -->
    </div>
  </section>

  <!-- TOOLS & LANGUAGES -->
  <section class="reveal">
    <h2>🛠️ Languages & Tools</h2>
    <div class="tools">
      <img src="https://cdn.jsdelivr.net/npm/simple-icons@v10/icons/python.svg"        alt="Python"        title="Python"/>
      <img src="https://cdn.jsdelivr.net/npm/simple-icons@v10/icons/pytorch.svg"       alt="PyTorch"       title="PyTorch"/>
      <img src="https://cdn.jsdelivr.net/npm/simple-icons@v10/icons/tensorflow.svg"    alt="TensorFlow"    title="TensorFlow"/>
      <img src="https://cdn.jsdelivr.net/npm/simple-icons@v10/icons/scikit-learn.svg"  alt="scikit-learn"  title="scikit-learn"/>
      <img src="https://cdn.jsdelivr.net/npm/simple-icons@v10/icons/pandas.svg"        alt="Pandas"        title="Pandas"/>
      <img src="https://cdn.jsdelivr.net/npm/simple-icons@v10/icons/go.svg"            alt="Go"            title="Go"/>
      <img src="https://cdn.jsdelivr.net/npm/simple-icons@v10/icons/react.svg"         alt="React"         title="React"/>
      <img src="https://cdn.jsdelivr.net/npm/simple-icons@v10/icons/angular.svg"       alt="Angular"       title="Angular"/>
      <!-- continue for your other tools... -->
    </div>
  </section>

  <!-- GITHUB STATS -->
  <div class="stats-container reveal">
    <img src="https://github-readme-stats.vercel.app/api?username=aadik1ng&show_icons=true&theme=radical" alt="GitHub stats"/>
  </div>

  <!-- PROJECT HIGHLIGHTS -->
  <section class="reveal">
    <h2>✨ Projects & Highlights</h2>
    <ul>
      <li><strong>Semantic Search Engine</strong> with BERT + FAISS → ~90% domain accuracy</li>
      <li><strong>Open Source</strong> contributions to Flask & TensorFlow core</li>
      <li><strong>Microservices</strong> on AWS Lambda & Docker, integrated in React/Angular</li>
      <li><strong>Currently Learning:</strong> Diffusion Model Tuning & Scalable AI Pipelines</li>
    </ul>
  </section>

  <!-- SCROLL REVEAL SCRIPT -->
  <script>
    document.addEventListener('scroll', () => {
      document.querySelectorAll('.reveal').forEach(el => {
        const rect = el.getBoundingClientRect();
        if (rect.top < window.innerHeight - 100) {
          el.classList.add('active');
        }
      });
    });
    // trigger on load
    window.dispatchEvent(new Event('scroll'));
  </script>

</body>
</html>
