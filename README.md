# ⚡ AADITYA AARYAN

### AI/ML Engineer · Backend Developer · Agentic AI Builder

Building production-ready AI systems. **LLMs · RAG · Multi-Agent Workflows · Computer Vision · Real-Time STT · FastAPI**

<div align="center">
  <a href="https://github.com/Aadik1ng"><img src="https://img.shields.io/badge/GitHub-Aadik1ng-00FF41?style=flat-square&logo=github" alt="GitHub" /></a>
  <a href="https://www.linkedin.com/in/aaditya-a-b95254214"><img src="https://img.shields.io/badge/LinkedIn-Aaditya%20Aaryan-00D9FF?style=flat-square&logo=linkedin" alt="LinkedIn" /></a>
  <a href="mailto:aadityaaryan639@gmail.com"><img src="https://img.shields.io/badge/Email-aadityaaryan639-FF006E?style=flat-square&logo=gmail&logoColor=white" alt="Email" /></a>
  <a href="https://www.leetcode.com/aadik1ng"><img src="https://img.shields.io/badge/LeetCode-aadik1ng-FFB700?style=flat-square&logo=leetcode" alt="LeetCode" /></a>
  <a href="https://github.com/Aadik1ng?tab=followers"><img src="https://komarev.com/ghpvc/?username=Aadik1ng&style=flat-square&color=00FF41" alt="Views" /></a>
</div>

---

## 🎯 Core Domains

| 🧠 **LLMs & Agents** | ⚙️ **Backend** | 📊 **Data** | 👁️ **Real-Time AI** |
|---|---|---|---|
| Multi-agent · RAG · GraphRAG | FastAPI · WebSockets · Microservices | PostgreSQL · MongoDB · Vector DB | STT · Video · OpenCV |
| LLM evaluation · Grounding | Async Python · APIs · Production | Knowledge graphs · FAISS · Indexing | Whisper · Inference · Computer vision |

---

## 💡 Skills Matrix

```
🤖 AI/ML              ⚙️ Backend              💾 Data                 🚀 MLOps
LLMs · RAG · Agents   FastAPI · APIs         PostgreSQL · MongoDB    Docker · AWS
Evaluation · CV       WebSockets · Async    Vector DB · Graphs      GitHub Actions
Hallucination ctrl    Production Scaling    Redis · Indexing        Kubernetes · CI/CD
```

---

## 💻 Tech Stack

<p align="center">
  <img src="https://skillicons.dev/icons?i=python,go,cpp,java,bash,rust" alt="Languages" /> <br/>
  <img src="https://skillicons.dev/icons?i=fastapi,flask,postgresql,mongodb,redis,docker" alt="Backend & Data" /> <br/>
  <img src="https://skillicons.dev/icons?i=pytorch,tensorflow,opencv,sklearn" alt="ML Frameworks" />
</p>

**AI Ecosystems:** 
<p align="center">
  <img src="https://img.shields.io/badge/LangChain-1C3C3C?style=flat-square&logo=chainlink&logoColor=white" alt="LangChain" />
  <img src="https://img.shields.io/badge/LangGraph-00FF41?style=flat-square&logo=graphql&logoColor=black" alt="LangGraph" />
  <img src="https://img.shields.io/badge/LlamaIndex-00D9FF?style=flat-square&logoColor=white" alt="LlamaIndex" />
  <img src="https://img.shields.io/badge/Hugging%20Face-FFB700?style=flat-square&logo=huggingface&logoColor=black" alt="Hugging Face" />
  <img src="https://img.shields.io/badge/OpenAI-000000?style=flat-square&logo=openai&logoColor=white" alt="OpenAI" />
  <img src="https://img.shields.io/badge/Claude-8B5CF6?style=flat-square&logoColor=white" alt="Claude" />
  <img src="https://img.shields.io/badge/FAISS-FF006E?style=flat-square&logoColor=white" alt="FAISS" />
  <img src="https://img.shields.io/badge/Neo4j-008CC1?style=flat-square&logo=neo4j&logoColor=white" alt="Neo4j" />
</p>

**Cloud & DevOps:**
<p align="center">
  <img src="https://skillicons.dev/icons?i=aws,azure,docker,github,git,linux" alt="Cloud & DevOps" />
</p>

---

## ⚡ Agentic AI Capabilities

<p align="center">
  <img src="https://img.shields.io/badge/Multi%20Agent-LangGraph%20·%20ReAct%20·%20Planning-00FF41?style=for-the-badge" alt="Multi-Agent" />
  <img src="https://img.shields.io/badge/RAG%20Systems-Vector%20·%20Graph%20·%20Hybrid-00D9FF?style=for-the-badge" alt="RAG" />
  <img src="https://img.shields.io/badge/Evaluation-Judge%20·%20Validation%20·%20Grounding-FF006E?style=for-the-badge" alt="Evaluation" />
  <img src="https://img.shields.io/badge/Automation-Agents%20·%20CRM%20·%20Workflows-FFB700?style=for-the-badge" alt="Automation" />
</p>

---

## 🔥 Featured Projects

### 1️⃣ **Intel-Doc** — Agentic GraphRAG for Document Intelligence
**Use Case:** Enterprise document Q&A with <5% hallucination rate. Analyzes logistics & legal documents with high-precision extraction and grounding.

**Architecture:** Agentic LangGraph pipeline → Hybrid vector + graph retrieval (Memgraph) → Judge-first validation → Grounded answer generation with telemetry

**Key Features:**
- Cyclic agentic loops with fast-fail fallbacks
- Strict grounding node (faithfulness scoring)
- Context relevance validation *before* generation
- Chunking strategy optimized for fact-density
- Confidence scoring (model + retrieval + faithfulness weighted)

**Stack:** `LlamaIndex` · `LangGraph` · `Memgraph 3.0` · `LiteLLM` · `FastAPI` · `Streamlit`

**Metrics:** Hallucination detection, retrieval confidence, post-generation audit

---

### 2️⃣ **GraphRAG (Lease AI)** — Multi-Document Legal Analysis
**Use Case:** Analyze lease documents, extract structured data (parties, financial terms, dates), perform Q&A with source citations.

**Architecture:** FalkorDB graph + ChromaDB vector hybrid search → FastAPI backend → ADK chat interface → Structured extraction templates

**Key Features:**
- PDF upload & multi-document indexing
- Structured lease summary extraction (parties, dates, financials, options)
- Source citation for every answer (page numbers)
- API endpoints for upload, delete, chat, extract, evaluate
- Automated quality testing

**Stack:** `Google ADK` · `FalkorDB` · `ChromaDB` · `FastAPI` · `OpenAI` · `Docker`

**Use Cases:** Real estate analysis, contract review, compliance checks, automated lease summaries

---

### 3️⃣ **Clinical Intake Agent** — Dual-Mode Healthcare Intake System
**Use Case:** Conversational clinical intake for healthcare workflows. Supports text chat (MVP) and real-time voice with Whisper STT + OpenAI TTS.

**Architecture:** FastAPI backend + Streamlit UI + LiveKit voice room → Azure OpenAI LLM → Whisper STT/TTS pipeline → Real-time voice worker daemon

**Key Features:**
- Dual-mode interface (text chat + real-time voice)
- LiveKit WebRTC for browser-based voice (cloud or self-hosted Docker)
- OpenAI Whisper STT with clinical language tuning
- OpenAI TTS for agent responses
- Session-based state management
- Automatic brief generation on session end
- Structured intake slots & red flag detection
- Multimodal response capability (text → voice in same flow)
- One-command startup (Windows PowerShell + Linux bash scripts)

**Stack:** `FastAPI` · `Streamlit` · `LiveKit` · `Whisper STT` · `OpenAI TTS` · `Azure OpenAI` · `LiteLLM` · `Docker`

**Workflow:** Client starts text/voice session → AI asks intake questions → Collects structured data → Flags medical concerns → Generates brief summary

---

### 4️⃣ **Shinzo** — MCP Server Observability Platform
**Use Case:** Complete OpenTelemetry-compatible observability for AI agent MCP servers. Monitor tool usage, analyze performance, contextualize agent behavior.

**Architecture:** Automatic instrumentation of FastMCP/MCP servers → OpenTelemetry exports → Shinzo dashboard for insights

**Key Features:**
- One-line instrumentation for MCP servers
- Agent usage pattern analysis
- Tool call contextualization
- Performance metrics & latency tracking
- Multi-platform support
- Flexible export configuration
- Bearer token auth for security

**Stack:** `OpenTelemetry` · `MCP SDK / FastMCP` · `Python` · `Observability standards`

**Metrics:** Tool invocation rates, latency, error tracking, agent behavior patterns

---

### 5️⃣ **Ramy** — UAE Mortgage Advisor Agent
**Use Case:** Conversational financial advisor for UAE expats navigating mortgage decisions. Provides "buy vs. rent" analysis, affordability calculations, and mortgage guidance using deterministic tools.

**Architecture:** Google ADK agent → LiteLLM (Groq) for ultra-fast LLM → Deterministic Python tools (NO hallucination on numbers) → FastAPI backend + vanilla JS frontend with streaming SSE

**Key Features:**
- Conversational "buy vs. rent" analysis with break-even calculations
- Deterministic financial tools (EMI, affordability, eligibility checks)
- UAE-specific mortgage rules & regulations (20% down, LTV limits, DBR)
- Streaming responses via Server-Sent Events (SSE)
- Lead capture at natural conversation stops
- Glassmorphism UI for modern UX
- Groq integration for sub-second response times
- Pytest test suite for financial tools
- Docker + Google Cloud Run deployment

**Stack:** `Google ADK` · `LiteLLM` · `Groq llama-3.3-70b` · `FastAPI` · `Vanilla JS/HTML5/CSS3` · `Pytest` · `Docker` · `Cloud Run`

**Tools:**
- `tool_calculate_mortgage` — EMI, interest, upfront costs
- `tool_assess_affordability` — Max budget by DBR rules
- `tool_compare_buy_vs_rent` — Break-even tenure analysis
- `tool_check_eligibility` — Expat/national/self-employment rules
- `tool_get_uae_mortgage_rules` — Central Bank regulations

---

---

## 📊 GitHub Analytics

<img src="https://github-readme-streak-stats.herokuapp.com/?user=Aadik1ng&theme=dark&hide_border=true&stroke=00FF41" alt="GitHub streak" width="100%" />

<img src="https://github-readme-activity-graph.vercel.app/graph?username=Aadik1ng&theme=react-dark&hide_border=true&bg_color=0d1117&color=00FF41&line=00D9FF&point=FF006E" alt="Contribution activity" width="100%" />

---

## 🌱 Exploring

<p align="center">
  <img src="https://img.shields.io/badge/🎤%20Voice%20AI-STT%20·%20Agents-00FF41?style=flat-square" alt="Voice AI" />
  <img src="https://img.shields.io/badge/📊%20GraphRAG-Memory%20·%20Graphs-00D9FF?style=flat-square" alt="GraphRAG" />
  <img src="https://img.shields.io/badge/👁️%20Computer%20Vision-Real%20Time%20·%20Edge-FF006E?style=flat-square" alt="CV" />
  <img src="https://img.shields.io/badge/✅%20LLM%20Reliability-Evaluation%20·%20Safety-FFB700?style=flat-square" alt="LLM Reliability" />
  <img src="https://img.shields.io/badge/🚀%20AI%20Prod-Scaling%20·%20Ops-00FF41?style=flat-square" alt="AI Production" />
</p>

---

---

## 🔗 Connect & Collaborate

<p align="center">
  <img src="https://img.shields.io/badge/Open%20To-Collabs%20·%20Consulting-00FF41?style=for-the-badge" alt="Open to collabs" />
  <img src="https://img.shields.io/badge/Specializing%20In-AI%20%2F%20Backend%20Systems-00D9FF?style=for-the-badge" alt="Specializing" />
</p>

---

## 📱 Links

<p align="center">
  <a href="https://github.com/Aadik1ng"><img src="https://img.shields.io/badge/GitHub-Aadik1ng-00FF41?style=for-the-badge&logo=github" alt="GitHub" /></a>
  <a href="https://www.linkedin.com/in/aaditya-a-b95254214"><img src="https://img.shields.io/badge/LinkedIn-Aaditya%20Aaryan-00D9FF?style=for-the-badge&logo=linkedin" alt="LinkedIn" /></a>
  <a href="mailto:aadityaaryan639@gmail.com"><img src="https://img.shields.io/badge/Email-aadityaaryan639-FF006E?style=for-the-badge&logo=gmail&logoColor=white" alt="Email" /></a>
  <a href="https://www.leetcode.com/aadik1ng"><img src="https://img.shields.io/badge/LeetCode-aadik1ng-FFB700?style=for-the-badge&logo=leetcode" alt="LeetCode" /></a>
</p>

### 💡 Open to Collaborations
**Building:** AI/ML systems · Production LLM applications · Agentic workflows · Real-time backends · Computer vision pipelines

---

<p align="center">
  <b>Made with ⚡ & 🧠 by Aaditya Aaryan</b><br/>
  <sub>Turning ideas into intelligent, production-ready systems</sub>
</p>
