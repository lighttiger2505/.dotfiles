// ESC
map('<Ctrl-c>', 'ESC');
map('<Ctrl-[>', 'ESC');
vmap('<Ctrl-c>', 'ESC');
vmap('<Ctrl-[>', 'ESC');
imap('<Ctrl-c>', 'ESC');
imap('<Ctrl-[>', 'ESC');

// Go one tab left/right
api.map('J', 'R');
api.map('K', 'E');

// Go one tab history back/forward
api.map('H', 'S');
api.map('L', 'D');

// Disable emoji popup window
iunmap(":");
