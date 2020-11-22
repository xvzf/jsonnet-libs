{
  local configMap = $.core.v1.configMap,

  nginx_html:
    local vars = {
      link_stanzas: [
        |||
          <li><a href="/%(path)s%(params)s">%(title)s</a></li>
        ||| % ({ params: '' } + service)
        for service in $._config.admin_services
      ],
      links: std.join('\n', self.link_stanzas),
    };

    configMap.new('nginx-html') +
    configMap.withData({
      'index.html': |||
        <html>
          <head><title>Admin</title></head>
          <body>
            <h1>Admin</h1>
            <ul>
              %(links)s
            </ul>
          </body>
        </html>
      ||| % vars,
    }),
}
