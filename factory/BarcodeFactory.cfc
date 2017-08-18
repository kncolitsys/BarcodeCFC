<cfcomponent output="false">

	<cfset variables.STATIC = {} />
	<cfset variables.STATIC.LIBS = [] />
	
	<cfset arrayAppend( variables.STATIC.LIBS, expandPath( 'libs/barbecue/barbecue-1.5-beta1.jar' ) ) />
	<cfset arrayAppend( variables.STATIC.LIBS, expandPath( 'libs/zxing/core.jar'  ) ) />
	<cfset arrayAppend( variables.STATIC.LIBS, expandPath( 'libs/zxing/javase.jar'  ) ) />

	<cffunction name="init" access="public" returntype="Component">
		<cfset variables.loader = createObject("component", "barcode.javaloader.JavaLoader").init( variables.STATIC.LIBS ) />
		<cfreturn this />
	</cffunction>
	
	<cffunction name="createBarbecue" access="public" returntype="Component">
		<cfargument name="barcodeType" type="String" required="false" default="3of9" />
		<cfargument name="destinationPath" type="String" required="false" default="" />
		<cfargument name="barcodeImage" type="String" required="false" default="jpg" />
		<cfargument name="resolution" type="Numeric" required="false" default="100" />
		<cfargument name="barWidth" type="Numeric" required="false" default="1" />
		<cfargument name="barHeight" type="Numeric" required="false" default="50" />
		<cfargument name="drawingText" type="boolean" required="false" default="false" />
		
		<cfset arguments.javaLoader = variables.loader />
		
		<cfreturn createObject( 'component', 'barcode.libs.barbecue.Barbecue' ).init( argumentCollection=arguments ) />
	</cffunction>
	
	<cffunction name="createZxing" access="public" returntype="Component">
		<cfset arguments.javaLoader = variables.loader />
		
		<cfreturn createObject( 'component', 'barcode.libs.zxing.Zxing' ).init( argumentCollection=arguments ) />
	</cffunction>
	

</cfcomponent>