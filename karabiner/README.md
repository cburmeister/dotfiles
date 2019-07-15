karabiner
===

You must restart Karabiner after linking the configuration directory:
```bash
launchctl kickstart -k gui/`id -u`/org.pqrs.karabiner.karabiner_console_user_server
```

See https://pqrs.org/osx/karabiner/document.html#configuration-file-path
