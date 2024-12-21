<script lang="ts">
    import Navbar from '$lib/components/navbar.svelte';
    import Question from '$lib/components/question.svelte';
</script>

<Navbar currentPage="Practice"></Navbar>

<div class="absolute m-auto h-fit w-1/2 inset-0">
    <Question></Question>
</div>