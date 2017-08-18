<cfapplication name="barcode" />

<cfif not structKeyExists( application, 'barcode') or structKeyExists( url, 'reload' )>

	<cfscript>
	application.barcode = new Barcode();
	</cfscript>

</cfif>