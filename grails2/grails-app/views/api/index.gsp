<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Swagger UI</title>
    <link href='//fonts.googleapis.com/css?family=Droid+Sans:400,700' rel='stylesheet' type='text/css'/>

    <link href="${g.resource(dir: 'css', file: 'reset.css')}" media='screen' rel='stylesheet' type='text/css'/>
    <link href="${g.resource(dir: 'css', file: 'screen.css')}" media='screen' rel='stylesheet' type='text/css'/>
    <script src="${g.resource(dir: 'js/swagger-lib', file: 'shred.bundle.js')}" type='text/javascript'></script>
    <script src="${g.resource(dir: 'js/swagger-lib', file: 'jquery-1.8.0.min.js')}" type='text/javascript'></script>
    <script src="${g.resource(dir: 'js/swagger-lib', file: 'jquery.slideto.min.js')}" type='text/javascript'></script>
    <script src="${g.resource(dir: 'js/swagger-lib', file: 'jquery.wiggle.min.js')}" type='text/javascript'></script>
    <script src="${g.resource(dir: 'js/swagger-lib', file: 'jquery.ba-bbq.min.js')}" type='text/javascript'></script>
    <script src="${g.resource(dir: 'js/swagger-lib', file: 'handlebars-1.0.0.js')}" type='text/javascript'></script>
    <script src="${g.resource(dir: 'js/swagger-lib', file: 'underscore-min.js')}" type='text/javascript'></script>
    <script src="${g.resource(dir: 'js/swagger-lib', file: 'backbone-min.js')}" type='text/javascript'></script>
    <script src="${g.resource(dir: 'js/swagger-lib', file: 'swagger.js')}" type='text/javascript'></script>
    <script src="${g.resource(dir: 'js/', file: 'swagger-ui.js')}" type='text/javascript'></script>
    <script src="${g.resource(dir: 'js/swagger-lib', file: 'highlight.7.3.pack.js')}" type='text/javascript'></script>

    <!-- enabling this will enable oauth2 implicit scope support -->
    <script src="${g.resource(dir: 'js/swagger-lib', file: 'swagger-oauth.js')}" type='text/javascript'></script>

    <script type="text/javascript">
        $(function () {
            window.swaggerUi = new SwaggerUi({
                url: "${g.createLink(controller: 'api', action: 'resources')}",
                dom_id: "swagger-ui-container",
                supportedSubmitMethods: ['get', 'post', 'put', 'delete'],
                onComplete: function (swaggerApi, swaggerUi) {
                    log("Loaded SwaggerUI");

                    if (typeof initOAuth == "function") {
                        /*
                         initOAuth({
                         clientId: "your-client-id",
                         realm: "your-realms",
                         appName: "your-app-name"
                         });
                         */
                    }
                    $('pre code').each(function (i, e) {
                        hljs.highlightBlock(e)
                    });

                    $('.toggleEndpointList:not([id])').each(function (i, e) {
                        e.textContent = e.textContent.replace(/-/g, '/');
                    })

                    $('.toggleOperation').each(function (i, e) {
                        e.textContent = e.textContent.split("/").pop()
                    })
                },
                onFailure: function (data) {
                    log("Unable to Load SwaggerUI");
                },
                docExpansion: "none",
                sorter: "alpha"
            });

            $('#input_apiKey').change(function () {
                var key = $('#input_apiKey')[0].value;
                log("key: " + key);
                if (key && key.trim() != "") {
                    log("added key " + key);
                    window.authorizations.add("key", new ApiKeyAuthorization("api_key", key, "query"));
                }
            });
            window.swaggerUi.load();
        });
    </script>
</head>

<body class="swagger-section">
<div id='header'>
    <div class="swagger-ui-wrap">
        <a id="logo" href="${g.createLink(controller: 'api')}">swagger</a>

        <form id='api_selector'>
            <div class='input'>
                <input placeholder="http://example.com/api" id="input_baseUrl" name="baseUrl"
                       type="text" readonly="true"/>
            </div>

            <div class='input'>
                <input placeholder="api_key" id="input_apiKey" name="apiKey" type="text"/>
            </div>

            <div class='input'><a id="explore" href="#">Explore</a></div>
        </form>
    </div>
</div>

<div id="message-bar" class="swagger-ui-wrap">&nbsp;</div>

<div id="swagger-ui-container" class="swagger-ui-wrap"></div>
</body>
</html>
