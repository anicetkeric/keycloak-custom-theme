<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false showAnotherWayIfPresent=true>
<!DOCTYPE html>
<html class="${properties.kcHtmlClass!}" <#if realm.internationalizationEnabled>lang="${locale.currentLanguageTag}"</#if>>

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <#list meta?split('==') as pair>
                <meta name="${pair[0]}" content="${pair[1]}"/>
            </#list>
        </#list>
    </#if>
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
</head>

<body class="${properties.kcBodyClass!}">
    <div class="${properties.kcLoginClass!}">
        <!-- Language selector -->
        <#if realm.internationalizationEnabled && locale.supported?size gt 1>
            <div id="kc-locale">
                <div id="kc-locale-wrapper" class="${properties.kcLocaleWrapperClass!}">
                    <div class="kc-dropdown" id="kc-locale-dropdown">
                        <a href="#" id="kc-current-locale-link">${locale.current}</a>
                        <ul>
                            <#list locale.supported as l>
                                <li class="kc-dropdown-item"><a href="${l.url}">${l.label}</a></li>
                            </#list>
                        </ul>
                    </div>
                </div>
            </div>
        </#if>

        <div class="${properties.kcContainerClass!}">
            <div class="${properties.kcContentClass!}">
                <div class="card-pf">
                    <!-- Title inside the form -->
                    <div class="login-pf-header">
                        <h1>${msg("loginAccountTitle")}</h1>
                    </div>

                    <div id="kc-content">
                        <div id="kc-content-wrapper">
                            <#-- App-initiated actions should not see warning messages about the need to complete the action -->
                            <#-- during login.                                                                               -->
                            <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                                <div class="alert alert-${message.type}">
                                    <#if message.type = 'success'><span class="pficon pficon-ok"></span></#if>
                                    <#if message.type = 'warning'><span class="pficon pficon-warning-triangle-o"></span></#if>
                                    <#if message.type = 'error'><span class="pficon pficon-error-circle-o"></span></#if>
                                    <#if message.type = 'info'><span class="pficon pficon-info"></span></#if>
                                    <span class="kc-feedback-text">${kcSanitize(message.summary)?no_esc}</span>
                                </div>
                            </#if>

                            <#nested "form">

                            <#if displayInfo>
                                <div id="kc-info" class="${properties.kcSignUpClass!}">
                                    <div id="kc-info-wrapper" class="${properties.kcInfoAreaWrapperClass!}">
                                        <#nested "info">
                                    </div>
                                </div>
                            </#if>

                            <#if realm.password && social.providers??>
                                <#nested "socialProviders">
                            </#if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        // Language dropdown functionality
        document.addEventListener('DOMContentLoaded', function() {
            const dropdown = document.getElementById('kc-locale-dropdown');
            const currentLink = document.getElementById('kc-current-locale-link');

            if (dropdown && currentLink) {
                currentLink.addEventListener('click', function(e) {
                    e.preventDefault();
                    const ul = dropdown.querySelector('ul');
                    if (ul) {
                        ul.style.display = ul.style.display === 'block' ? 'none' : 'block';
                    }
                });

                // Close dropdown when clicking outside
                document.addEventListener('click', function(e) {
                    if (!dropdown.contains(e.target)) {
                        const ul = dropdown.querySelector('ul');
                        if (ul) {
                            ul.style.display = 'none';
                        }
                    }
                });
            }
        });
    </script>
</body>
</html>
</#macro>
