---
id: about
title: About BoloIndia
sidebar_label: About Us
slug: /about
---

# About BoloIndia

BoloIndia is an open-source, voice-first feedback management platform designed to bridge the gap between citizens and public service organizations across India. Born from a hackathon challenge, it has evolved into a production-ready microservices architecture that democratizes feedback collection for low-literacy and rural populations.

---

## 🎯 Project Vision

**Mission:** Enable every Indian citizen—regardless of literacy level, language, or technical ability—to provide structured, actionable feedback on public services through simple QR codes and voice input.

**Impact:**
- 🗣️ Voice-first design eliminates literacy barriers
- 📍 QR codes provide instant context (location + service + organization)
- 📊 Real-time dashboards enable data-driven governance
- 🔔 Automated workflows ensure citizen feedback doesn't disappear into bureaucracy

---

## 👨‍💻 Developer

<div style={{display: 'flex', alignItems: 'flex-start', gap: '30px', marginBottom: '30px', flexWrap: 'wrap'}}>
  <img src="/img/shakil-profile.jpg" alt="Muhammad Shakil Patel" style={{borderRadius: '10px', width: '200px', height: '200px', objectFit: 'cover', boxShadow: '0 4px 8px rgba(0,0,0,0.1)'}} />
  <div style={{flex: 1, minWidth: '300px'}}>
    <h3>Muhammad Shakil Patel</h3>
    <p><strong>Full Stack Developer & Software Architect</strong></p>

    **Expertise:**
    - Microservices Architecture (Jakarta EE, Node.js, Spring Boot)
    - Cloud-Native Development (Docker, Kubernetes, AWS)
    - Event-Driven Systems (Apache Kafka, RabbitMQ)
    - API Gateway Design (Kong, nginX)
    - Frontend Development (React.js, Jetpack Compose (Kotlin), Material-UI)

    **Education:**  
    Master of Science in Information &amp; Communication Technology<br></br>
    J P Dawer Institute of IT &amp; ICT, VNSGU

    **Connect:**  
    🔗 [GitHub](https://github.com/PatelShakil) • 🌐 [Portfolio](https://patelshakil.techsavvysolution.in) • 💼 [LinkedIn](https://linkedin.com/in/patelshakil) • 📧 [Email](mailto:patelshakil.dev@gmail.com)

    ---

    **Project Role:**
    - Architected 7-microservice backend (PostgreSQL, MongoDB, Kafka)
    - Implemented multi-tenant isolation and RBAC security
    - Designed Kong API Gateway with rate limiting & circuit breakers
    - Built React admin dashboards and Kotlin Jetpack Compose mobile app
    - Created complete Docker Compose deployment stack
  </div>
</div>

---

## 🎓 Academic Guidance

<div style={{display: 'flex', alignItems: 'flex-start', gap: '30px', marginBottom: '30px', flexWrap: 'wrap'}}>
  <img src="/img/dr-pandey-profile.jpeg" alt="Dr. Kamlendu Pandey" style={{borderRadius: '10px', width: '180px', height: '180px', objectFit: 'cover', boxShadow: '0 4px 8px rgba(0,0,0,0.1)'}} />
  <div style={{flex: 1, minWidth: '300px'}}>
    <h3>Dr. Kamlendu Pandey</h3>
    <p><strong>Assistant Professor, Department of Information Technology</strong></p>

    **Areas of Expertise:**
    - Software Engineering & Design Patterns
    - Distributed Systems & Microservices
    - Database Management Systems
    - System Architecture & Scalability

    **Guidance Contributions:**
    - Reviewed microservices architecture design
    - Advised on database schema design (PostgreSQL + MongoDB)
    - Suggested event-driven patterns using Kafka
    - Mentored on production deployment best practices
    - Provided feedback on security (JWT, RBAC) implementation

    **Institution:**  
    J P Dawer Institute of IT &amp; ICT, VNSGU  
    Surat, Gujarat, India
  </div>
</div>

---

## 🏛️ Academic Institution

### J P Dawer Institute of Information Technology & ICT

**Veer Narmad South Gujarat University (VNSGU)**  
Surat, Gujarat, India

<div style={{backgroundColor: '#f5f5f5', padding: '20px', borderRadius: '8px', marginTop: '20px'}}>

**About the Institute:**

The J P Dawer Institute is a premier institution under VNSGU, dedicated to fostering excellence in Information Technology and ICT education. The institute emphasizes:

- 🎓 Industry-aligned curriculum in BSC IT + MSC IT, MSC ICT, and Other programs
- 💡 Hands-on project-based learning and innovation
- 🏆 Participation in national hackathons and coding competitions
- 🤝 Industry partnerships and internship programs
- 🌐 Research in emerging technologies (Cloud, AI/ML, Blockchain)

**Infrastructure:**
- Modern computer labs with high-speed internet
- Cloud computing lab (AWS, Azure, GCP access)
- Dedicated servers for microservices and DevOps training
- Collaborative project spaces

**Notable Achievements:**
- Consistently high placement rates in top IT companies
- Award-winning student projects in state and national competitions
- Active open-source contributions by students and faculty

</div>

**Website:** [VNSGU Official Site](https://www.vnsgu.ac.in)  
**Location:** Udhna-Magdalla Road, Surat - 395007, Gujarat

---

## 🚀 Project Timeline

| Phase | Timeline            | Milestones |
|-------|---------------------|-----------|
| **Concept** | Oct 2025            | Hackathon problem statement analysis |
| **Architecture** | Nov 2025            | Microservices design, tech stack selection |
| **Development** | Nov 2025 - Dec 2025 | 7 services + 2 frontends + mobile app |
| **Documentation** | Dec 2025            | Docusaurus docs with Mermaid diagrams |
| **Deployment** | Dec 2025            | Docker Compose, Kong Gateway setup |
| **Open Source** | Dec 2025            | GitHub release, community building |

---

## 🛠️ Technology Decisions

### Backend Stack
- **Jakarta EE (Payara Micro):** For Auth, Org, QR, Service services
- **Node.js + Express:** For Feedback, Response, Notification services
- **PostgreSQL 15:** Relational data (users, orgs, QR metadata)
- **MongoDB 7.0:** Document storage (feedback JSON, voice transcripts)
- **Apache Kafka 3.7 (KRaft):** Event streaming, async workflows

### Frontend Stack
- **React.js 18 + Material-UI:** Admin and Distributor dashboards
- **Jetpack Compose Kotlin:** Mobile app (Android)
- **Docusaurus 3:** Documentation site (this site!)

### Infrastructure
- **Kong Gateway 3.5:** API proxy, rate limiting, authentication
- **MinIO:** S3-compatible storage for audio files and QR images
- **Docker Compose:** Local development and single-server deployment
- **Grafana + Prometheus:** Monitoring and metrics

---

## 🌟 Why This Architecture?

1. **Multi-tenancy:** Each organization gets isolated data with dedicated schemas
2. **Event-driven:** Kafka decouples services for scalability and fault tolerance
3. **Voice-first:** MinIO stores raw audio; MongoDB stores transcriptions
4. **API Gateway:** Kong handles auth once, reducing boilerplate across services
5. **Polyglot persistence:** PostgreSQL for relations, MongoDB for flexible feedback JSON
6. **Observability:** Built-in Prometheus metrics and Grafana dashboards

---

## 📞 Contact & Collaboration

**Developer:**  
📧 patelshakil.dev@gmail.com  
🔗 [GitHub Issues](https://github.com/PatelShakil) for bug reports and feature requests

**Academic Inquiries:**  
📧 Contact Dr. Kamlendu Pandey via VNSGU Department of ICT

**Institutional Partnerships:**  
📧 info@vnsgu.ac.in (for collaboration or pilot programs)

---

## 🤝 Contributing

BoloIndia is open source and welcomes contributions!

**How to contribute:**
1. Fork any of the [10 repositories](/resources/github-projects)
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Commit changes with clear messages
4. Submit a Pull Request with detailed description

**Contribution areas:**
- 🐛 Bug fixes and issue resolution
- ✨ New features (language support, analytics, integrations)
- 📚 Documentation improvements
- 🎨 UI/UX enhancements
- 🧪 Test coverage

---

## 📄 License

This project is licensed under the **MIT License**.

You are free to:
- ✅ Use commercially
- ✅ Modify and distribute
- ✅ Use privately
- ✅ Sublicense

**Conditions:**
- Include original license and copyright notice
- Provide attribution to original authors

Full license: [MIT License Text](https://opensource.org/licenses/MIT)

---

## 🙏 Acknowledgments

**Special Thanks:**
- **Dr. Kamlendu Pandey** for invaluable technical guidance
- **J P Dawer Institute** for infrastructure and academic support
- **VNSGU** for fostering innovation culture
- **Open Source Community** for tools that made this possible:
    - Docusaurus, Kafka, PostgreSQL, MongoDB, Kong, MinIO, React, Jetpack Compose Kotlin

---

**Built with ❤️ for India's digital governance revolution.**  
*Empowering every voice, one QR code at a time.*
