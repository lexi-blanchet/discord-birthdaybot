# Discord WebHook BirthdayBot

Lightweight Birthday bot, give it a webhook secret in an environment file and an ICS file of all birthdays

Addresses a gap in discord bots that obnoxiously never support just reading from an existing google calendar and making a post but instead want everything loaded into a private database hosted by SomeGuy™ on a backend that has no guarantee to exist a month from now.

Yes I'm mad.

```bash
# Add below to crontab -e for daily at 6 am
#   0 6 * * * /snap/bin/docker compose -f /your/git/docker-compose.yml up -d
```