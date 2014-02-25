namespace iosnative 
{ // Start namespace ios_Native.
	
	const char* getAppDir ();	
	
	const void initAppGallery(value f);
	
	const void initAppCamera(value f);

	const bool checkAppDirectory ();
	
	const void call_callback(const char* strdir);
} // End namespace ios_Native.
