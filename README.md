# flower-shop

Simulates a flower shop that has decided to sell flowers in bundles.

## To run

```
bin/flower_shop
```

Then enter the quantity and bundle code on STDIN.

For example to ask for 15 L09 bundles, you would enter:

```
15 L09 
```

Hit Ctrl-C to finish.

## Piping orders

You can also pipe in a file containing all the orders

```
cat sample/order.txt | bin/flower_shop
```

## Running the test suite

```
rake test
```
