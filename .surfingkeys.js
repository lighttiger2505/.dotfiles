// set theme
settings.theme = `
.sk_theme {
    font-family: Input Sans Condensed, Charcoal, sans-serif;
    font-size: 10pt;
    background: #24272e;
    color: #abb2bf;
}
.sk_theme tbody {
    color: #fff;
}
.sk_theme input {
    color: #d0d0d0;
}
.sk_theme .url {
    color: #61afef;
}
.sk_theme .annotation {
    color: #56b6c2;
}
.sk_theme .omnibar_highlight {
    color: #528bff;
}
.sk_theme .omnibar_timestamp {
    color: #e5c07b;
}
.sk_theme .omnibar_visitcount {
    color: #98c379;
}
.sk_theme #sk_omnibarSearchResult>ul>li:nth-child(odd) {
    background: #303030;
}
.sk_theme #sk_omnibarSearchResult>ul>li.focused {
    background: #3e4452;
}
#sk_status, #sk_find {
    font-size: 20pt;
}`;

/*
  global
  Clipboard
  Front
  Hints
  Insert
  Normal
  RUNTIME
  event
  isEditable
  iunmap
  map
  mapkey
  searchSelectedWith
  settings
  tabOpenLink
  unmap
 */

// ESC
map('<Ctrl-c>', 'ESC');
map('<Ctrl-[>', 'ESC');
vmap('<Ctrl-c>', 'ESC');
vmap('<Ctrl-[>', 'ESC');
imap('<Ctrl-c>', 'ESC');
imap('<Ctrl-[>', 'ESC');

// Go one tab left/right
map('J', 'R');
map('K', 'E');

// Go one tab history back/forward
map('H', 'S');
map('L', 'D');

// Disable emoji popup window
settings.startToShowEmoji = 0;
