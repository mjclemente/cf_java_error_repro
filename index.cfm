<cfscript>
  originalPdf = 'testing.pdf';

  fileInputStream = createObject( "java", "java.io.FileInputStream" ).init(
    javaCast( "string", expandPath( "./pdfs/#originalPdf#" ) )
  );

  reader = createObject( 'java', 'org.apache.pdfbox.pdmodel.PDDocument' );
  doc = reader.load( fileInputStream );

  XMPMetadata = createObject( 'java', 'org.apache.xmpbox.XMPMetadata' );
  metadata = XMPMetadata.createXMPMetadata();
  dcSchema = metadata.createAndAddDublinCoreSchema();
  doc.getDocumentInformation().setTitle( "Fake Title" );
  dcSchema.setTitle( 'Fake Title' );
  doc.getDocumentInformation().setAuthor( "Pachyderm" );
  dcSchema.addCreator( "Pachyderm" );
  doc.getDocumentInformation().setSubject( "Hoping this works" );
  dcSchema.setDescription( 'Hoping this works' );

  serializer = createObject( 'java', 'org.apache.xmpbox.xml.XmpSerializer' );
  baos = createObject( 'java', 'java.io.ByteArrayOutputStream' );
  serializer.serialize( metadata, baos, true );
  metadataStream = createObject( 'java', 'org.apache.pdfbox.pdmodel.common.PDMetadata' ).init( doc );
  metadataStream.importXMPMetadata( baos.toByteArray() );
  doc.getDocumentCatalog().setMetadata( metadataStream );

  doc.save( expandPath( "./output/cleaned-#originalPdf#" ) );
  doc.close();
</cfscript>