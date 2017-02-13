#define PERL_NO_GET_CONTEXT
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include "usbdmx/usbdmx.h"



MODULE = USB::FX5DMX		PACKAGE = USB::FX5DMX		

AV*
GetInterfaces()
	CODE:
		RETVAL = newAV();
		fprintf(stderr, "[XS] Calling GetAllConnectedInterfaces\n");
		//TSERIALLIST* result = malloc(sizeof(TSERIALLIST));
		TSERIALLIST result;
		GetAllConnectedInterfaces(&result);
		fprintf(stderr, "[XS] Loaded all connected interfaces\n");
		
		char emptySerial[17];
		memset(&emptySerial, '0', 17);
		emptySerial[16] = '\0';

		for(int i = 0; i < 16; i++) {
			char serial[17];
			memcpy(serial, result[i], 16);
			serial[16] = '\0';

			int compareResult = strncmp(serial, emptySerial, 16);
			// Valid serial found, store
			if(compareResult != 0) {
				SV* value = newSVpv(serial, 16); // copy serial
				av_push(RETVAL, value);
			}

			fprintf(stderr, "[XS] Found Serial: %s\n", serial);
		}
	OUTPUT:
		RETVAL

