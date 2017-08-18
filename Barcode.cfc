<cfcomponent hint="">

	<cffunction name="init" access="public" returntype="Barcode" output="false" >
		<cfargument name="barcodeType" type="String" required="false" default="3of9" />
		<cfargument name="destinationPath" type="String" required="false" default="" />
		<cfargument name="barcodeImage" type="String" required="false" default="jpg" />
		<cfargument name="resolution" type="Numeric" required="false" default="100" />
		<cfargument name="barWidth" type="Numeric" required="false" default="1" />
		<cfargument name="barHeight" type="Numeric" required="false" default="50" />
		<cfargument name="drawingText" type="boolean" required="false" default="false" />
		<cfscript>
		var factory = createObject('component','testCf.barcode.factory.BarcodeFactory' ).init();
		
		variables.barbecue = factory.createBarbecue( argumentCollection=arguments );
		variables.zxing = factory.createZxing( argumentCollection=arguments );
		</cfscript>
		<cfreturn this />
	</cffunction>
	
	<cffunction name="createBarcodeImageFile" access="public" returntype="void" output="false" >
		<cfargument name="code" type="String" required="true" />
		<cfargument name="checkSum" type="boolean" required="false" default="true" />
		<cfargument name="destinationPath" type="String" required="false" default="" />
		<cfargument name="fileName" type="String" required="false" default="" hint="The code is default filename" />
		<cfargument name="label" type="boolean" required="false" default="true" />
		<cfset variables.barbecue.createBarcodeImageFile( argumentCollection=arguments ) />
	</cffunction>
	
	<cffunction name="getBarcodeByteArray" access="public" returntype="binary" output="false" >
		<cfargument name="code" type="String" required="true" />
		<cfargument name="checkSum" type="boolean" required="false" default="true" />
		<cfargument name="label" type="boolean" required="false" default="true" />
		<cfreturn variables.barbecue.getBarcodeByteArray( argumentCollection=arguments ) />
	</cffunction>
	
	<cffunction name="writeQRCode" access="public" output="false" returntype="Any" hint="Use cfimage write to browser.">
		<cfargument name="text" type="string" required="true" />
		<cfargument name="width" type="numeric" required="false" default="200" />
		<cfargument name="height" type="numeric" required="false" default="200" />
		<cfreturn variables.zxing.writeQRCode( argumentCollection=arguments ) />
	</cffunction>
	
	<cffunction name="readQRCode" access="public" output="false" returntype="String">
		<cfargument name="image" type="string" required="true" />
		<cfreturn variables.zxing.readQRCode( argumentCollection=arguments ) />
	</cffunction>

</cfcomponent>