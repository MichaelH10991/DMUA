# Discogs Marketplace Updates Alerter
A Service that updates me when someone adds a listing for an album I am
watching. 

## What does it do?

- Alerts when a new album gets listed (via email)
- Lists the average price for an album I am watching
- Lists LP's specifically
- Lists initial LP releases, alerting when an album gets added

## What are the technologies

- Bash
- Discogs API

## Usage

Run `handler.sh` to create a list and subsequently run `handler.sh` to check for changes.

When adding a new master id to the list, you should run `main.sh`. if you forget and run `handler.sh` instead it'll probs freak out but should re-calibrate and everything should work ok running `handler.sh` again.

Currently and stupidly, the masters list is defined in both the handler and main, this will create an inconsistent state if you forget to copy the masters list into both.

TODO: pass in id to `main.sh $id` so that main only updates state of single release