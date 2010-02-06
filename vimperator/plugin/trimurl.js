// Usage: Use :trim [<url>]
//        if url is omitted, uses the url of the current tab
//        Copies trimmed url to the clipboard

commands.addUserCommand (["trim"], "Tr.im a url and copy it to the clipboard",
  function (args) {
    var url = "http://tr.im/api/trim_simple?url=";
    if (args.length == 0) {
      url += escape(getBrowser().contentWindow.location.href);
    } else {
      url += escape(args[0]);
    }
    util.httpGet(url, function(req) {
      if (req.status == 200) {
        util.copyToClipboard(req.responseText);
        liberator.echo("Trim URL: " + req.responseText);
      } else {
        liberator.echoerr("Error contacting tr.im!\n");
      }
    });
  }
);

