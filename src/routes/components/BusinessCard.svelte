<script>
  export let zhName;
  export let enName;
  export let jobTitle;
  export let leftPercentage;
  export let src;
  export let shadowSrc;
  export let text;

  let dialogSrc =
    jobTitle == "Designer"
      ? "/res/dialog-designer.png"
      : "/res/dialog-engineer.png";
  let showDialog = false;
  function handleMouseOver(e) {
    showDialog = true;
  }
  function handleMouseOut(e) {
    showDialog = false;
  }
</script>

{#if showDialog}
  <img src={shadowSrc} alt="" class="__shadow" style="left:{leftPercentage};" />

  <img src={dialogSrc} alt="" class="dialog" style="left:{leftPercentage};" />
  <div class="text" style="left:{leftPercentage};"><b>{text}</b></div>
{/if}

<img
  {src}
  alt=""
  class="avatar"
  style="left:{leftPercentage};"
  on:mouseover|preventDefault={handleMouseOver}
  on:focus|preventDefault={handleMouseOver}
  on:mouseout={handleMouseOut}
  on:blur={handleMouseOver}
/>
<div
  class="card"
  style="left:{leftPercentage}"
  on:mouseover|preventDefault={handleMouseOver}
  on:focus|preventDefault={handleMouseOver}
  on:mouseout={handleMouseOut}
  on:blur={handleMouseOver}
>
  <button class="zh-name">{zhName}</button><br />
  <button class="en-name">{enName}</button><br />
  <button><b style="color:#000000; font-size=2vw;">{jobTitle}</b></button><br />
</div>

<style>
  .card,
  .avatar,
  .dialog,
  .__shadow,
  .text {
    position: absolute;
    width: 35vh;
    margin-left: -17.5vh;
  }

  .dialog {
    z-index: 3;
    height: 20vh;
    top: 2%;
  }

  .text {
    z-index: 4;
    height: 16.5vh;
    top: 2%;
    font-size: 1.5em;
    text-align: center;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .avatar,
  .__shadow {
    height: 35vh;
    top: 21vh;
  }

  .avatar {
    z-index: 3;
  }
  .avatar:hover {
    cursor: pointer;
  }

  .__shadow {
    z-index: -1;
  }

  .card {
    z-index: 3;
    height: 22vh;
    top: 63vh;
  }

  .card,
  button {
    text-align: center;
    line-height: 1.2;
    background-color: transparent;
    border: 0;
  }

  .zh-name,
  .en-name {
    font-size: 1.5vw;
    color: #686868;
  }

  @media only screen and (max-width: 1000px) {
    .zh-name,
    .en-name {
      font-size: 1em;
    }
  }

  @media (max-aspect-ratio: 5/7) {
    .avatar,
    .__shadow {
      top: 17.5vh;
    }

    .card {
      top: 60vh;
    }

    .text {
      width: 32vw;
      margin-left: -16vw;
      font-size: 1em;
    }

    .dialog {
      width: 32vw;
      margin-left: -16vw;
      height: 15vh;
      top: 4%;
    }
  }
</style>
