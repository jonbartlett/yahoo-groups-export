# Yahoo Group forum data exporter
Export Yahoo Groups forum data to a MongoDB database.

All group messages will be exported into a MongoDB Collection. For user email addresses to be exported, you will need to be an administrator for the Yahoo Group. Currently only message text is exported as there is no obvious way to access message attachments.

The last message read is stored in a config file so that incremental (delta) updates to the MongoDB collection can be performed or to resume a broken export.

Built to move a long standing Yahoo Groups forum over to [Discourse](https://www.discourse.org/). Watch out for a future contribution to the Discourse [repo](https://github.com/discourse/discourse) for importing Yahoo Groups data.

## Makes use of:

- Yahoo Groups API to retrieve message: ```https://groups.yahoo.com/api/v1/groups/<group name>/messages/1/```
- Mechanize to simulate logging in as the Yahoo Groups API does not support OAuth.
- A config file ```.config``` to capture Yahoo Group info

## Usage

- Install MongoDB
- Modify file .config.yaml
- Run ```ruby bin/yg-export.rb```
- Wait


