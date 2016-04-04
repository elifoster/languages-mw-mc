# languages-mw-mc
A simple Ruby web API to get MediaWiki or Minecraft language codes from one another. This was made specifically for the Minecraft and FTB Gamepedias, so it might not work on your personal wiki.

## Usage
### /mc
This endpoint will output the Minecraft language code for the given MediaWiki language code in the `lang` parameter. It outputs a simple string.

### /mw
This endpoint will output the MediaWiki language code for the given Minecraft language code in the `lang` parameter. If more than one are available, it will separate them by a comma and a space. It outputs a simple string.
