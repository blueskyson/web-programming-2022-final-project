<script>
  /** @type {import('@sveltejs/kit').Load} */
  export function load({ error, status }) {
    return {
      props: {
        title: `${status}: ${error.message}`,
      },
    };
  }
  export let status;
</script>

<h1>{status}</h1>
