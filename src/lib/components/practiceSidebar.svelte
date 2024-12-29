<script lang="ts">
	import * as Card from '$lib/components/ui/card';
	import * as Select from '$lib/components/ui/select';

	const topics = [
		{ value: 'algebra', label: 'Algebra' },
		{ value: 'intermediate_algebra', label: 'Intermediate Algebra' }
	];
</script>

<Card.Root class="m-8 min-w-96">
	<Card.Header>
		<Card.Title>Questions</Card.Title>
	</Card.Header>
	<Card.Content>
		Topic:
		<Select.Root
			selected={{
				value: "algebra",
				label: "Algebra"
			}}
		>
			<Select.Trigger class="w-[180px]">
				<Select.Value>Algebra</Select.Value>
			</Select.Trigger>
			<Select.Content>
				<Select.Item value="algebra">Algebra</Select.Item>
				<Select.Item value="intermediate_algebra">Intermediate Algebra</Select.Item>
				<Select.Item value="prealgebra">Prealgebra</Select.Item>
				<Select.Item value="geometry">Geometry</Select.Item>
				<Select.Item value="number_theory">Number Theory</Select.Item>
				<Select.Item value="counting_probability">Counting and Probability</Select.Item>
				<Select.Item value="precalculus">Precalculus</Select.Item>
			</Select.Content>
		</Select.Root>

		Question Difficulty
	</Card.Content>
	<Card.Header>
		<Card.Title>Title</Card.Title>
		<Card.Description>Description</Card.Description>
	</Card.Header>
	<Card.Content>Content</Card.Content>
</Card.Root>
