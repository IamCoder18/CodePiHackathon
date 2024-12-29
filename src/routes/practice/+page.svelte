<script lang="ts">
	import Navbar from '$lib/components/navbar.svelte';
	import Question from '$lib/components/question.svelte';
    import PracticeSidebar from '$lib/components/practiceSidebar.svelte';
</script>

<div class="flex flex-col h-full">
	<Navbar currentPage="Practice"></Navbar>

    <div class="flex flex-1">
        <PracticeSidebar></PracticeSidebar>
        <div class="flex items-center justify-center flex-1">
            <div class="h-fit w-1/2">
                <Question></Question>
            </div>
        </div>
    </div>
</div>