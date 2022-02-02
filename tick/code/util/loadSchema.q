/load schema
schemaDir:hsym `$getenv `SCHEMADIR;
/load each schema inside it
schemas:key schemaDir;
{system "l ",string  x} each ` sv'  schemaDir,'schemas;
