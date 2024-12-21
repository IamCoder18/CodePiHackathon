<script lang="ts">
	import * as Card from '$lib/components/ui/card';
    import { Button } from "$lib/components/ui/button";
    import { Textarea } from "$lib/components/ui/textarea";
</script>

<Card.Root>
	<Card.Header>
		<Card.Title>
                  {@html `
            <p>Let
<math display="inline" xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><mo stretchy="true" form="prefix">(</mo><mi>x</mi><mo>,</mo><mi>y</mi><mo stretchy="true" form="postfix">)</mo></mrow><annotation encoding="application/x-tex">(x,y)</annotation></semantics></math>
be an ordered pair of real numbers that satisfies the equation
<math display="inline" xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mrow><msup><mi>x</mi><mn>2</mn></msup><mo>+</mo><msup><mi>y</mi><mn>2</mn></msup><mo>=</mo><mn>14</mn><mi>x</mi><mo>+</mo><mn>48</mn><mi>y</mi></mrow><annotation encoding="application/x-tex">x^2+y^2=14x+48y</annotation></semantics></math>.
What is the minimum value of
<math display="inline" xmlns="http://www.w3.org/1998/Math/MathML"><semantics><mi>y</mi><annotation encoding="application/x-tex">y</annotation></semantics></math>?</p>
`}  
        </Card.Title>
		<Card.Description>Algebra - Level 5</Card.Description>
	</Card.Header>
	<Card.Content>
        Steps:
		<Textarea />
        <br>
        Answer:
		<Textarea />
	</Card.Content>
	<Card.Footer>
		<Button variant="default">Submit</Button>
	</Card.Footer>
</Card.Root>
