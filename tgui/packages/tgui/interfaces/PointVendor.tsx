import { classes } from 'common/react';
import { useBackend } from '../backend';
import { Box, Button, Section, Table, Tabs } from '../components';
import { Window } from '../layouts';

type UserData =
{
  name: string,
  job: string,
  points: number,
}

type ProductData =
{
  name: string,
  path: string,
  price: number,
  category: string,
  ref: string,
}

type VendorData =
{
  vendorType: string,
  user: UserData,
  products: ProductData[],
}

export const PointVendor = (props, context) => {
  const { act, data } = useBackend<VendorData>(context);
  const {
    user,
    products,
    vendorType,
  } = data;

  return (
    <Window
      width={450}
      height={600}>
      <Window.Content scrollable>
        <Tabs vertical>
          <Tabs.Tab
            key={i}
            color="transparent"
            selected={i === pageIndex}
            onClick={() => setCategory(i)}>
            {story.meta.title}
          </Tabs.Tab>
          {stories.map((story, i) => (
            <Tabs.Tab
              key={i}
              color="transparent"
              selected={i === pageIndex}
              onClick={() => setCategory(i)}>
              {story.meta.title}
            </Tabs.Tab>
          ))}
        </Tabs>
        <Section title="User">
          {user && (
            <Box>
              Welcome, <b>{user.name || "Unknown"}</b>,
              {' '}
              <b>{user.job || "Unemployed"}</b>!
              <br />
              Your balance is <b>{user.points} {vendorType} points</b>. <br />
              <Button

              />
            </Box>
          ) || (
            <Box color="light-gray">
              No ID detected.<br />
              Please insert your ID to continue.
            </Box>
          )}
        </Section>
        <Section title="Equipment">
          <Table>
            {products.map((product => {
              return (
                <Table.Row key={product.name}>
                  <Table.Cell>
                    <span
                      className={classes(['vending32x32', product.path])}
                      style={{
                        'vertical-align': 'middle',
                      }} />
                    {' '}<b>{product.name}</b>
                  </Table.Cell>
                  <Table.Cell>
                    <Button
                      style={{
                        'min-width': '95px',
                        'text-align': 'center',
                      }}
                      disabled={!data.user
                        || product.price > data.user.points}
                      content={product.price + ' points'}
                      onClick={() => act('purchase', {
                        'ref': product.ref,
                      })} />
                  </Table.Cell>
                </Table.Row>
              );
            }))}
          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};
