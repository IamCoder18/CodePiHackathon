<script lang="ts">
	import * as Card from '$lib/components/ui/card';
	import { Button } from '$lib/components/ui/button';
	import { Textarea } from '$lib/components/ui/textarea';
	import { Input } from '$lib/components/ui/input';
	import katex from 'katex';
	import { browser } from '$app/environment';

	let outputString = '';

	function renderMath(input: string, displayMode: boolean): string {
		return katex.renderToString(String.raw({ raw: input }), {
			displayMode: displayMode,
            throwOnError: false
		});
	}

	function processString(input: string): string {
		// Finds $$ and \(\)
		let inlineRegex = [/(?<!\\)\$\s*[\s\S]*?(?<!\\)\$/g, /(?<!\\)\\\(\s*[\s\S]*?(?<!\\)\\\)/g];
		// Finds $$$$ and \[\]
		let displayRegex = [/(?<!\\)\$\$\s*[\s\S]*?(?<!\\)\$\$/g, /(?<!\\)\\\[\s*[\s\S]*?(?<!\\)\\\]/g];

		let output = input;

		
        let match = undefined;
        while ((match = inlineRegex[0].exec(output)) != null) {
            const startIndex = match.index;
            const endIndex = match.index + match[0].length;

            let value = renderMath(match[0].substring(1, match[0].length - 1), false);
            output =
                output.substring(0, startIndex) + value + output.substring(endIndex, output.length);
        }

        match = undefined;
        while ((match = inlineRegex[1].exec(output)) != null) {
            const startIndex = match.index;
            const endIndex = match.index + match[0].length;

            let value = renderMath(match[0].substring(2, match[0].length - 2), false);
            output =
                output.substring(0, startIndex) + value + output.substring(endIndex, output.length);
        }

        match = undefined;
        while ((match = displayRegex[0].exec(output)) != null) {
            const startIndex = match.index;
            const endIndex = match.index + match[0].length;

            let value = renderMath(match[0].substring(1, match[0].length - 1), true);
            output =
                output.substring(0, startIndex) + value + output.substring(endIndex, output.length);
        }

        match = undefined;
        while ((match = displayRegex[1].exec(output)) != null) {
            const startIndex = match.index;
            const endIndex = match.index + match[0].length;

            let value = renderMath(match[0].substring(2, match[0].length - 2), true);
            output =
                output.substring(0, startIndex) + value + output.substring(endIndex, output.length);
        }

        return output;
	}

	const inputString = String.raw`Let \[f(x) = \begin{cases} 2x^2 - 3&\text{if } x\le 2, \\ ax + 4 &\text{if } x>2. \end{cases} \]Find $a$ if the graph of $y=f(x)$ is continuous (which means the graph can be drawn without lifting your pencil from the paper).`;
	outputString = processString(inputString);
</script>

{#if browser}
	<link
		rel="stylesheet"
		href="https://cdn.jsdelivr.net/npm/katex@0.16.18/dist/katex.min.css"
		integrity="sha384-veTAhWILPOotXm+kbR5uY7dRamYLJf58I7P+hJhjeuc7hsMAkJHTsPahAl0hBST0"
		crossorigin="anonymous"
	/>
{/if}

<Card.Root>
	<Card.Header>
		<Card.Title>{@html outputString}</Card.Title>
		<Card.Description>Algebra - Level 5</Card.Description>
	</Card.Header>
	<Card.Content>
		Steps:
		<Textarea id="input" />
		<br />
		Answer:
		<Input />
	</Card.Content>
	<Card.Footer>
		<Button variant="default">Submit</Button>
	</Card.Footer>
</Card.Root>
