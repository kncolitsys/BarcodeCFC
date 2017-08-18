<cfsetting showdebugoutput="false" />

<cfscript>
b = application.barcode;

ba = b.writeQRCode("http://www.millemultimedia.it");

</cfscript>
<h1>My QRccode</h1>
<cfimage 
    action = "writeToBrowser" 
    source = "#ba#">

<hr>
    