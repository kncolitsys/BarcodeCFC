<cfcomponent hint="Barbecue is an open-source, Java library that provides the means to create barcodes 
					for printing and display in Java applications. A number of barcode formats are 
					supported and many more can be added via the flexible barcode API. Barcodes can 
					be output to three different image formats (PNG, GIF, JPEG), used as a Swing 
					component, or written out as SVG.">

	<cfproperty name="barcodeType" type="String" required="false" default="3of9" />
	<cfproperty name="barcodeImage" type="String" required="false" default="jpg" />
	<cfproperty name="resolution" type="Numeric" required="false" default="100" />
	<cfproperty name="barWidth" type="Numeric" required="false" default="1" />
	<cfproperty name="barHeight" type="Numeric" required="false" default="50" />
	<cfproperty name="drawingText" type="boolean" required="false" default="false" />

	<cffunction name="init" access="public" returntype="Barbecue" output="false" >
		<cfargument name="javaLoader" type="Component" required="true" hint="Javaloader instance initialized with barbeque jar library" />
		<cfargument name="barcodeType" type="String" required="false" default="3of9" />
		<cfargument name="destinationPath" type="String" required="false" default="" />
		<cfargument name="barcodeImage" type="String" required="false" default="jpg" />
		<cfargument name="resolution" type="Numeric" required="false" default="100" />
		<cfargument name="barWidth" type="Numeric" required="false" default="1" />
		<cfargument name="barHeight" type="Numeric" required="false" default="50" />
		<cfargument name="drawingText" type="boolean" required="false" default="false" />
		<cfscript>
		// private properties
		variables.loader = arguments.javaLoader;
		variables.BarcodeImageHandler = variables.loader.create( "net.sourceforge.barbecue.BarcodeImageHandler" );
		variables.destinationPath = arguments.destinationPath;
		// public properties
		this.resolution = arguments.resolution;
		this.barWidth = arguments.barWidth;
		this.barHeight = arguments.barHeight;
		this.drawingText = false;
		this.barcodeType = arguments.barcodeType;
		this.barcodeImage = arguments.barcodeImage;
		</cfscript>
		<cfreturn this />
	</cffunction>
	
	<cffunction name="createBarcodeImageFile" access="public" returntype="void" output="false" >
		<cfargument name="code" type="String" required="true" />
		<cfargument name="checkSum" type="boolean" required="false" default="true" />
		<cfargument name="destinationPath" type="String" required="false" default="#variables.destinationPath#" />
		<cfargument name="fileName" type="String" required="false" default="" hint="The code is default filename" />
		<cfargument name="label" type="boolean" required="false" default="true" />
		
		<cfscript>
		var myBarcodeobj = createBarcodeObj( arguments.code, arguments.checkSum, arguments.label );
		var Image = variables.BarcodeImageHandler.getImage( myBarcodeobj );
		var ImageIO = createObject("Java", "javax.imageio.ImageIO");
		var OutputStream = createObject("Java", "java.io.FileOutputStream");
		
		if( not len(arguments.fileName) ){
		
			arguments.fileName = hash( arguments.code );
		
		}
		
		OutputStream.init( arguments.destinationPath & arguments.fileName & "." & this.barcodeImage );
		ImageIO.write( Image, this.barcodeImage, OutputStream );
		Image.flush();
		OutputStream.close();
		</cfscript>
	</cffunction>
	
	<cffunction name="getBarcodeByteArray" access="public" returntype="binary" output="false" >
		<cfargument name="code" type="String" required="true" />
		<cfargument name="checkSum" type="boolean" required="false" default="true" />
		<cfargument name="label" type="boolean" required="false" default="true" />
		<cfscript>
		var outStream = createObject("java", "java.io.ByteArrayOutputStream" ).init();
		var myBarcodeobj = createBarcodeObj( arguments.code, arguments.checkSum, arguments.label );
		var bufferedImage = "";
		
		
		switch( this.barcodeImage ){
		
			case "jpg":{
			
				bufferedImage = variables.BarcodeImageHandler.writeJPEG( myBarcodeobj, outStream );
			
			}
			case "png":{
			
				bufferedImage = variables.BarcodeImageHandler.writePNG( myBarcodeobj, outStream );
			
			}
			case "gif":{
			
				bufferedImage = variables.BarcodeImageHandler.writeGIF( myBarcodeobj, outStream );
			
			}	
		
		}
		
		</cfscript>
		<cfset getPageContext().getOut().clearBuffer()>
		<cfreturn outstream.toByteArray() />
	</cffunction>
	
	<cffunction name="createBarcodeObj" access="private" returntype="Any">
		<cfargument name="code" type="String" required="true" />
		<cfargument name="checkSum" type="boolean" required="true"/>
		<cfargument name="label" type="boolean" required="true" />
		<cfscript>
		var factory = variables.loader.create( "net.sourceforge.barbecue.BarcodeFactory" );
		var barcode = "";
		
		switch( this.barcodeType ){
			
			case "2of7": {

				barcode = factory.create2of7( arguments.code );
				break;
			}
			case "3of9": {
			
				barcode = factory.create3of9( arguments.code, arguments.checkSum );
				break;
			}
			case "Bookland": {
			
				barcode = factory.createBookland( arguments.code );
				break;
			}
			case "Codabar": {
			
				barcode = factory.createCodabar( arguments.code );
				break;
			}
			case "Code128": {
			
				barcode = factory.createCode128( arguments.code );
				break;
			}
			case "Code128A": {
			
				barcode = factory.createCode128A( arguments.code );
				break;
			}
			case "Code128B": {
			
				barcode = factory.createCode128B( arguments.code );
				break;
			}
			case "Code128C": {
			
				barcode = factory.createCode128C( arguments.code );
				break;
			}
			case "Code39": {
			
				barcode = factory.createCode39( arguments.code, arguments.checkSum );
				break;
			}
			case "EAN128": {
			
				barcode = factory.createEAN128( arguments.code );
				break;
			}
			case "EAN13": {
			
				barcode = factory.createEAN13( arguments.code );
				break;
			}
			case "GlobalTradeItemNumber": {
			
				barcode = factory.createGlobalTradeItemNumber( arguments.code );
				break;
			}
			case "Int2of5": {
			
				barcode = factory.createInt2of5( arguments.code, arguments.checkSum );
				break;
			}
			case "Monarch": {
			
				barcode = factory.createMonarch( arguments.code );
				break;
			}
			case "NW7": {
			
				barcode = factory.createNW7( arguments.code );
				break;
			}
			case "PDF417": {
			
				barcode = factory.createPDF417( arguments.code );
				break;
			}
			case "PostNet": {
			
				barcode = factory.createPostNet( arguments.code );
				break;
			}
			case "RandomWeightUPCA": {
			
				barcode = factory.createRandomWeightUPCA( arguments.code );
				break;
			}
			case "SCC14ShippingCode": {
			
				barcode = factory.createSCC14ShippingCode( arguments.code );
				break;
			}
			case "ShipmentIdentificationNumber": {
			
				barcode = factory.createShipmentIdentificationNumber( arguments.code );
				break;
			}
			case "SSCC18": {
			
				barcode = factory.createSSCC18( arguments.code );
				break;
			}
			case "Std2of5": {
			
				barcode = factory.createStd2of5( arguments.code, arguments.checkSum );
				break;
			}
			case "UCC128": {
			
				barcode = factory.createUCC128( arguments.code );
				break;
			}
			case "UPCA": {
			
				barcode = factory.createUPCA( arguments.code );
				break;
			}
			case "USD3": {
			
				barcode = factory.createUSD3( arguments.code, arguments.checkSum );
				break;
			}
			case "USD4": {
			
				barcode = factory.createUSD4( arguments.code );
				break;
			}
			case "USPS": {
			
				barcode = factory.createUSPS( arguments.code );
				break;
			}
			case "parseEAN128": {
			
				barcode = factory.parseEAN128( arguments.code );
				break;
			}
			
		}
		
		barcode.setResolution( this.resolution );
		
		barcode.setBarWidth( this.barWidth );
		
		barcode.setBarHeight( this.barHeight );
		
		barcode.setDrawingText( this.drawingText );
		
		if( arguments.label ){
		
			barcode.setLabel( arguments.code );
		
		}
		
		return barcode;
		</cfscript>
	</cffunction>
	
</cfcomponent>