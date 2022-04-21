<script>
export let zhName;
export let enName;
export let jobTitle;
export let leftPercentage;
export let src;
</script>

<img {src} alt="" class="avatar" style="left:{leftPercentage}; "/>
<div class="card" style="left:{leftPercentage}">
    <div class="zh-name">{zhName}</div><br/>
    <div class="en-name">{enName}</div><br/>
    <b style="color:#000000; font-size=2vw;">{jobTitle}</b><br/>
</div>

<style>

.card,
.avatar {
    position: absolute;
    z-index: 3;
    width: 35vh;
    margin-left: -17.5vh;
}

.avatar {
    height: 35vh;
    top: 21vh;
}

.card {
    height: 22vh;
    top: 63vh;
}

.card,
.card div {
    text-align: center;
    line-height: 1.2;
    background-color: transparent;
    border: 0;
}

.zh-name,
.en-name {
    font-size: 1.5vw;
    color : #686868;
}

</style>
