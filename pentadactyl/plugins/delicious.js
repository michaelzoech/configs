"use strict";
XML.ignoreWhitespace = false;
XML.prettyPrinting = false;
var INFO =
<plugin name="delicious" version="1.0.0"
	href="http://0x2a.at"
	summary="Delicious"
	xmlns={NS}>
	<author email="michi.zoech+pentadactyl@gmail.com">Michael Zoech</author>
	<license href="http://opensource.org/licenses/mit-license.php">MIT</license>
	<project name="Pentadactyl" min-version="1.0" />
</plugin>;

commands.addUserCommand(['delicious'], "Save page as a bookmark on delicious.com",
	function (args) {
		var url = "https://api.del.icio.us/v1/posts/add?";
		url += "&url=" + encodeURIComponent(buffer.URL);
		url += "&description=" + encodeURIComponent(buffer.title);
		url += "&tags=" + encodeURIComponent(args.string);
		url += "&replace=no";
		var xhr = new XMLHttpRequest();
		xhr.open("POST", url, false);
		xhr.send(null);
		var xml = (new DOMParser()).parseFromString(xhr.responseText, "text/xml");
		var status = xml.getElementsByTagName('result')[0].getAttribute('code');
		liberator.echo(status);
	});

commands.addUserCommand(['toread'], "Save page tagged as toread on Delicious",
  function(args) {
    var url = "https://api.del.icio.us/v1/posts/add?";
    url += "&url=" + encodeURIComponent(buffer.URL);
    url += "&description=" + encodeURIComponent(buffer.title);
    url += "&tags=toread";
    url += "&replace=no";
    var xhr = new XMLHttpRequest();
    xhr.open("POST", url, false);
    xhr.send(null);
    var xml = (new DOMParser()).parseFromString(xhr.responseText, "text/xml");
	var status = xml.getElementsByTagName('result')[0].getAttribute('code');
    liberator.echo(status);
  });

