#ifndef IPHONE
#define IMPLEMENT_API
#endif

#include <hx/CFFI.h>
#include "iOSNative.h"
#include <stdio.h>

using namespace iosnative;


static value iOSNative_get_app_dir () 
{
	
	return alloc_string ( getAppDir() );
	
}
DEFINE_PRIM ( iOSNative_get_app_dir, 0 );

static void iOSNative_make_callback( char* strdir ){
       //val_call1(*function_callback,alloc_string(strdir));
}
DEFINE_PRIM ( iOSNative_make_callback, 1 );
static void iOSNative_init_gallery (value f) 
{
	initAppGallery(f);
	
}
DEFINE_PRIM ( iOSNative_init_gallery, 1 );

static void iOSNative_init_camera (value f) 
{
	initAppCamera(f);
	
}
DEFINE_PRIM ( iOSNative_init_camera, 1 );

static value iOSNative_check_app_directory () 
{
	return alloc_bool ( checkAppDirectory() );
	
}
DEFINE_PRIM ( iOSNative_check_app_directory, 0 );


extern "C" void iOSNative_main() 
{
	
	// Here you could do some initialization, if needed
	
}
DEFINE_ENTRY_POINT( iOSNative_main );

extern "C" int iOSNative_register_prims () { return 0; }
