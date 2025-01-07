<script lang="ts">
	import * as Card from '$lib/components/ui/card';
	import { Button } from '$lib/components/ui/button';
	import { Input } from '$lib/components/ui/input';
	import katex from 'katex';
	import { browser } from '$app/environment';
	import { onMount } from 'svelte';

	function renderMathSegment(input: string, displayMode: boolean): string {
		try {
			return katex.renderToString(String.raw({ raw: input }), {
				displayMode: displayMode,
				throwOnError: true
			});
		} catch {
			return '- An error occured while rendering math -';
		}
	}

	// TODO: Cleanup this function
	function renderMath(input: string): string {
		// Finds $$ and \(\)
		let inlineRegex = [/(?<!\\)\$\s*[\s\S]*?(?<!\\)\$/g, /(?<!\\)\\\(\s*[\s\S]*?(?<!\\)\\\)/g];
		// Finds $$$$ and \[\]
		let displayRegex = [/(?<!\\)\$\$\s*[\s\S]*?(?<!\\)\$\$/g, /(?<!\\)\\\[\s*[\s\S]*?(?<!\\)\\\]/g];

		let output = input.replace(/\n/g, '<br />');

		let match = undefined;
		while ((match = inlineRegex[0].exec(output)) != null) {
			const startIndex = match.index;
			const endIndex = match.index + match[0].length;

			let value = renderMathSegment(match[0].substring(1, match[0].length - 1), false);
			output = output.substring(0, startIndex) + value + output.substring(endIndex, output.length);
		}

		match = undefined;
		while ((match = inlineRegex[1].exec(output)) != null) {
			const startIndex = match.index;
			const endIndex = match.index + match[0].length;

			let value = renderMathSegment(match[0].substring(2, match[0].length - 2), false);
			output = output.substring(0, startIndex) + value + output.substring(endIndex, output.length);
		}

		match = undefined;
		while ((match = displayRegex[0].exec(output)) != null) {
			const startIndex = match.index;
			const endIndex = match.index + match[0].length;

			let value = renderMathSegment(match[0].substring(1, match[0].length - 1), true);
			output = output.substring(0, startIndex) + value + output.substring(endIndex, output.length);
		}

		match = undefined;
		while ((match = displayRegex[1].exec(output)) != null) {
			const startIndex = match.index;
			const endIndex = match.index + match[0].length;

			let value = renderMathSegment(match[0].substring(2, match[0].length - 2), true);
			output = output.substring(0, startIndex) + value + output.substring(endIndex, output.length);
		}

		return output;
	}

	let question = $state('');
	let renderedQuestion = $state('');
	$effect(() => {
		renderedQuestion = renderMath(question);
	});

	let steps = $state('');
	let renderedSteps = $state('');
	$effect(() => {
		renderedSteps = renderMath(steps);
	});

	let answer = $state('');
	let renderedAnswer = $state('');
	$effect(() => {
		renderedAnswer = renderMath(answer);
	});

	let { topic = $bindable('all'), difficulty = $bindable('all') } = $props<{
		topic: string;
		difficulty: string;
	}>();

	const acceptedTopics = [
		'all',
		'algebra',
		'intermediate_algebra',
		'prealgebra',
		'geometry',
		'number_theory',
		'counting_probability',
		'precalculus'
	];
	const convertedTopics = [
		'all',
		'Algebra',
		'Intermediate Algebra',
		'Prealgebra',
		'Geometry',
		'Number Theory',
		'Counting & Probability',
		'Precalculus'
	];

	let renderedTopic = $state();
	let renderedDifficulty = $state();

    let previousTopic = $state(topic)
    let previousDifficulty = $state(difficulty)

	const renderQuestion = () => {
		fetch(`http://localhost:3001/?topic=${topic}&difficulty=${difficulty}`)
			.then((response) => {
				return response.json();
			})
			.then((body) => {
				console.log(body);

				question = body.question;
				renderedTopic = body.topic;
				renderedDifficulty = body.difficulty;
			});
	};

    $effect(() => {
        if (topic != previousTopic){
            // Topic changed, get a new question
            renderQuestion()
            previousTopic = topic
        }
    })

    $effect(() => {
        if (difficulty != previousDifficulty){
            // Topic changed, get a new question
            renderQuestion()
            previousDifficulty = difficulty
        }
    })

    // TODO: Sending the answer in the API allows people to make userscripts or extensions that can efficiently cheat EVERY SINGLE QUESTION!

	onMount(renderQuestion);
</script>

{#if browser}
	<link
		rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/katex@0.16.18/dist/katex.min.css"
		integrity="sha384-veTAhWILPOotXm+kbR5uY7dRamYLJf58I7P+hJhjeuc7hsMAkJHTsPahAl0hBST0"
		crossorigin="anonymous"
	/>
{/if}

<Card.Root class="drop-shadow-glow">
	<Card.Header>
        <!-- TODO: MAKE SCROLLABLE!!! -->
		<Card.Title class="font-normal">{@html renderedQuestion}</Card.Title>
		<Card.Description>{renderedTopic} - Level {renderedDifficulty}</Card.Description>
	</Card.Header>
	<Card.Content>
		<Button variant="default" onclick={renderQuestion}>Skip Question</Button><br /><br />
		<span class="font-semibold">Steps: </span> <br />
		<textarea
			bind:value={steps}
			class="flex min-h-[60px] w-full rounded-md border border-input bg-transparent px-3 py-2 text-base shadow-sm placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:cursor-not-allowed disabled:opacity-50 md:text-sm"
		>
		</textarea>
		{#if renderedSteps.replaceAll(' ', '').replaceAll('<br/>', '') != ''}
			<br />
			<span>Preview: </span>
			<div
				class="mb-4 w-full rounded-md border bg-transparent px-3 py-2 text-base shadow-sm md:text-sm"
			>
				<span bind:innerHTML={renderedSteps} contenteditable="false"></span>
			</div>
		{/if}
		<br />
		<span class="font-semibold">Answer: </span> <br />
		<Input bind:value={answer}></Input>
		{#if renderedAnswer.replaceAll(' ', '').replaceAll('<br/>', '') != ''}
			<br />
			<span>Preview: </span>
			<div
				class="mb-4 w-full rounded-md border bg-transparent px-3 py-2 text-base shadow-sm md:text-sm"
			>
				<span bind:innerHTML={renderedAnswer} contenteditable="false"></span>
			</div>
		{/if}
	</Card.Content>
	<Card.Footer>
		<Button variant="default">Submit</Button>
	</Card.Footer>
</Card.Root>
