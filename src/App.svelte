<script>
import Home from './routes/Home.svelte'
import About from './routes/About.svelte'
import Router from 'svelte-spa-router'
</script>

<main>
    <Router routes={{
        '/': Home,
        '/about': About
    }} />
</main>

<style>

</style>