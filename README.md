Logstash Cookbook
=====================
Logstash is the logging service.

to use the logging service, include `logstash::agent` recipe in your role and set the 'log' attribute.

Requirements
------------
### cookbooks
- `apache2` - used as a proxy for elasticsearch
- `bluepill` - manages the logstash service

#### packages
- `java` - logstash needs java

Attributes
----------

#### logstash::agent
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['log']</tt></td>
    <td>Hash</td>
    <td>list of log files</td>
    <td><tt>(Syslog)</tt></td>
  </tr>
  <tr>
    <td><tt>['log'][filename]</tt></td>
    <td>Hash</td>
    <td>list of attributes</td>
    <td><tt>None</tt></td>
  </tr>
  <tr>
    <td><tt>['log'][filename]['type']</tt></td>
    <td>String</td>
    <td>type of log</td>
    <td><tt>None</tt></td>
  </tr>
</table>


Usage
-----
```json
{
  "name":"my_node",
  "default_attributes": {
    "/data/play/piper/current/logs/system.out": {
      "type": "play"
    }
  },
  "run_list": [
    "recipe[logstash]"
  ]
}
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
