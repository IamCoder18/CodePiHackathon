<script lang="ts">
	import * as Card from '$lib/components/ui/card';
	import { Button } from '$lib/components/ui/button';
	import { Input } from '$lib/components/ui/input';
	import katex from 'katex';
	import { browser } from '$app/environment';

	function renderMathSegment(input: string, displayMode: boolean): string {
		return katex.renderToString(String.raw({ raw: input }), {
			displayMode: displayMode,
			throwOnError: false
		});
	}

	// TODO: Cleanup this function
	function renderMath(input: string): string {
		// Finds $$ and \(\)
		let inlineRegex = [/(?<!\\)\$\s*[\s\S]*?(?<!\\)\$/g, /(?<!\\)\\\(\s*[\s\S]*?(?<!\\)\\\)/g];
		// Finds $$$$ and \[\]
		let displayRegex = [/(?<!\\)\$\$\s*[\s\S]*?(?<!\\)\$\$/g, /(?<!\\)\\\[\s*[\s\S]*?(?<!\\)\\\]/g];

		let output = input.replace(/\n/g, "<br />")

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

	const question = String.raw`Let \[f(x) = \begin{cases} 2x^2 - 3&\text{if } x\le 2, \\ ax + 4 &\text{if } x>2. \end{cases} \]Find $a$ if the graph of $y=f(x)$ is continuous (which means the graph can be drawn without lifting your pencil from the paper).`;
	const renderedQuestion = renderMath(question);

	const topic = 'Algebra';
	const difficulty = '5';

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
		<Card.Title class="font-normal">{@html renderedQuestion}</Card.Title>
		<Card.Description>{topic} - Level {difficulty}</Card.Description>
	</Card.Header>
	<Card.Content>
		<span class="font-semibold">Steps: </span> <br />
		<textarea
			bind:value={steps}
			class="flex min-h-[60px] w-full rounded-md border border-input bg-transparent px-3 py-2 text-base shadow-sm placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring disabled:cursor-not-allowed disabled:opacity-50 md:text-sm"
		>
		</textarea>
		{#if renderedSteps.replaceAll(' ', '').replaceAll("<br/>", "") != ''}
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
		<Input
			bind:value={answer}></Input>
		{#if renderedAnswer.replaceAll(' ', '').replaceAll("<br/>", "") != ''}
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
