<script>
    import Navbar from './components/Navbar.svelte'
</script>


<about>
    <Navbar/>
    <div class="about-body">
        <div class="avatar" id="avatar-1"></div>
        <div class="avatar" id="avatar-2"></div>
        <div class="avatar" id="avatar-3"></div>
    </div>
</about>

<style>
    .about-body {
        z-index: 1;
        overflow: hidden;
        position: absolute;
        height: 90%;
        width: 100%;
        background: url("./res/about-bg.jpg");
        background-size: cover;
        background-repeat: no-repeat;
        background-position: center;
    }

    .avatar {
        position: absolute;
        z-index: 3;
        height: 250px;
        width: 250px;
        margin-left: -125px;
        top: 24%;
    }

    #avatar-1 {
        left: 17.5%;
        background: url("./res/02.png");
        background-size: cover;
    }
    #avatar-2 {
        left: 50%;
        background: url("./res/01.png");
        background-size: cover;
    }
    #avatar-3 {
        left: 82.5%;
        background: url("./res/03.png");
        background-size: cover;
    }
</style>


