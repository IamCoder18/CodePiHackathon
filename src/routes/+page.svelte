<script lang="ts">
    import Navbar from '$lib/components/navbar.svelte';
    import Question from '$lib/components/question.svelte';

    let { data } = $props();

    $effect(()=>{
        console.log(data.cachedData)
    })

</script>

<Navbar currentPage="Home"></Navbar>

<table style="width: 100%; height: 570px;">
	<tbody class="maxSize">
        <tr class="h-16"></tr>
		<tr class="maxSize" style="height:330px">
			<td style="width: 49.99%; height: 100%;">
                <div class="m-auto text-center w-fit">
                    <h1 class="text-6xl font-extrabold tracking-tight lg:text-5xl drop-shadow-glow">Welcome to Aarav Labs</h1>
                    <h1 class="text-xl font-semibold tracking-tight lg:text-2xl w-3/4 m-auto mt-8">Learn Prealgebra, Algebra, Geometry, Counting & Probability, Number Theory, Precalculus, and more with our large set of questions and AI analysis.</h1>
                </div>
            </td>
			<td style="width: 49.99%; height: 100%;">
                <div class="m-auto text-center w-3/4 h-full text-start">
                    <Question></Question>
                </div>
            </td>
		</tr>
        <tr class="h-32"></tr>
        <tr class="maxSize" style="height:330px">
			<td style="width: 49.99%; height: 100%;">
                <div class="m-auto text-center w-fit">
                    Image here
                </div>
            </td>
            <td style="width: 49.99%; height: 100%;">
                <div class="m-auto text-center w-fit">
                    <h1 class="text-5xl font-extrabold tracking-tight lg:text-4xl">AI Answer Analysis</h1>
                    <h1 class="text-xl font-semibold tracking-tight lg:text-2xl w-3/4 m-auto mt-8">AI answer analysis makes you show your work and helps you if you get stuck in any step.</h1>
                </div>
            </td>
		</tr>
        <tr class="h-32"></tr>
        <tr class="maxSize" style="height:330px">
			<td style="width: 49.99%; height: 100%;">
                <div class="m-auto text-center w-fit">
                    <h1 class="text-5xl font-extrabold tracking-tight lg:text-4xl">Great Questions and Explaination</h1>
                    <h1 class="text-xl font-semibold tracking-tight lg:text-2xl w-3/4 m-auto mt-8">Over 1200 questions in all topics with amazing explaination and rich formatting.</h1>
                </div>
            </td>
            <td style="width: 49.99%; height: 100%;">
                <div class="m-auto text-center w-fit">
                    Image here
                </div>
            </td>
		</tr>
	</tbody>
</table>
