#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "usbdmx/usbdmx.h"


MODULE = USB::FX5DMX		PACKAGE = USB::FX5DMX		

int
ThisIsWorking()
	CODE:
		RETVAL = 1;
	OUTPUT:
		RETVAL

AV*
GetInterfaces()
	CODE:
		RETVAL = newAV();
		fprintf(stderr, "[XS] Calling GetAllConnectedInterfaces\n");
		//TSERIALLIST* result = malloc(sizeof(TSERIALLIST));
		TSERIALLIST result;
		GetAllConnectedInterfaces(&result);
		fprintf(stderr, "[XS] Loaded all connected interfaces\n");
		
		char* serialList[16];
		char emptySerial[16];

		memset(&emptySerial, '0', 16);

		for(int i = 0; i < 15; i++) {
			char serial[17];
			memcpy(serial, result[i], 16);
			serial[16] = '\0';
			serialList[i] = serial;
			fprintf(stderr, "[XS] Found Serial: %s\n", serial);
		}
	OUTPUT:
		RETVAL

AV*
GetArrayBack()
	CODE:
		AV* out = newAV();
		for(int i = 0; i < 5; i++) {
			SV* value = newSViv(i);
			av_push(out, value);
		}

		size_t size_RETVAL = 6;
		RETVAL = out;
	OUTPUT:
		RETVAL
