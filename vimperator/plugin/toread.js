// Usage: Use :toread command
// Usage: if successfully posted you will see "done" echoed
// Usage: if already tagged you will see "item already exists"

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
