import { useBackend } from '../backend';
import { Button, Flex, Section } from '../components';
import { Window } from '../layouts';

export const BountyMachine = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    bountys = [],
  } = data;
  return (
    <Window resizable>
      <Window.Content scrollable>
        <Section title="Bountys">
          <Flex mb={1}>
            {bountys?.map((bounty) => (
            <Flex.Item label="Bounty" grow={1} m={2} p={2} height="50vh" backgroundColor="black">
              {bounty}
            </Flex.Item>
            ))}
          </Flex>
          <Button
            content="Refresh Bounties"
            onClick={() => act('refresh')} />
        </Section>
      </Window.Content>
    </Window>
  );
};
