<script>
  import Navbar from "./components/Navbar.svelte";
  import BusinessCard from "./components/BusinessCard.svelte";
</script>

<about>
  <Navbar />
  <div class="about-body">
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
</style>
