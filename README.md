Logstash Cookbook
=====================
Logstash is the logging service.

This cookbook does not add any logstash configuration files by default.  You should
have a wrapper cookbook either drop in a single file or use the logstash lwrp
as documented below.

Requirements
------------
### cookbooks
- `bluepill` - manages the logstash service
- `ark` - used to download and unpack logstash tarball
- `java` - installs java for logstash

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
    <td><tt>['logstash']['dir']['config']</tt></td>
    <td>String</td>
    <td>directory to store logstash configs</td>
    <td><tt>/etc/logstash</tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['dir']['bin']</tt></td>
    <td>String</td>
    <td>directory to put logstash jar file in</td>
    <td><tt>/opt/logstash</tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['version']</tt></td>
    <td>String</td>
    <td>version of logstash to use</td>
    <td><tt>1.3.3</tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['service_provider']</tt></td>
    <td>String</td>
    <td>process manager to run logstash with</td>
    <td><tt>upstart for debian, init for rhel/suse, bluepil for else</tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['user']</tt></td>
    <td>String</td>
    <td>owner of logstash</td>
    <td><tt>logstash</tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['uid']</tt></td>
    <td>Integer</td>
    <td>uid of logstash user</td>
    <td><tt>357</tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['group']</tt></td>
    <td>String</td>
    <td>logstash group</td>
    <td><tt>logstash</tt></td>
  </tr>
  <tr>
    <td><tt>['logstash']['uri']</tt></td>
    <td>String</td>
    <td>where to get logstash package</td>
    <td><tt>https://download.elasticsearch.org/logstash/logstash/</tt></td>
  </tr>
</table>

Resource/Provider
-----------------
This cookbook provides three resource providers, all of which work very similarly.

### Actions
All providers listed below use the same two providers

- **create** - creates the logstash plugin
- **delete** - removes the logstash plugin

### logstash_input

#### Attributes

- **plugin** - name of the plugin (ex. grok)
- **type** - input type
- **tags**
- **debug**
- **options** - plugin specific options such as community for snmptrap input

### logstash_filter

#### Attributes

- **plugin** - name of the plugin (ex. grok)
- **type** - input type
- **add_field**
- **add_tag**
- **remove_field**
- **remove_tag**
- **options** - plugin specific options such as locale for date filter

### logstash_output

#### Attributes

- **plugin** - name of the plugin (ex. grok)
- **type** - input type
- **debug**
- **options** - plugin specific options such as api_key for datadog output

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
- Author:: Richard Li(yli@tamu.edu)
- Author:: Jim Rosser(jarosser06@tamu.edu)

```text
copyright (C) 2014 Texas A&M University

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the “Software”), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies of the Software,
and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
```
