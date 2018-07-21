# cf_java_error_repro
I'm working with the PDFBox Java library and encountered the following different behavior between Lucee and ACF.

The code in this repository works fine in Lucee (generating a new PDF in the output folder).

In ACF, it throws an error: "No output specified "

```cfc
serializer = createObject( 'java', 'org.apache.xmpbox.xml.XmpSerializer' );
baos = createObject( 'java', 'java.io.ByteArrayOutputStream' );

serializer.serialize( metadata, baos, true ); //THIS IS THE LINE THAT ERRORS

metadataStream = createObject( 'java', 'org.apache.pdfbox.pdmodel.common.PDMetadata' ).init( doc );
metadataStream.importXMPMetadata( baos.toByteArray() );
```

Any insight into this behavior would be greatly appreciated it!
