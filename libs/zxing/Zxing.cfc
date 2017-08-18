<cfcomponent output="false" hint="zxing wrapper for coldfusion version 0.1">

	<cffunction name="init" access="public" output="false" returntype="Component">
		<cfargument name="javaLoader" type="Component" required="true" />
		
		<cfset variables.javaLoader = arguments.javaLoader />
		<cfset variables.BarcodeFormat = arguments.javaLoader.create("com.google.zxing.BarcodeFormat") />
    	<cfset variables.QRCodeWriter = arguments.javaLoader.create("com.google.zxing.qrcode.QRCodeWriter").init() />
    	
   		<cfset variables.converter = arguments.javaLoader.create("com.google.zxing.client.j2se.MatrixToImageWriter") />
		<cfreturn this/>
	</cffunction>
	
	<cffunction name="writeQRCode" access="public" output="false" returntype="Any">
		<cfargument name="text" type="string" required="true" />
		<cfargument name="width" type="numeric" required="false" default="200" />
		<cfargument name="height" type="numeric" required="false" default="200" />
		
		<cfset var bitMatrix = variables.QRCodeWriter.encode( arguments.text, variables.BarcodeFormat.QR_CODE, arguments.width, arguments.height ) />
		<cfset var bufferedImage = variables.converter.toBufferedImage( bitMatrix ) />
    	<cfset var img = imageNew( bufferedImage ) />
		
		<!--- fix imageNegative bug --->
		<cfset imageGrayscale( img ) />
		<cfset imageNegative( img ) />
		
		<cfreturn img />
	</cffunction>
	
	<cffunction name="readQRCode" access="public" output="false" returntype="String">
		<cfargument name="image" type="string" required="true" />
		<cfset var img = imageRead( arguments.image ) />
		<cfset var buff = ImageGetBufferedImage( img ) />
    	<cfset var source = variables.javaLoader.create("com.google.zxing.client.j2se.BufferedImageLuminanceSource").init( buff ) />
    	<cfset var binarizer = variables.javaLoader.create("com.google.zxing.common.GlobalHistogramBinarizer").init( source ) />
    	<cfset var bitmap = variables.javaLoader.create("com.google.zxing.BinaryBitmap").init( binarizer ) />
    	<cfset var reader = variables.javaLoader.create("com.google.zxing.qrcode.QRCodeReader").init() />
    	<cfset var decodedResult = reader.decode( bitmap, javacast("null", "")) />
		
		<cfreturn decodedResult.getText() />
	</cffunction>

</cfcomponent>