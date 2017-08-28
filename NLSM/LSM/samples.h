static const unsigned int sample0_sz = 5;

inline void sample0_dimensions(std::vector<unsigned int>* sis, std::vector<unsigned int>* sos, std::vector<unsigned int>* os)
{
	*sis = std::vector<unsigned int>(sample0_sz);
	*sos = std::vector<unsigned int>(sample0_sz);
	*os = std::vector<unsigned int>(sample0_sz);
}

inline void sample0_statics(std::vector<unsigned int>* sis, std::vector<unsigned int>* sos)
{
	(*sis)[0] = 0;
	(*sis)[1] = 1;
	(*sis)[2] = 2;
	(*sis)[3] = 3;
	(*sis)[4] = 4;
	
	(*sos)[0] = 0;
	(*sos)[1] = 2;
	(*sos)[2] = 4;
	(*sos)[3] = 6;
	(*sos)[4] = 8;
}

inline unsigned int load_sample(std::vector<unsigned int>* sis, std::vector<unsigned int>* sos, std::vector<unsigned int>* os, unsigned int sample_number)
{
	switch (sample_number)
	{
		case 0:
			sample0_dimensions(sis, sos, os);
			sample0_statics(sis, sos);
			return sample0_sz;
			
		default:
			break;
	}
	
	printf("Fatal error, uninitialized sample requested\n");
	exit(36);
	return -1;
}