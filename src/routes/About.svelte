<script>
  import Navbar from "./components/Navbar.svelte";
  import BusinessCard from "./components/BusinessCard.svelte";
</script>

<about>
  <Navbar />

  <div class="about-body">
    <div class="about-description">
        <b style="font-size:1.4em;">About Us</b><br/>
        <b style="font-size:1.5em;">關於我們</b><br/>
        <span class="context">嗨！我們是第七組，由一位設計師＋兩位工程師組成，</span><br/>
        <span class="context">我們要做投資理財相關的酷App。</span>
    </div>
    <BusinessCard
      zhName="嚴楷杰"
      enName="Kai-Chieh Yen"
      jobTitle="Designer"
      leftPercentage="16%"
      src={"/res/02-compressed.png"}
    />
    <BusinessCard
      zhName="林政傑"
      enName="Lin Cheng-Chieh"
      jobTitle="Engineer"
      leftPercentage="50%"
      src={"/res/01-compressed.png"}
    />
    <BusinessCard
      zhName="張邦翰"
      enName="Zhang Bang-han"
      jobTitle="Engineer"
      leftPercentage="84%"
      src={"/res/03-compressed.png"}
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
