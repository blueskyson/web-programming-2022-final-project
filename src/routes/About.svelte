<script>
  import Navbar from "./components/Navbar.svelte";
  import BusinessCard from "./components/BusinessCard.svelte";
</script>

<about>
  <Navbar />

  <div class="about-body">
    <div class="about-description">
      <b style="font-size:1.4em;">About Us</b><br />
      <b style="font-size:1.5em;">關於我們</b><br />
      <span class="context"
        >嗨！我們是第七組，由一位設計師＋兩位工程師組成，</span
      ><br />
      <span class="context">我們要做投資理財相關的酷 App。</span>
    </div>
    <BusinessCard
      zhName="顏楷杰"
      enName="Kai-Chieh Yen"
      jobTitle="Designer"
      leftPercentage="16%"
      src={"/res/02.png"}
      shadowSrc={"/res/02-shadow.png"}
      text={"早上好成大"}
    />
    <BusinessCard
      zhName="林政傑"
      enName="Lin Cheng-Chieh"
      jobTitle="Engineer"
      leftPercentage="50%"
      src={"/res/01.png"}
      shadowSrc={"/res/01-shadow.png"}
      text={"安安"}
    />
    <BusinessCard
      zhName="張邦翰"
      enName="Zhang Bang-Han"
      jobTitle="Engineer"
      leftPercentage="84%"
      src={"/res/03.png"}
      shadowSrc={"/res/03-shadow.png"}
      text={"安安"}
    />
  </div>
</about>

<style>
  .about-body {
    z-index: 1;
    position: absolute;
    height: 90%;
    width: 100%;
    background: url("../res/about-bg.jpg");
    background-size: cover;
    background-repeat: no-repeat;
    background-position: center;
  }

  .about-description {
    width: 100vw;
    text-align: center;
    margin: 0 auto;
  }

  .context {
    font-size: 0.9em;
    color: #a7a7a7;
  }
</style>
