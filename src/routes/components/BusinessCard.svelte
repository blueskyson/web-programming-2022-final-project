<script>
export let zhName;
export let enName;
export let jobTitle;
export let leftPercentage;
export let src;
</script>

<img {src} alt="" class="avatar" style="left:{leftPercentage}; "/>
<div class="card" style="left:{leftPercentage}">
    {zhName}<br/>
    {enName}<br/>
    {jobTitle}<br/>
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
    background: url({avatarURL});
    background-size: cover;
}

.card {
    height: 22vh;
    top: 61vh;
    text-align: center;
    font-size: 1.5em;
    line-height: 2.3;
    background-color: transparent;
    border: 0;
}

</style>
